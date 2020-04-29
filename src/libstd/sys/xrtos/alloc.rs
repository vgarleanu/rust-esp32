use crate::alloc::{GlobalAlloc, Layout, System};
use crate::convert::TryInto;
use crate::ptr;
use crate::sys_common::alloc::{realloc_fallback, MIN_ALIGN};

use libesp as libc;

#[stable(feature = "alloc_system_type", since = "1.28.0")]
unsafe impl GlobalAlloc for System {
    #[inline]
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        // jemalloc provides alignment less than MIN_ALIGN for small allocations.
        // So only rely on MIN_ALIGN if size >= align.
        // Also see <https://github.com/rust-lang/rust/issues/45955> and
        // <https://github.com/rust-lang/rust/issues/62251#issuecomment-507580914>.
        if layout.align() <= MIN_ALIGN && layout.align() <= layout.size() {
            libc::malloc(layout.size().try_into().unwrap()) as *mut u8
        } else {
            aligned_malloc(&layout)
        }
    }

    #[inline]
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        // See the comment above in `alloc` for why this check looks the way it does.
        if layout.align() <= MIN_ALIGN && layout.align() <= layout.size() {
            libc::calloc(layout.size().try_into().unwrap(), 1) as *mut u8
        } else {
            let ptr = self.alloc(layout);
            if !ptr.is_null() {
                ptr::write_bytes(ptr, 0, layout.size());
            }
            ptr
        }
    }

    #[inline]
    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
        libc::free(ptr as *mut libc::c_void)
    }

    #[inline]
    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
        if layout.align() <= MIN_ALIGN && layout.align() <= new_size {
            // NOTE: This is probably very very bad
            libc::realloc(ptr as *mut libc::c_void, new_size.try_into().unwrap()) as *mut u8
        } else {
            realloc_fallback(self, ptr, layout, new_size)
        }
    }
}

#[inline]
unsafe fn aligned_malloc(layout: &Layout) -> *mut u8 {
    // NOTE: Unfortunately esp-idf doesnt fucking implement memalign or posix_memalign so we are
    // kinda fucked atm
    unimplemented!("memalign not supported");
}
