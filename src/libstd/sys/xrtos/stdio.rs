use crate::convert::TryInto;
use crate::io::{self, IoSlice, IoSliceMut};
use crate::mem::ManuallyDrop;
use crate::sys::fd::FileDesc; // I hate c devs so fucking much

use libesp as libc;

pub struct Stdin(());
pub struct Stdout(());
pub struct Stderr(());

impl Stdin {
    pub fn new() -> io::Result<Stdin> {
        Ok(Stdin(()))
    }
}

impl io::Read for Stdin {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        ManuallyDrop::new(FileDesc::new(libc::STDIN_FILENO.try_into().unwrap())).read(buf)
    }

    fn read_vectored(&mut self, bufs: &mut [IoSliceMut<'_>]) -> io::Result<usize> {
        ManuallyDrop::new(FileDesc::new(libc::STDIN_FILENO.try_into().unwrap())).read_vectored(bufs)
    }
}

impl Stdout {
    pub fn new() -> io::Result<Stdout> {
        Ok(Stdout(()))
    }
}

impl io::Write for Stdout {
    fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
        ManuallyDrop::new(FileDesc::new(libc::STDOUT_FILENO.try_into().unwrap())).write(buf)
    }

    fn write_vectored(&mut self, bufs: &[IoSlice<'_>]) -> io::Result<usize> {
        ManuallyDrop::new(FileDesc::new(libc::STDOUT_FILENO.try_into().unwrap()))
            .write_vectored(bufs)
    }

    fn flush(&mut self) -> io::Result<()> {
        Ok(())
    }
}

impl Stderr {
    pub fn new() -> io::Result<Stderr> {
        Ok(Stderr(()))
    }
}

impl io::Write for Stderr {
    fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
        ManuallyDrop::new(FileDesc::new(libc::STDERR_FILENO.try_into().unwrap())).write(buf)
    }

    fn write_vectored(&mut self, bufs: &[IoSlice<'_>]) -> io::Result<usize> {
        ManuallyDrop::new(FileDesc::new(libc::STDERR_FILENO.try_into().unwrap()))
            .write_vectored(bufs)
    }

    fn flush(&mut self) -> io::Result<()> {
        Ok(())
    }
}

pub fn is_ebadf(err: &io::Error) -> bool {
    err.raw_os_error() == Some(libc::EBADF as i32)
}

pub const STDIN_BUF_SIZE: usize = crate::sys_common::io::DEFAULT_BUF_SIZE;

pub fn panic_output() -> Option<impl io::Write> {
    Stderr::new().ok()
}
