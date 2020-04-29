//! Implementation of `std::os` functionality for unix systems

#![allow(unused_imports)] // lots of cfg code here

use crate::os::unix::prelude::*;

use crate::convert::TryInto;
use crate::error::Error as StdError;
use crate::ffi::{CStr, CString, OsStr, OsString};
use crate::fmt;
use crate::io;
use crate::iter;
use crate::marker::PhantomData;
use crate::mem;
use crate::memchr;
use crate::path::{self, PathBuf};
use crate::ptr;
use crate::slice;
use crate::str;
use crate::sys::cvt;
use crate::sys::fd;
use crate::sys_common::mutex::{Mutex, MutexGuard};
use crate::sys_common::os_str_bytes::OsStrExt;
use crate::sys_common::os_str_bytes::OsStringExt;
use crate::vec;

// NOTE: We aliasing libc to libesp
use libesp::{self as libc, c_char, c_int, c_void};

const TMPBUF_SZ: usize = 128;

cfg_if::cfg_if! {
    if #[cfg(target_os = "redox")] {
        const PATH_SEPARATOR: u8 = b';';
    } else {
        const PATH_SEPARATOR: u8 = b':';
    }
}

/// Returns the platform-specific value of errno
#[cfg(not(target_os = "dragonfly"))]
pub fn errno() -> i32 {
    unsafe { (*libc::__errno()) as i32 }
}

#[cfg(target_os = "dragonfly")]
pub fn errno() -> i32 {
    extern "C" {
        #[thread_local]
        static errno: c_int;
    }

    unsafe { errno as i32 }
}

#[cfg(target_os = "dragonfly")]
pub fn set_errno(e: i32) {
    extern "C" {
        #[thread_local]
        static mut errno: c_int;
    }

    unsafe {
        errno = e;
    }
}

/// Gets a detailed string description for the given error number.
pub fn error_string(errno: i32) -> String {
    extern "C" {
        #[cfg_attr(any(target_os = "linux", target_env = "newlib"), link_name = "__xpg_strerror_r")]
        fn strerror_r(errnum: c_int, buf: *mut c_char, buflen: libc::size_t) -> c_int;
    }

    let mut buf = [0 as c_char; TMPBUF_SZ];

    let p = buf.as_mut_ptr();
    unsafe {
        if strerror_r(errno as c_int, p, buf.len().try_into().unwrap()) < 0 {
            panic!("strerror_r failure");
        }

        let p = p as *const _;
        str::from_utf8(CStr::from_ptr(p).to_bytes()).unwrap().to_owned()
    }
}

pub fn getcwd() -> io::Result<PathBuf> {
    let mut buf = Vec::with_capacity(512);
    loop {
        unsafe {
            let ptr = buf.as_mut_ptr() as *mut libc::c_char;
            if !libc::getcwd(ptr, buf.capacity().try_into().unwrap()).is_null() {
                let len = CStr::from_ptr(buf.as_ptr() as *const libc::c_char).to_bytes().len();
                buf.set_len(len);
                buf.shrink_to_fit();
                return Ok(PathBuf::from(OsString::from_vec(buf)));
            } else {
                let error = io::Error::last_os_error();
                if error.raw_os_error() != Some(libc::errno::ERANGE) {
                    return Err(error);
                }
            }

            // Trigger the internal buffer resizing logic of `Vec` by requiring
            // more space than the current capacity.
            let cap = buf.capacity();
            buf.set_len(cap);
            buf.reserve(1);
        }
    }
}

pub fn chdir(p: &path::Path) -> io::Result<()> {
    let p: &OsStr = p.as_ref();
    let p = CString::new(p.as_bytes())?;
    unsafe {
        match libc::chdir(p.as_ptr()) == (0 as c_int) {
            true => Ok(()),
            false => Err(io::Error::last_os_error()),
        }
    }
}

pub struct SplitPaths<'a> {
    iter: iter::Map<slice::Split<'a, u8, fn(&u8) -> bool>, fn(&'a [u8]) -> PathBuf>,
}

