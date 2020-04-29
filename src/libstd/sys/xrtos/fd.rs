#![unstable(reason = "not public", issue = "none", feature = "fd")]

use crate::cmp;
use crate::convert::TryInto;
use crate::io::{self, Initializer, IoSlice, IoSliceMut, Read};
use crate::mem;
use crate::sync::atomic::{AtomicBool, Ordering};
use crate::sys::cvt;
use crate::sys_common::AsInner;

use libesp::{c_int, c_void, ssize_t};
// NOTE: We are aliasing libesp to libc to make shit easier
use libesp as libc;

#[derive(Debug)]
pub struct FileDesc {
    fd: c_int,
}

fn max_len() -> usize {
    // The maximum read limit on most posix-like systems is `SSIZE_MAX`,
    // with the man page quoting that if the count of bytes to read is
    // greater than `SSIZE_MAX` the result is "unspecified".
    //
    // On macOS, however, apparently the 64-bit libc is either buggy or
    // intentionally showing odd behavior by rejecting any read with a size
    // larger than or equal to INT_MAX. To handle both of these the read
    // size is capped on both platforms.
    if cfg!(target_os = "macos") {
        <c_int>::max_value() as usize - 1
    } else {
        <ssize_t>::max_value() as usize
    }
}

impl FileDesc {
    pub fn new(fd: c_int) -> FileDesc {
        FileDesc { fd }
    }

    pub fn raw(&self) -> c_int {
        self.fd
    }

    /// Extracts the actual file descriptor without closing it.
    pub fn into_raw(self) -> c_int {
        let fd = self.fd;
        mem::forget(self);
        fd
    }

    pub fn read(&self, buf: &mut [u8]) -> io::Result<usize> {
        let ret = cvt(unsafe {
            libc::read(
                self.fd,
                buf.as_mut_ptr() as *mut c_void,
                cmp::min(buf.len(), max_len()).try_into().unwrap(),
            )
        })?;
        Ok(ret as usize)
    }

