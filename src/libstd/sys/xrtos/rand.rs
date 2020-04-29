use crate::slice;

pub fn hashmap_random_keys() -> (u64, u64) {
    let mut v = (0, 0);
    unsafe {
        let view =
            slice::from_raw_parts_mut(&mut v as *mut _ as *mut u8, crate::mem::size_of_val(&v));
        imp::fill_bytes(view);
    }
    v
}

#[cfg(target_arch = "xtensa")]
mod imp {
    pub fn fill_bytes(v: &mut [u8]) {
        // esp_random returns a u32 so we can just copy that into a 4 byte wide chunk
        for s in v.chunks_mut(4) {
            let r = unsafe { crate::mem::transmute::<u32, [u8; 4]>(libesp::esp_random()) };
            s[0] = r[0];
            s[1] = r[1];
            s[2] = r[2];
            s[3] = r[3];
        }
    }
}