pub fn split_paths(unparsed: &OsStr) -> SplitPaths<'_> {
    fn bytes_to_path(b: &[u8]) -> PathBuf {
        PathBuf::from(<OsStr as OsStrExt>::from_bytes(b))
    }
    fn is_separator(b: &u8) -> bool {
        *b == PATH_SEPARATOR
    }
    let unparsed = unparsed.as_bytes();
    SplitPaths {
        iter: unparsed
            .split(is_separator as fn(&u8) -> bool)
            .map(bytes_to_path as fn(&[u8]) -> PathBuf),
    }
}

impl<'a> Iterator for SplitPaths<'a> {
    type Item = PathBuf;
    fn next(&mut self) -> Option<PathBuf> {
        self.iter.next()
    }
    fn size_hint(&self) -> (usize, Option<usize>) {
        self.iter.size_hint()
    }
}

#[derive(Debug)]
pub struct JoinPathsError;

pub fn join_paths<I, T>(paths: I) -> Result<OsString, JoinPathsError>
where
    I: Iterator<Item = T>,
    T: AsRef<OsStr>,
{
    let mut joined = Vec::new();

    for (i, path) in paths.enumerate() {
        let path = path.as_ref().as_bytes();
        if i > 0 {
            joined.push(PATH_SEPARATOR)
        }
        if path.contains(&PATH_SEPARATOR) {
            return Err(JoinPathsError);
        }
        joined.extend_from_slice(path);
    }
    Ok(OsStringExt::from_vec(joined))
}

impl fmt::Display for JoinPathsError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "path segment contains separator `{}`", PATH_SEPARATOR)
    }
}

impl StdError for JoinPathsError {
    #[allow(deprecated)]
    fn description(&self) -> &str {
        "failed to join paths"
    }
}

#[cfg(target_arch = "xtensa")]
pub fn current_exe() -> io::Result<PathBuf> {
    use crate::io::ErrorKind;
    Err(io::Error::new(ErrorKind::Other, "Not yet implemented!"))
}

pub struct Env {
    iter: vec::IntoIter<(OsString, OsString)>,
    _dont_send_or_sync_me: PhantomData<*mut ()>,
}

impl Iterator for Env {
    type Item = (OsString, OsString);
    fn next(&mut self) -> Option<(OsString, OsString)> {
        self.iter.next()
    }
    fn size_hint(&self) -> (usize, Option<usize>) {
        self.iter.size_hint()
    }
}

#[cfg(target_os = "macos")]
pub unsafe fn environ() -> *mut *const *const c_char {
    extern "C" {
        fn _NSGetEnviron() -> *mut *const *const c_char;
    }
    _NSGetEnviron()
}

#[cfg(not(target_os = "macos"))]
pub unsafe fn environ() -> *mut *const *const c_char {
    extern "C" {
        static mut environ: *const *const c_char;
    }
    &mut environ
}

pub unsafe fn env_lock() -> MutexGuard<'static> {
    // We never call `ENV_LOCK.init()`, so it is UB to attempt to
    // acquire this mutex reentrantly!
    static ENV_LOCK: Mutex = Mutex::new();
    ENV_LOCK.lock()
}

/// Returns a vector of (variable, value) byte-vector pairs for all the
/// environment variables of the current process.
pub fn env() -> Env {
    unsafe {
        let _guard = env_lock();
        let mut environ = *environ();
        let mut result = Vec::new();
        if !environ.is_null() {
            while !(*environ).is_null() {
                if let Some(key_value) = parse(CStr::from_ptr(*environ).to_bytes()) {
                    result.push(key_value);
                }
                environ = environ.add(1);
            }
        }
        return Env { iter: result.into_iter(), _dont_send_or_sync_me: PhantomData };
    }

    fn parse(input: &[u8]) -> Option<(OsString, OsString)> {
        // Strategy (copied from glibc): Variable name and value are separated
        // by an ASCII equals sign '='. Since a variable name must not be
        // empty, allow variable names starting with an equals sign. Skip all
        // malformed lines.
        if input.is_empty() {
            return None;
        }
        let pos = memchr::memchr(b'=', &input[1..]).map(|p| p + 1);
        pos.map(|p| {
            (
                OsStringExt::from_vec(input[..p].to_vec()),
                OsStringExt::from_vec(input[p + 1..].to_vec()),
            )
        })
    }
}

