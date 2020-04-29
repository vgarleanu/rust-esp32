//! Runtime services
//!
//! The `rt` module provides a narrow set of runtime services,
//! including the global heap (exported in `heap`) and unwinding and
//! backtrace support. The APIs in this module are highly unstable,
//! and should be considered as private implementation details for the
//! time being.

#![unstable(
    feature = "rt",
    reason = "this public module should not exist and is highly likely \
              to disappear",
    issue = "none"
)]
#![doc(hidden)]

// Re-export some of our utilities which are expected by other crates.
use crate::fmt;
pub use crate::panicking::{begin_panic, begin_panic_fmt, update_panic_count};
use crate::sys::process;

#[cfg(target_arch = "xtensa")]
#[cfg_attr(not(test), lang = "termination")]
#[unstable(feature = "termination_trait_lib", issue = "43301")]
#[rustc_on_unimplemented(
    message = "`main` has invalid return type `{Self}`",
    label = "`main` can only return types that implement `{Termination}`"
)]
pub trait Termination {
    /// Is called to get the representation of the value as status code.
    /// This status code is returned to the operating system.
    fn report(self) -> i32;
}

#[cfg(target_arch = "xtensa")]
#[unstable(feature = "termination_trait_lib", issue = "43301")]
impl Termination for () {
    #[inline]
    fn report(self) -> i32 {
        ExitCode::SUCCESS.report()
    }
}

#[cfg(target_arch = "xtensa")]
#[unstable(feature = "termination_trait_lib", issue = "43301")]
impl Termination for ! {
    fn report(self) -> i32 {
        self
    }
}

#[cfg(target_arch = "xtensa")]
#[unstable(feature = "termination_trait_lib", issue = "43301")]
impl Termination for ExitCode {
    #[inline]
    fn report(self) -> i32 {
        self.0.as_i32()
    }
}

#[cfg(target_arch = "xtensa")]
#[derive(Clone, Copy, Debug)]
#[unstable(feature = "process_exitcode_placeholder", issue = "48711")]
pub struct ExitCode(process::ExitCode);

#[cfg(target_arch = "xtensa")]
#[unstable(feature = "process_exitcode_placeholder", issue = "48711")]
impl ExitCode {
    /// The canonical ExitCode for successful termination on this platform.
    ///
    /// Note that a `()`-returning `main` implicitly results in a successful
    /// termination, so there's no need to return this from `main` unless
    /// you're also returning other possible codes.
    #[unstable(feature = "process_exitcode_placeholder", issue = "48711")]
    pub const SUCCESS: ExitCode = ExitCode(process::ExitCode::SUCCESS);

    /// The canonical ExitCode for unsuccessful termination on this platform.
    ///
    /// If you're only returning this and `SUCCESS` from `main`, consider
    /// instead returning `Err(_)` and `Ok(())` respectively, which will
    /// return the same codes (but will also `eprintln!` the error).
    #[unstable(feature = "process_exitcode_placeholder", issue = "48711")]
    pub const FAILURE: ExitCode = ExitCode(process::ExitCode::FAILURE);
}

// To reduce the generated code of the new `lang_start`, this function is doing
// the real work.
#[cfg(not(test))]
fn lang_start_internal(
    main: &(dyn Fn() -> i32 + Sync + crate::panic::RefUnwindSafe),
    argc: isize,
    argv: *const *const u8,
) -> isize {
    use crate::panic;
    use crate::sys;
    use crate::sys_common;
    use crate::sys_common::thread_info;
    use crate::thread::Thread;

    sys::init();

    unsafe {
        let main_guard = sys::thread::guard::init();
        sys::stack_overflow::init();

        // Next, set up the current Thread with the guard information we just
        // created. Note that this isn't necessary in general for new threads,
        // but we just do this to name the main thread and to give it correct
        // info about the stack bounds.
        let thread = Thread::new(Some("main".to_owned()));
        thread_info::set(main_guard, thread);

        // Store our args if necessary in a squirreled away location
        #[cfg(not(target_arch = "xtensa"))]
        sys::args::init(argc, argv);

        // Let's run some code!
        let exit_code = panic::catch_unwind(|| {
            sys_common::backtrace::__rust_begin_short_backtrace(move || main())
        });

        sys_common::cleanup();
        exit_code.unwrap_or(101) as isize
    }
}

#[cfg(not(test))]
#[cfg(not(target_arch = "xtensa"))]
#[lang = "start"]
fn lang_start<T: crate::process::Termination + 'static>(
    main: fn() -> T,
    argc: isize,
    argv: *const *const u8,
) -> isize {
    lang_start_internal(&move || main().report(), argc, argv)
}

#[cfg(not(test))]
#[cfg(target_arch = "xtensa")]
#[lang = "start"]
fn lang_start<T: Termination + 'static>(
    main: fn() -> T,
    argc: isize,
    argv: *const *const u8,
) -> isize {
    lang_start_internal(&move || main().report(), argc, argv)
}