    // NOTE: May cause UB since the definition of iovec is conflicting with lwip
    pub fn read_vectored(&self, bufs: &mut [IoSliceMut<'_>]) -> io::Result<usize> {
        let ret = cvt(unsafe {
            libc::readv(
                self.fd,
                bufs.as_ptr() as *mut libc::iovec,
                cmp::min(bufs.len(), c_int::max_value() as usize) as c_int,
            )
        })?;
        Ok(ret as usize)
    }

    pub fn read_to_end(&self, buf: &mut Vec<u8>) -> io::Result<usize> {
        let mut me = self;
        (&mut me).read_to_end(buf)
    }

    pub fn read_at(&self, buf: &mut [u8], offset: u64) -> io::Result<usize> {
        unsafe fn cvt_pread64(
            fd: c_int,
            buf: *mut c_void,
            count: u32,
            offset: i32,
        ) -> io::Result<isize> {
            use libc::pread as pread64;
            cvt(pread64(fd, buf, count, offset) as isize)
        }

        unsafe {
            cvt_pread64(
                self.fd,
                buf.as_mut_ptr() as *mut c_void,
                cmp::min(buf.len(), max_len()).try_into().unwrap(),
                offset.try_into().unwrap(),
            )
            .map(|n| n as usize)
        }
    }

    pub fn write(&self, buf: &[u8]) -> io::Result<usize> {
        let ret = cvt(unsafe {
            libc::write(
                self.fd,
                buf.as_ptr() as *const c_void,
                cmp::min(buf.len(), max_len()).try_into().unwrap(),
            )
        })?;
        Ok(ret as usize)
    }

    pub fn write_vectored(&self, bufs: &[IoSlice<'_>]) -> io::Result<usize> {
        let ret = cvt(unsafe {
            libc::writev(
                self.fd,
                bufs.as_ptr() as *mut libc::iovec,
                cmp::min(bufs.len(), c_int::max_value() as usize) as c_int,
            )
        })?;
        Ok(ret as usize)
    }

    // FIXME: maybe instead of a try_into unwrap actually just allow i32s to be passed as offsets?
    pub fn write_at(&self, buf: &[u8], offset: u64) -> io::Result<usize> {
        Ok(unsafe {
            libc::pwrite(
                self.fd,
                buf.as_ptr() as *const c_void,
                cmp::min(buf.len(), max_len()).try_into().unwrap(),
                offset.try_into().unwrap(),
            ) as usize
        })
    }

    pub fn get_cloexec(&self) -> io::Result<bool> {
        unsafe {
            Ok((cvt(libc::fcntl(self.fd, libc::consts::F_GETFD))? & libc::consts::FD_CLOEXEC) != 0)
        }
    }

    pub fn set_cloexec(&self) -> io::Result<()> {
        unsafe {
            let previous = cvt(libc::fcntl(self.fd, libc::consts::F_GETFD))?;
            let new = previous | libc::consts::FD_CLOEXEC;
            if new != previous {
                cvt(libc::fcntl(self.fd, libc::consts::F_SETFD, new))?;
            }
            Ok(())
        }
    }

    pub fn set_nonblocking(&self, nonblocking: bool) -> io::Result<()> {
        unsafe {
            let previous = cvt(libc::fcntl(self.fd, libc::consts::F_GETFL))?;
            let new = if nonblocking {
                previous | libc::consts::O_NONBLOCK
            } else {
                previous & !libc::consts::O_NONBLOCK
            };
            if new != previous {
                cvt(libc::fcntl(self.fd, libc::consts::F_SETFL, new))?;
            }
            Ok(())
        }
    }

    pub fn duplicate(&self) -> io::Result<FileDesc> {
        // We want to atomically duplicate this file descriptor and set the
        // CLOEXEC flag, and currently that's done via F_DUPFD_CLOEXEC. This
        // flag, however, isn't supported on older Linux kernels (earlier than
        // 2.6.24).
        //
        // To detect this and ensure that CLOEXEC is still set, we
        // follow a strategy similar to musl [1] where if passing
        // F_DUPFD_CLOEXEC causes `fcntl` to return EINVAL it means it's not
        // supported (the third parameter, 0, is always valid), so we stop
        // trying that.
        //
        // Also note that Android doesn't have F_DUPFD_CLOEXEC, but get it to
        // resolve so we at least compile this.
        //
        // [1]: http://comments.gmane.org/gmane.linux.lib.musl.general/2963
        use libc::consts::F_DUPFD as F_DUPFD_CLOEXEC;

        let make_filedesc = |fd| {
            let fd = FileDesc::new(fd);
            fd.set_cloexec()?;
            Ok(fd)
        };
        static TRY_CLOEXEC: AtomicBool = AtomicBool::new(!cfg!(target_os = "android"));
        let fd = self.raw();
        if TRY_CLOEXEC.load(Ordering::Relaxed) {
            match cvt(unsafe { libc::fcntl(fd, F_DUPFD_CLOEXEC, 0) }) {
                // We *still* call the `set_cloexec` method as apparently some
                // linux kernel at some point stopped setting CLOEXEC even
                // though it reported doing so on F_DUPFD_CLOEXEC.
                Ok(fd) => {
                    return Ok(if cfg!(target_os = "linux") {
                        make_filedesc(fd)?
                    } else {
                        FileDesc::new(fd)
                    });
                }
                Err(ref e) if e.raw_os_error() == Some(libc::errno::EINVAL) => {
                    TRY_CLOEXEC.store(false, Ordering::Relaxed);
                }
                Err(e) => return Err(e),
            }
        }
        cvt(unsafe { libc::fcntl(fd, libc::consts::F_DUPFD, 0) }).and_then(make_filedesc)
    }
}

impl<'a> Read for &'a FileDesc {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        (**self).read(buf)
    }

    #[inline]
    unsafe fn initializer(&self) -> Initializer {
        Initializer::nop()
    }
}

impl AsInner<c_int> for FileDesc {
    fn as_inner(&self) -> &c_int {
        &self.fd
    }
}

impl Drop for FileDesc {
    fn drop(&mut self) {
        // Note that errors are ignored when closing a file descriptor. The
        // reason for this is that if an error occurs we don't actually know if
        // the file descriptor was closed or not, and if we retried (for
        // something like EINTR), we might close another valid file descriptor
        // opened after we closed ours.
        let _ = unsafe { libc::close(self.fd) };
    }
}