pub fn getenv(k: &OsStr) -> io::Result<Option<OsString>> {
    // environment variables with a nul byte can't be set, so their value is
    // always None as well
    let k = CString::new(k.as_bytes())?;
    unsafe {
        let _guard = env_lock();
        let s = libc::getenv(k.as_ptr()) as *const libc::c_char;
        let ret = if s.is_null() {
            None
        } else {
            Some(OsStringExt::from_vec(CStr::from_ptr(s).to_bytes().to_vec()))
        };
        Ok(ret)
    }
}

pub fn setenv(k: &OsStr, v: &OsStr) -> io::Result<()> {
    let k = CString::new(k.as_bytes())?;
    let v = CString::new(v.as_bytes())?;

    unsafe {
        let _guard = env_lock();
        cvt(libc::setenv(k.as_ptr(), v.as_ptr(), 1)).map(drop)
    }
}

pub fn unsetenv(n: &OsStr) -> io::Result<()> {
    let nbuf = CString::new(n.as_bytes())?;

    unsafe {
        let _guard = env_lock();
        cvt(libc::unsetenv(nbuf.as_ptr())).map(drop)
    }
}

pub fn page_size() -> usize {
    unsafe { libc::sysconf(libc::consts::_SC_PAGESIZE) as usize }
}

pub fn temp_dir() -> PathBuf {
    PathBuf::from("/tmp")
}

pub fn home_dir() -> Option<PathBuf> {
    // NOTE: esp-idf doesnt implement this, so we fallback to none
    None
}

pub fn exit(code: i32) -> ! {
    unsafe { libc::exit(code as c_int) }

    loop {}
}

pub fn getpid() -> u32 {
    unsafe { libc::getpid() as u32 }
}

pub fn getppid() -> u32 {
    unsafe { libc::getppid() as u32 }
}

#[cfg(target_env = "gnu")]
pub fn glibc_version() -> Option<(usize, usize)> {
    if let Some(Ok(version_str)) = glibc_version_cstr().map(CStr::to_str) {
        parse_glibc_version(version_str)
    } else {
        None
    }
}

#[cfg(target_env = "gnu")]
fn glibc_version_cstr() -> Option<&'static CStr> {
    weak! {
        fn gnu_get_libc_version() -> *const libc::c_char
    }
    if let Some(f) = gnu_get_libc_version.get() {
        unsafe { Some(CStr::from_ptr(f())) }
    } else {
        None
    }
}

// Returns Some((major, minor)) if the string is a valid "x.y" version,
// ignoring any extra dot-separated parts. Otherwise return None.
#[cfg(target_env = "gnu")]
fn parse_glibc_version(version: &str) -> Option<(usize, usize)> {
    let mut parsed_ints = version.split('.').map(str::parse::<usize>).fuse();
    match (parsed_ints.next(), parsed_ints.next()) {
        (Some(Ok(major)), Some(Ok(minor))) => Some((major, minor)),
        _ => None,
    }
}

#[cfg(all(test, target_env = "gnu"))]
mod test {
    use super::*;

    #[test]
    fn test_glibc_version() {
        // This mostly just tests that the weak linkage doesn't panic wildly...
        glibc_version();
    }

    #[test]
    fn test_parse_glibc_version() {
        let cases = [
            ("0.0", Some((0, 0))),
            ("01.+2", Some((1, 2))),
            ("3.4.5.six", Some((3, 4))),
            ("1", None),
            ("1.-2", None),
            ("1.foo", None),
            ("foo.1", None),
        ];
        for &(version_str, parsed) in cases.iter() {
            assert_eq!(parsed, parse_glibc_version(version_str));
        }
    }
}
