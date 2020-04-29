#![no_std]
#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]

// Some stuff not defined by esp-idf
pub const PTHREAD_STACK_MIN: usize = 4 * 1024;
pub const PTHREAD_MUTEX_INITIALIZER: pthread_mutex_t = 0;
pub const PTHREAD_CONDVAR_INITIALIZER: pthread_cond_t = 0;
pub const CLOCK_MONOTONIC: u32 = 4;

pub mod errno {
    pub const POLLIN: i16 = 1;
    pub const POLLHUP: i16 = 64;
    pub const POLLOUT: i16 = 8;

    pub const SO_ERROR: i32 = 4103;

    pub const EINPROGRESS: i32 = 119;
    pub const EWOULDBLOCK: i32 = 11;
    pub const EAGAIN: i32 = 11;
    pub const ERANGE: i32 = 34;
    pub const EINVAL: i32 = 22;
    pub const ETIMEDOUT: i32 = 116;
}

pub mod consts {
    pub const STDIN_FILENO: i32 = 0;
    pub const STDOUT_FILENO: i32 = 1;
    pub const STDERR_FILENO: i32 = 2;

    pub const AF_UNIX: i32 = 1;
    pub const AF_INET: i32 = 2;
    pub const AF_INET6: i32 = 10;

    pub const SOCK_STREAM: i32 = 1;
    pub const SOCK_DGRAM: i32 = 2;
    pub const SOCK_RAW: i32 = 3;

    pub const SO_REUSEADDR: i32 = 4;
    pub const SO_BROADCAST: i32 = 32;

    pub const IP_TTL: i32 = 2;
    pub const IPPROTO_IP: i32 = 0;
    pub const IPPROTO_RAW: i32 = 255;
    pub const IPPROTO_TCP: i32 = 6;
    pub const IPPROTO_UDP: i32 = 17;
    pub const IPPROTO_ICMP: i32 = 1;
    pub const IPPROTO_IPV6: i32 = 41;
    pub const IPPROTO_ICMPV6: i32 = 58;
    pub const IPPROTO_UDPLITE: i32 = 136;

    pub const IPV6_DROP_MEMBERSHIP: i32 = 13;
    pub const IPV6_ADD_MEMBERSHIP: i32 = 12;
    pub const IPV6_MULTICAST_LOOP: i32 = 770;
    pub const IPV6_V6ONLY: i32 = 27;

    pub const IP_DROP_MEMBERSHIP: i32 = 4;
    pub const IP_ADD_MEMBERSHIP: i32 = 3;
    pub const IP_MULTICAST_TTL: i32 = 5;
    pub const IP_MULTICAST_LOOP: i32 = 7;

    pub const _SC_PAGESIZE: i32 = 8;
    pub const SOL_SOCKET: i32 = 4095;
    pub const TCP_NODELAY: i32 = 1;

    pub const MSG_PEEK: i32 = 1;
    pub const MSG_NOSIGNAL: i32 = 32;

    pub const POLLOUT: i32 = 8;

    // MUTEX
    pub const PTHREAD_MUTEX_NORMAL: i32 = 0;
    pub const PTHREAD_MUTEX_RECURSIVE: i32 = 1;

    // FS
    pub const SEEK_SET: i32 = 0;
    pub const SEEK_END: i32 = 2;
    pub const SEEK_CUR: i32 = 1;

    pub const O_CREAT: i32 = 512;
    pub const O_TRUNC: i32 = 1024;
    pub const O_EXCL: i32 = 2048;
    pub const O_NONBLOCK: i32 = 16384;
    pub const O_RDONLY: i32 = 0;
    pub const O_WRONLY: i32 = 1;
    pub const O_RDWR: i32 = 2;
    pub const O_APPEND: i32 = 8;

    pub const F_DUPFD: i32 = 0;
    pub const F_GETFD: i32 = 1;
    pub const F_GETFL: i32 = 3;
    pub const F_SETFD: i32 = 2;
    pub const F_SETFL: i32 = 4;

    pub const FD_CLOEXEC: i32 = 1;

    // Socks NOTE: These are the LWIP versions not bsd/sock.h
    pub const SO_RCVTIMEO: i32 = 1;
    pub const SO_SNDTIMEO: i32 = 1;
}

pub mod types {
    pub const DT_REG: u8 = 1;
    pub const DT_DIR: u8 = 2;
}

pub mod std {
    //    pub use core::*;
    pub mod os {
        pub mod raw {
            pub type c_void = core::ffi::c_void;
            pub type c_uchar = u8;
            pub type c_schar = i8;
            pub type c_char = i8;
            pub type c_short = i16;
            pub type c_ushort = u16;
            pub type c_int = i32;
            pub type c_uint = u32;
            pub type c_long = i32;
            pub type c_ulong = u32;
            pub type c_longlong = i64;
            pub type c_ulonglong = u64;
            pub type c_float = f32;
            pub type c_double = f64;
            pub type c_uintptr_t = c_uint;
        }
    }
}

pub use self::std::os::raw::*;

//include!("atomic.rs");
include!("bindings.rs");
