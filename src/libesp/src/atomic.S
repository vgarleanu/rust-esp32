	.file	"atomic.c"
	.text
	.align	4
	.global	rust_xtensa__sync_fetch_and_add_1
	.type	rust_xtensa__sync_fetch_and_add_1, @function
rust_xtensa__sync_fetch_and_add_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a5, a2, a4
	extui	a4, a2, 0, 2
	movi.n	a2, 8
	mull	a4, a4, a2
	movi	a2, 0xff
	ssl	a4
	sll	a6, a2
	movi.n	a2, -1
	xor	a9, a2, a6
	extui	a2, a3, 0, 8
	extui	a2, a2, 0, 8
	ssl	a4
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a2, a5, 0
.L2:
	mov.n	a3, a2
	add.n	a2, a3, a10
	and	a2, a2, a6
	and	a8, a3, a9
	or	a2, a8, a2
	wsr	a3, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a3, .L2
	ssr	a4
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_fetch_and_add_1, .-rust_xtensa__sync_fetch_and_add_1
	.align	4
	.global	rust_xtensa__sync_fetch_and_sub_1
	.type	rust_xtensa__sync_fetch_and_sub_1, @function
rust_xtensa__sync_fetch_and_sub_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a5, a2, a4
	extui	a4, a2, 0, 2
	movi.n	a2, 8
	mull	a4, a4, a2
	movi	a2, 0xff
	ssl	a4
	sll	a6, a2
	movi.n	a2, -1
	xor	a9, a2, a6
	extui	a2, a3, 0, 8
	extui	a2, a2, 0, 8
	ssl	a4
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a2, a5, 0
.L5:
	mov.n	a3, a2
	sub	a2, a3, a10
	and	a2, a2, a6
	and	a8, a3, a9
	or	a2, a8, a2
	wsr	a3, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a3, .L5
	ssr	a4
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_fetch_and_sub_1, .-rust_xtensa__sync_fetch_and_sub_1
	.align	4
	.global	rust_xtensa__sync_fetch_and_or_1
	.type	rust_xtensa__sync_fetch_and_or_1, @function
rust_xtensa__sync_fetch_and_or_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 8
	extui	a2, a2, 0, 8
	ssl	a5
	sll	a6, a2
	memw
	l32i.n	a2, a4, 0
.L8:
	mov.n	a3, a2
	or	a2, a3, a6
	wsr	a3, SCOMPARE1
	s32c1i	a2, a4, 0
	bne	a2, a3, .L8
	ssr	a5
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_fetch_and_or_1, .-rust_xtensa__sync_fetch_and_or_1
	.align	4
	.global	rust_xtensa__sync_fetch_and_and_1
	.type	rust_xtensa__sync_fetch_and_and_1, @function
rust_xtensa__sync_fetch_and_and_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a2, a2
	movi.n	a6, -1
	xor	a2, a6, a2
	extui	a4, a4, 0, 8
	extui	a4, a4, 0, 8
	ssl	a3
	sll	a4, a4
	xor	a6, a4, a2
	memw
	l32i.n	a2, a5, 0
.L11:
	mov.n	a4, a2
	and	a2, a4, a6
	wsr	a4, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a4, .L11
	ssr	a3
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_fetch_and_and_1, .-rust_xtensa__sync_fetch_and_and_1
	.align	4
	.global	rust_xtensa__sync_fetch_and_xor_1
	.type	rust_xtensa__sync_fetch_and_xor_1, @function
rust_xtensa__sync_fetch_and_xor_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 8
	extui	a2, a2, 0, 8
	ssl	a5
	sll	a6, a2
	memw
	l32i.n	a2, a4, 0
.L14:
	mov.n	a3, a2
	xor	a2, a3, a6
	wsr	a3, SCOMPARE1
	s32c1i	a2, a4, 0
	bne	a2, a3, .L14
	ssr	a5
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_fetch_and_xor_1, .-rust_xtensa__sync_fetch_and_xor_1
	.align	4
	.global	rust_xtensa__sync_fetch_and_nand_1
	.type	rust_xtensa__sync_fetch_and_nand_1, @function
rust_xtensa__sync_fetch_and_nand_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a6, a2
	movi.n	a2, -1
	xor	a2, a2, a6
	extui	a4, a4, 0, 8
	extui	a4, a4, 0, 8
	ssl	a3
	sll	a4, a4
	xor	a8, a4, a2
	memw
	l32i.n	a2, a5, 0
.L17:
	mov.n	a4, a2
	xor	a2, a4, a6
	and	a2, a2, a8
	wsr	a4, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a4, .L17
	ssr	a3
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_fetch_and_nand_1, .-rust_xtensa__sync_fetch_and_nand_1
	.align	4
	.global	rust_xtensa__sync_add_and_fetch_1
	.type	rust_xtensa__sync_add_and_fetch_1, @function
rust_xtensa__sync_add_and_fetch_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a8, a2
	movi.n	a2, -1
	xor	a9, a2, a8
	extui	a2, a4, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a4, a5, 0
.L20:
	mov.n	a2, a4
	add.n	a4, a2, a10
	and	a4, a4, a8
	and	a6, a2, a9
	or	a6, a6, a4
	mov.n	a4, a6
	wsr	a2, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a2, .L20
	ssr	a3
	srl	a2, a6
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_add_and_fetch_1, .-rust_xtensa__sync_add_and_fetch_1
	.align	4
	.global	rust_xtensa__sync_sub_and_fetch_1
	.type	rust_xtensa__sync_sub_and_fetch_1, @function
rust_xtensa__sync_sub_and_fetch_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a8, a2
	movi.n	a2, -1
	xor	a9, a2, a8
	extui	a2, a4, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a4, a5, 0
.L23:
	mov.n	a2, a4
	sub	a4, a2, a10
	and	a4, a4, a8
	and	a6, a2, a9
	or	a6, a6, a4
	mov.n	a4, a6
	wsr	a2, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a2, .L23
	ssr	a3
	srl	a2, a6
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_sub_and_fetch_1, .-rust_xtensa__sync_sub_and_fetch_1
	.align	4
	.global	rust_xtensa__sync_or_and_fetch_1
	.type	rust_xtensa__sync_or_and_fetch_1, @function
rust_xtensa__sync_or_and_fetch_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 8
	extui	a2, a2, 0, 8
	ssl	a5
	sll	a8, a2
	memw
	l32i.n	a3, a4, 0
.L26:
	mov.n	a2, a3
	or	a6, a2, a8
	mov.n	a3, a6
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	bne	a3, a2, .L26
	ssr	a5
	srl	a2, a6
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_or_and_fetch_1, .-rust_xtensa__sync_or_and_fetch_1
	.align	4
	.global	rust_xtensa__sync_and_and_fetch_1
	.type	rust_xtensa__sync_and_and_fetch_1, @function
rust_xtensa__sync_and_and_fetch_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a2, a3, a2
	movi	a3, 0xff
	ssl	a2
	sll	a3, a3
	movi.n	a6, -1
	xor	a3, a6, a3
	extui	a4, a4, 0, 8
	extui	a4, a4, 0, 8
	ssl	a2
	sll	a4, a4
	xor	a8, a4, a3
	memw
	l32i.n	a4, a5, 0
.L29:
	mov.n	a3, a4
	and	a6, a3, a8
	mov.n	a4, a6
	wsr	a3, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a3, .L29
	ssr	a2
	srl	a2, a6
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_and_and_fetch_1, .-rust_xtensa__sync_and_and_fetch_1
	.align	4
	.global	rust_xtensa__sync_xor_and_fetch_1
	.type	rust_xtensa__sync_xor_and_fetch_1, @function
rust_xtensa__sync_xor_and_fetch_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 8
	extui	a2, a2, 0, 8
	ssl	a5
	sll	a8, a2
	memw
	l32i.n	a3, a4, 0
.L32:
	mov.n	a2, a3
	xor	a6, a2, a8
	mov.n	a3, a6
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	bne	a3, a2, .L32
	ssr	a5
	srl	a2, a6
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_xor_and_fetch_1, .-rust_xtensa__sync_xor_and_fetch_1
	.align	4
	.global	rust_xtensa__sync_nand_and_fetch_1
	.type	rust_xtensa__sync_nand_and_fetch_1, @function
rust_xtensa__sync_nand_and_fetch_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a2, a3, a2
	movi	a3, 0xff
	ssl	a2
	sll	a8, a3
	movi.n	a3, -1
	xor	a3, a3, a8
	extui	a4, a4, 0, 8
	extui	a4, a4, 0, 8
	ssl	a2
	sll	a4, a4
	xor	a9, a4, a3
	memw
	l32i.n	a4, a5, 0
.L35:
	mov.n	a3, a4
	xor	a4, a3, a8
	and	a6, a4, a9
	mov.n	a4, a6
	wsr	a3, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a3, .L35
	ssr	a2
	srl	a2, a6
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_nand_and_fetch_1, .-rust_xtensa__sync_nand_and_fetch_1
	.align	4
	.global	rust_xtensa__sync_lock_test_and_set_1
	.type	rust_xtensa__sync_lock_test_and_set_1, @function
rust_xtensa__sync_lock_test_and_set_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s8i	a2, a7, 4
	l8ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a2, a2
	movi.n	a6, -1
	xor	a8, a6, a2
	extui	a2, a4, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a6, a2
	memw
	l32i.n	a2, a5, 0
.L38:
	mov.n	a4, a2
	and	a2, a4, a8
	or	a2, a2, a6
	wsr	a4, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a4, .L38
	ssr	a3
	srl	a2, a2
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_lock_test_and_set_1, .-rust_xtensa__sync_lock_test_and_set_1
	.align	4
	.global	rust_xtensa__sync_val_compare_and_swap_1
	.type	rust_xtensa__sync_val_compare_and_swap_1, @function
rust_xtensa__sync_val_compare_and_swap_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a4
	s8i	a3, a7, 4
	s8i	a2, a7, 8
	l8ui	a2, a7, 4
	mov.n	a8, a2
	l8ui	a2, a7, 8
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a2, a2
	movi.n	a6, -1
	xor	a6, a6, a2
	extui	a2, a8, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a9, a2
	extui	a2, a4, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a10, a2
	memw
	l32i.n	a2, a5, 0
	and	a2, a6, a2
.L41:
	or	a8, a9, a2
	or	a4, a10, a2
	wsr	a8, SCOMPARE1
	s32c1i	a4, a5, 0
	beq	a4, a8, .L42
	mov.n	a8, a2
	and	a2, a4, a6
	bne	a8, a2, .L41
.L42:
	ssr	a3
	srl	a2, a4
	extui	a2, a2, 0, 8
	extui	a2, a2, 0, 8
	retw.n
	.size	rust_xtensa__sync_val_compare_and_swap_1, .-rust_xtensa__sync_val_compare_and_swap_1
	.align	4
	.global	rust_xtensa__sync_bool_compare_and_swap_1
	.type	rust_xtensa__sync_bool_compare_and_swap_1, @function
rust_xtensa__sync_bool_compare_and_swap_1:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a4
	s8i	a3, a7, 4
	s8i	a2, a7, 8
	l8ui	a2, a7, 4
	mov.n	a6, a2
	l8ui	a2, a7, 8
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	movi	a2, 0xff
	ssl	a3
	sll	a2, a2
	movi.n	a8, -1
	xor	a8, a8, a2
	extui	a2, a6, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a10, a2
	extui	a2, a4, 0, 8
	extui	a2, a2, 0, 8
	ssl	a3
	sll	a11, a2
	memw
	l32i.n	a2, a5, 0
	and	a2, a8, a2
.L45:
	or	a9, a10, a2
	or	a4, a11, a2
	wsr	a9, SCOMPARE1
	s32c1i	a4, a5, 0
	beq	a4, a9, .L46
	mov.n	a9, a2
	and	a2, a4, a8
	bne	a9, a2, .L45
.L46:
	ssr	a3
	srl	a2, a4
	extui	a3, a2, 0, 8
	extui	a2, a6, 0, 8
	sub	a4, a3, a2
	movi.n	a3, 1
	movi.n	a2, 0
	moveqz	a2, a3, a4
	retw.n
	.size	rust_xtensa__sync_bool_compare_and_swap_1, .-rust_xtensa__sync_bool_compare_and_swap_1
	.literal_position
	.literal .LC0, 65535
	.align	4
	.global	rust_xtensa__sync_fetch_and_add_2
	.type	rust_xtensa__sync_fetch_and_add_2, @function
rust_xtensa__sync_fetch_and_add_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a5, a2, a4
	extui	a4, a2, 0, 2
	movi.n	a2, 8
	mull	a4, a4, a2
	l32r	a2, .LC0
	ssl	a4
	sll	a6, a2
	movi.n	a2, -1
	xor	a9, a2, a6
	extui	a2, a3, 0, 16
	extui	a2, a2, 0, 16
	ssl	a4
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a2, a5, 0
.L49:
	mov.n	a3, a2
	add.n	a2, a3, a10
	and	a2, a2, a6
	and	a8, a3, a9
	or	a2, a8, a2
	wsr	a3, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a3, .L49
	ssr	a4
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_fetch_and_add_2, .-rust_xtensa__sync_fetch_and_add_2
	.literal_position
	.literal .LC1, 65535
	.align	4
	.global	rust_xtensa__sync_fetch_and_sub_2
	.type	rust_xtensa__sync_fetch_and_sub_2, @function
rust_xtensa__sync_fetch_and_sub_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a5, a2, a4
	extui	a4, a2, 0, 2
	movi.n	a2, 8
	mull	a4, a4, a2
	l32r	a2, .LC1
	ssl	a4
	sll	a6, a2
	movi.n	a2, -1
	xor	a9, a2, a6
	extui	a2, a3, 0, 16
	extui	a2, a2, 0, 16
	ssl	a4
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a2, a5, 0
.L52:
	mov.n	a3, a2
	sub	a2, a3, a10
	and	a2, a2, a6
	and	a8, a3, a9
	or	a2, a8, a2
	wsr	a3, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a3, .L52
	ssr	a4
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_fetch_and_sub_2, .-rust_xtensa__sync_fetch_and_sub_2
	.literal_position
	.align	4
	.global	rust_xtensa__sync_fetch_and_or_2
	.type	rust_xtensa__sync_fetch_and_or_2, @function
rust_xtensa__sync_fetch_and_or_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 16
	extui	a2, a2, 0, 16
	ssl	a5
	sll	a6, a2
	memw
	l32i.n	a2, a4, 0
.L55:
	mov.n	a3, a2
	or	a2, a3, a6
	wsr	a3, SCOMPARE1
	s32c1i	a2, a4, 0
	bne	a2, a3, .L55
	ssr	a5
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_fetch_and_or_2, .-rust_xtensa__sync_fetch_and_or_2
	.literal_position
	.literal .LC3, 65535
	.align	4
	.global	rust_xtensa__sync_fetch_and_and_2
	.type	rust_xtensa__sync_fetch_and_and_2, @function
rust_xtensa__sync_fetch_and_and_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC3
	ssl	a3
	sll	a2, a2
	movi.n	a6, -1
	xor	a2, a6, a2
	extui	a4, a4, 0, 16
	extui	a4, a4, 0, 16
	ssl	a3
	sll	a4, a4
	xor	a6, a4, a2
	memw
	l32i.n	a2, a5, 0
.L58:
	mov.n	a4, a2
	and	a2, a4, a6
	wsr	a4, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a4, .L58
	ssr	a3
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_fetch_and_and_2, .-rust_xtensa__sync_fetch_and_and_2
	.literal_position
	.align	4
	.global	rust_xtensa__sync_fetch_and_xor_2
	.type	rust_xtensa__sync_fetch_and_xor_2, @function
rust_xtensa__sync_fetch_and_xor_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 16
	extui	a2, a2, 0, 16
	ssl	a5
	sll	a6, a2
	memw
	l32i.n	a2, a4, 0
.L61:
	mov.n	a3, a2
	xor	a2, a3, a6
	wsr	a3, SCOMPARE1
	s32c1i	a2, a4, 0
	bne	a2, a3, .L61
	ssr	a5
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_fetch_and_xor_2, .-rust_xtensa__sync_fetch_and_xor_2
	.literal_position
	.literal .LC5, 65535
	.align	4
	.global	rust_xtensa__sync_fetch_and_nand_2
	.type	rust_xtensa__sync_fetch_and_nand_2, @function
rust_xtensa__sync_fetch_and_nand_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC5
	ssl	a3
	sll	a6, a2
	movi.n	a2, -1
	xor	a2, a2, a6
	extui	a4, a4, 0, 16
	extui	a4, a4, 0, 16
	ssl	a3
	sll	a4, a4
	xor	a8, a4, a2
	memw
	l32i.n	a2, a5, 0
.L64:
	mov.n	a4, a2
	xor	a2, a4, a6
	and	a2, a2, a8
	wsr	a4, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a4, .L64
	ssr	a3
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_fetch_and_nand_2, .-rust_xtensa__sync_fetch_and_nand_2
	.literal_position
	.literal .LC6, 65535
	.align	4
	.global	rust_xtensa__sync_add_and_fetch_2
	.type	rust_xtensa__sync_add_and_fetch_2, @function
rust_xtensa__sync_add_and_fetch_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC6
	ssl	a3
	sll	a8, a2
	movi.n	a2, -1
	xor	a9, a2, a8
	extui	a2, a4, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a4, a5, 0
.L67:
	mov.n	a2, a4
	add.n	a4, a2, a10
	and	a4, a4, a8
	and	a6, a2, a9
	or	a6, a6, a4
	mov.n	a4, a6
	wsr	a2, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a2, .L67
	ssr	a3
	srl	a2, a6
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_add_and_fetch_2, .-rust_xtensa__sync_add_and_fetch_2
	.literal_position
	.literal .LC7, 65535
	.align	4
	.global	rust_xtensa__sync_sub_and_fetch_2
	.type	rust_xtensa__sync_sub_and_fetch_2, @function
rust_xtensa__sync_sub_and_fetch_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC7
	ssl	a3
	sll	a8, a2
	movi.n	a2, -1
	xor	a9, a2, a8
	extui	a2, a4, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a2, a2
	mov.n	a10, a2
	memw
	l32i.n	a4, a5, 0
.L70:
	mov.n	a2, a4
	sub	a4, a2, a10
	and	a4, a4, a8
	and	a6, a2, a9
	or	a6, a6, a4
	mov.n	a4, a6
	wsr	a2, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a2, .L70
	ssr	a3
	srl	a2, a6
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_sub_and_fetch_2, .-rust_xtensa__sync_sub_and_fetch_2
	.literal_position
	.align	4
	.global	rust_xtensa__sync_or_and_fetch_2
	.type	rust_xtensa__sync_or_and_fetch_2, @function
rust_xtensa__sync_or_and_fetch_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 16
	extui	a2, a2, 0, 16
	ssl	a5
	sll	a8, a2
	memw
	l32i.n	a3, a4, 0
.L73:
	mov.n	a2, a3
	or	a6, a2, a8
	mov.n	a3, a6
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	bne	a3, a2, .L73
	ssr	a5
	srl	a2, a6
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_or_and_fetch_2, .-rust_xtensa__sync_or_and_fetch_2
	.literal_position
	.literal .LC9, 65535
	.align	4
	.global	rust_xtensa__sync_and_and_fetch_2
	.type	rust_xtensa__sync_and_and_fetch_2, @function
rust_xtensa__sync_and_and_fetch_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a2, a3, a2
	l32r	a3, .LC9
	ssl	a2
	sll	a3, a3
	movi.n	a6, -1
	xor	a3, a6, a3
	extui	a4, a4, 0, 16
	extui	a4, a4, 0, 16
	ssl	a2
	sll	a4, a4
	xor	a8, a4, a3
	memw
	l32i.n	a4, a5, 0
.L76:
	mov.n	a3, a4
	and	a6, a3, a8
	mov.n	a4, a6
	wsr	a3, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a3, .L76
	ssr	a2
	srl	a2, a6
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_and_and_fetch_2, .-rust_xtensa__sync_and_and_fetch_2
	.literal_position
	.align	4
	.global	rust_xtensa__sync_xor_and_fetch_2
	.type	rust_xtensa__sync_xor_and_fetch_2, @function
rust_xtensa__sync_xor_and_fetch_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a3, a2
	l32i.n	a2, a7, 0
	movi.n	a4, -4
	and	a4, a2, a4
	extui	a5, a2, 0, 2
	movi.n	a2, 8
	mull	a5, a5, a2
	extui	a2, a3, 0, 16
	extui	a2, a2, 0, 16
	ssl	a5
	sll	a8, a2
	memw
	l32i.n	a3, a4, 0
.L79:
	mov.n	a2, a3
	xor	a6, a2, a8
	mov.n	a3, a6
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	bne	a3, a2, .L79
	ssr	a5
	srl	a2, a6
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_xor_and_fetch_2, .-rust_xtensa__sync_xor_and_fetch_2
	.literal_position
	.literal .LC11, 65535
	.align	4
	.global	rust_xtensa__sync_nand_and_fetch_2
	.type	rust_xtensa__sync_nand_and_fetch_2, @function
rust_xtensa__sync_nand_and_fetch_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a2, a3, a2
	l32r	a3, .LC11
	ssl	a2
	sll	a8, a3
	movi.n	a3, -1
	xor	a3, a3, a8
	extui	a4, a4, 0, 16
	extui	a4, a4, 0, 16
	ssl	a2
	sll	a4, a4
	xor	a9, a4, a3
	memw
	l32i.n	a4, a5, 0
.L82:
	mov.n	a3, a4
	xor	a4, a3, a8
	and	a6, a4, a9
	mov.n	a4, a6
	wsr	a3, SCOMPARE1
	s32c1i	a4, a5, 0
	bne	a4, a3, .L82
	ssr	a2
	srl	a2, a6
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_nand_and_fetch_2, .-rust_xtensa__sync_nand_and_fetch_2
	.literal_position
	.literal .LC12, 65535
	.align	4
	.global	rust_xtensa__sync_lock_test_and_set_2
	.type	rust_xtensa__sync_lock_test_and_set_2, @function
rust_xtensa__sync_lock_test_and_set_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a3
	s16i	a2, a7, 4
	l16ui	a2, a7, 4
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC12
	ssl	a3
	sll	a2, a2
	movi.n	a6, -1
	xor	a8, a6, a2
	extui	a2, a4, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a6, a2
	memw
	l32i.n	a2, a5, 0
.L85:
	mov.n	a4, a2
	and	a2, a4, a8
	or	a2, a2, a6
	wsr	a4, SCOMPARE1
	s32c1i	a2, a5, 0
	bne	a2, a4, .L85
	ssr	a3
	srl	a2, a2
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_lock_test_and_set_2, .-rust_xtensa__sync_lock_test_and_set_2
	.literal_position
	.literal .LC13, 65535
	.align	4
	.global	rust_xtensa__sync_val_compare_and_swap_2
	.type	rust_xtensa__sync_val_compare_and_swap_2, @function
rust_xtensa__sync_val_compare_and_swap_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a4
	s16i	a3, a7, 4
	s16i	a2, a7, 8
	l16ui	a2, a7, 4
	mov.n	a8, a2
	l16ui	a2, a7, 8
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC13
	ssl	a3
	sll	a2, a2
	movi.n	a6, -1
	xor	a6, a6, a2
	extui	a2, a8, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a9, a2
	extui	a2, a4, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a10, a2
	memw
	l32i.n	a2, a5, 0
	and	a2, a6, a2
.L88:
	or	a8, a9, a2
	or	a4, a10, a2
	wsr	a8, SCOMPARE1
	s32c1i	a4, a5, 0
	beq	a4, a8, .L89
	mov.n	a8, a2
	and	a2, a4, a6
	bne	a8, a2, .L88
.L89:
	ssr	a3
	srl	a2, a4
	extui	a2, a2, 0, 16
	sext	a2, a2, 15
	retw.n
	.size	rust_xtensa__sync_val_compare_and_swap_2, .-rust_xtensa__sync_val_compare_and_swap_2
	.literal_position
	.literal .LC14, 65535
	.align	4
	.global	rust_xtensa__sync_bool_compare_and_swap_2
	.type	rust_xtensa__sync_bool_compare_and_swap_2, @function
rust_xtensa__sync_bool_compare_and_swap_2:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	mov.n	a2, a4
	s16i	a3, a7, 4
	s16i	a2, a7, 8
	l16ui	a2, a7, 4
	mov.n	a6, a2
	l16ui	a2, a7, 8
	mov.n	a4, a2
	l32i.n	a2, a7, 0
	movi.n	a3, -4
	and	a5, a2, a3
	extui	a3, a2, 0, 2
	movi.n	a2, 8
	mull	a3, a3, a2
	l32r	a2, .LC14
	ssl	a3
	sll	a2, a2
	movi.n	a8, -1
	xor	a8, a8, a2
	extui	a2, a6, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a10, a2
	extui	a2, a4, 0, 16
	extui	a2, a2, 0, 16
	ssl	a3
	sll	a11, a2
	memw
	l32i.n	a2, a5, 0
	and	a2, a8, a2
.L92:
	or	a9, a10, a2
	or	a4, a11, a2
	wsr	a9, SCOMPARE1
	s32c1i	a4, a5, 0
	beq	a4, a9, .L93
	mov.n	a9, a2
	and	a2, a4, a8
	bne	a9, a2, .L92
.L93:
	ssr	a3
	srl	a2, a4
	extui	a3, a2, 0, 16
	extui	a2, a6, 0, 16
	sub	a4, a3, a2
	movi.n	a3, 1
	movi.n	a2, 0
	moveqz	a2, a3, a4
	retw.n
	.size	rust_xtensa__sync_bool_compare_and_swap_2, .-rust_xtensa__sync_bool_compare_and_swap_2
	.align	4
	.global	rust_xtensa__sync_fetch_and_add_4
	.type	rust_xtensa__sync_fetch_and_add_4, @function
rust_xtensa__sync_fetch_and_add_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L96:
	mov.n	a2, a3
	mov.n	a5, a2
	add.n	a3, a2, a9
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L96
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_fetch_and_add_4, .-rust_xtensa__sync_fetch_and_add_4
	.align	4
	.global	rust_xtensa__sync_fetch_and_sub_4
	.type	rust_xtensa__sync_fetch_and_sub_4, @function
rust_xtensa__sync_fetch_and_sub_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L99:
	mov.n	a2, a3
	mov.n	a5, a2
	sub	a3, a2, a9
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L99
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_fetch_and_sub_4, .-rust_xtensa__sync_fetch_and_sub_4
	.align	4
	.global	rust_xtensa__sync_fetch_and_or_4
	.type	rust_xtensa__sync_fetch_and_or_4, @function
rust_xtensa__sync_fetch_and_or_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L102:
	mov.n	a2, a3
	mov.n	a5, a2
	or	a3, a2, a9
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L102
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_fetch_and_or_4, .-rust_xtensa__sync_fetch_and_or_4
	.align	4
	.global	rust_xtensa__sync_fetch_and_and_4
	.type	rust_xtensa__sync_fetch_and_and_4, @function
rust_xtensa__sync_fetch_and_and_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L105:
	mov.n	a2, a3
	mov.n	a5, a2
	and	a3, a2, a9
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L105
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_fetch_and_and_4, .-rust_xtensa__sync_fetch_and_and_4
	.align	4
	.global	rust_xtensa__sync_fetch_and_xor_4
	.type	rust_xtensa__sync_fetch_and_xor_4, @function
rust_xtensa__sync_fetch_and_xor_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L108:
	mov.n	a2, a3
	mov.n	a5, a2
	xor	a3, a2, a9
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L108
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_fetch_and_xor_4, .-rust_xtensa__sync_fetch_and_xor_4
	.align	4
	.global	rust_xtensa__sync_fetch_and_nand_4
	.type	rust_xtensa__sync_fetch_and_nand_4, @function
rust_xtensa__sync_fetch_and_nand_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L111:
	mov.n	a2, a3
	mov.n	a5, a2
	and	a3, a2, a9
	movi.n	a6, -1
	xor	a3, a6, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L111
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_fetch_and_nand_4, .-rust_xtensa__sync_fetch_and_nand_4
	.align	4
	.global	rust_xtensa__sync_add_and_fetch_4
	.type	rust_xtensa__sync_add_and_fetch_4, @function
rust_xtensa__sync_add_and_fetch_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L114:
	mov.n	a2, a3
	add.n	a3, a2, a9
	mov.n	a5, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L114
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_add_and_fetch_4, .-rust_xtensa__sync_add_and_fetch_4
	.align	4
	.global	rust_xtensa__sync_sub_and_fetch_4
	.type	rust_xtensa__sync_sub_and_fetch_4, @function
rust_xtensa__sync_sub_and_fetch_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L117:
	mov.n	a2, a3
	sub	a3, a2, a9
	mov.n	a5, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L117
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_sub_and_fetch_4, .-rust_xtensa__sync_sub_and_fetch_4
	.align	4
	.global	rust_xtensa__sync_or_and_fetch_4
	.type	rust_xtensa__sync_or_and_fetch_4, @function
rust_xtensa__sync_or_and_fetch_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L120:
	mov.n	a2, a3
	or	a3, a2, a9
	mov.n	a5, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L120
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_or_and_fetch_4, .-rust_xtensa__sync_or_and_fetch_4
	.align	4
	.global	rust_xtensa__sync_and_and_fetch_4
	.type	rust_xtensa__sync_and_and_fetch_4, @function
rust_xtensa__sync_and_and_fetch_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L123:
	mov.n	a2, a3
	and	a3, a2, a9
	mov.n	a5, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L123
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_and_and_fetch_4, .-rust_xtensa__sync_and_and_fetch_4
	.align	4
	.global	rust_xtensa__sync_xor_and_fetch_4
	.type	rust_xtensa__sync_xor_and_fetch_4, @function
rust_xtensa__sync_xor_and_fetch_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L126:
	mov.n	a2, a3
	xor	a3, a2, a9
	mov.n	a5, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L126
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_xor_and_fetch_4, .-rust_xtensa__sync_xor_and_fetch_4
	.align	4
	.global	rust_xtensa__sync_nand_and_fetch_4
	.type	rust_xtensa__sync_nand_and_fetch_4, @function
rust_xtensa__sync_nand_and_fetch_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L129:
	mov.n	a2, a3
	and	a3, a2, a9
	movi.n	a5, -1
	xor	a3, a5, a3
	mov.n	a5, a3
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a2, 0
	moveqz	a2, a6, a8
	beqz.n	a2, .L129
	mov.n	a2, a5
	retw.n
	.size	rust_xtensa__sync_nand_and_fetch_4, .-rust_xtensa__sync_nand_and_fetch_4
	.align	4
	.global	rust_xtensa__sync_lock_test_and_set_4
	.type	rust_xtensa__sync_lock_test_and_set_4, @function
rust_xtensa__sync_lock_test_and_set_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	l32i.n	a9, a7, 4
	l32i.n	a4, a7, 0
	memw
	l32i.n	a3, a4, 0
.L132:
	mov.n	a2, a3
	mov.n	a3, a9
	wsr	a2, SCOMPARE1
	s32c1i	a3, a4, 0
	sub	a8, a3, a2
	movi.n	a6, 1
	movi.n	a5, 0
	moveqz	a5, a6, a8
	beqz.n	a5, .L132
	retw.n
	.size	rust_xtensa__sync_lock_test_and_set_4, .-rust_xtensa__sync_lock_test_and_set_4
	.align	4
	.global	rust_xtensa__sync_val_compare_and_swap_4
	.type	rust_xtensa__sync_val_compare_and_swap_4, @function
rust_xtensa__sync_val_compare_and_swap_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	s32i.n	a4, a7, 8
	l32i.n	a3, a7, 4
	l32i.n	a4, a7, 8
	l32i.n	a2, a7, 0
	mov.n	a8, a4
	wsr	a3, SCOMPARE1
	s32c1i	a8, a2, 0
	mov.n	a3, a8
	mov.n	a2, a3
	retw.n
	.size	rust_xtensa__sync_val_compare_and_swap_4, .-rust_xtensa__sync_val_compare_and_swap_4
	.align	4
	.global	rust_xtensa__sync_bool_compare_and_swap_4
	.type	rust_xtensa__sync_bool_compare_and_swap_4, @function
rust_xtensa__sync_bool_compare_and_swap_4:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a3, a7, 4
	s32i.n	a4, a7, 8
	l32i.n	a2, a7, 4
	l32i.n	a4, a7, 8
	l32i.n	a3, a7, 0
	wsr	a2, SCOMPARE1
	s32c1i	a4, a3, 0
	sub	a4, a4, a2
	movi.n	a3, 1
	movi.n	a2, 0
	moveqz	a2, a3, a4
	retw.n
	.size	rust_xtensa__sync_bool_compare_and_swap_4, .-rust_xtensa__sync_bool_compare_and_swap_4
	.literal_position
	.align	4
	.global	rust_xtensa__sync_fetch_and_add_8
	.type	rust_xtensa__sync_fetch_and_add_8, @function
rust_xtensa__sync_fetch_and_add_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_fetch_and_add_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_fetch_and_add_8, .-rust_xtensa__sync_fetch_and_add_8
	.literal_position
	.align	4
	.global	rust_xtensa__sync_fetch_and_sub_8
	.type	rust_xtensa__sync_fetch_and_sub_8, @function
rust_xtensa__sync_fetch_and_sub_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_fetch_and_sub_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_fetch_and_sub_8, .-rust_xtensa__sync_fetch_and_sub_8
	.align	4
	.global	rust_xtensa__sync_fetch_and_or_8
	.type	rust_xtensa__sync_fetch_and_or_8, @function
rust_xtensa__sync_fetch_and_or_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_fetch_and_or_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_fetch_and_or_8, .-rust_xtensa__sync_fetch_and_or_8
	.align	4
	.global	rust_xtensa__sync_fetch_and_and_8
	.type	rust_xtensa__sync_fetch_and_and_8, @function
rust_xtensa__sync_fetch_and_and_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_fetch_and_and_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_fetch_and_and_8, .-rust_xtensa__sync_fetch_and_and_8
	.align	4
	.global	rust_xtensa__sync_fetch_and_xor_8
	.type	rust_xtensa__sync_fetch_and_xor_8, @function
rust_xtensa__sync_fetch_and_xor_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_fetch_and_xor_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_fetch_and_xor_8, .-rust_xtensa__sync_fetch_and_xor_8
	.align	4
	.global	rust_xtensa__sync_fetch_and_nand_8
	.type	rust_xtensa__sync_fetch_and_nand_8, @function
rust_xtensa__sync_fetch_and_nand_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_fetch_and_nand_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_fetch_and_nand_8, .-rust_xtensa__sync_fetch_and_nand_8
	.literal_position
	.align	4
	.global	rust_xtensa__sync_add_and_fetch_8
	.type	rust_xtensa__sync_add_and_fetch_8, @function
rust_xtensa__sync_add_and_fetch_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_add_and_fetch_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_add_and_fetch_8, .-rust_xtensa__sync_add_and_fetch_8
	.literal_position
	.align	4
	.global	rust_xtensa__sync_sub_and_fetch_8
	.type	rust_xtensa__sync_sub_and_fetch_8, @function
rust_xtensa__sync_sub_and_fetch_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_sub_and_fetch_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_sub_and_fetch_8, .-rust_xtensa__sync_sub_and_fetch_8
	.align	4
	.global	rust_xtensa__sync_or_and_fetch_8
	.type	rust_xtensa__sync_or_and_fetch_8, @function
rust_xtensa__sync_or_and_fetch_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_or_and_fetch_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_or_and_fetch_8, .-rust_xtensa__sync_or_and_fetch_8
	.align	4
	.global	rust_xtensa__sync_and_and_fetch_8
	.type	rust_xtensa__sync_and_and_fetch_8, @function
rust_xtensa__sync_and_and_fetch_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_and_and_fetch_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_and_and_fetch_8, .-rust_xtensa__sync_and_and_fetch_8
	.align	4
	.global	rust_xtensa__sync_xor_and_fetch_8
	.type	rust_xtensa__sync_xor_and_fetch_8, @function
rust_xtensa__sync_xor_and_fetch_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_xor_and_fetch_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_xor_and_fetch_8, .-rust_xtensa__sync_xor_and_fetch_8
	.align	4
	.global	rust_xtensa__sync_nand_and_fetch_8
	.type	rust_xtensa__sync_nand_and_fetch_8, @function
rust_xtensa__sync_nand_and_fetch_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_nand_and_fetch_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_nand_and_fetch_8, .-rust_xtensa__sync_nand_and_fetch_8
	.align	4
	.global	rust_xtensa__sync_lock_test_and_set_8
	.type	rust_xtensa__sync_lock_test_and_set_8, @function
rust_xtensa__sync_lock_test_and_set_8:
	entry	sp, 48
	mov.n	a7, sp
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_lock_test_and_set_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_lock_test_and_set_8, .-rust_xtensa__sync_lock_test_and_set_8
	.align	4
	.global	rust_xtensa__sync_val_compare_and_swap_8
	.type	rust_xtensa__sync_val_compare_and_swap_8, @function
rust_xtensa__sync_val_compare_and_swap_8:
	entry	sp, 64
	mov.n	a9, a7
	mov	a7, sp
	mov.n	a8, a6
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	s32i.n	a8, a7, 16
	s32i.n	a9, a7, 20
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	l32i.n	a4, a7, 16
	l32i.n	a5, a7, 20
	mov.n	a14, a4
	mov.n	a15, a5
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_val_compare_and_swap_8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
	.size	rust_xtensa__sync_val_compare_and_swap_8, .-rust_xtensa__sync_val_compare_and_swap_8
	.align	4
	.global	rust_xtensa__sync_bool_compare_and_swap_8
	.type	rust_xtensa__sync_bool_compare_and_swap_8, @function
rust_xtensa__sync_bool_compare_and_swap_8:
	entry	sp, 64
	mov.n	a9, a7
	mov	a7, sp
	mov.n	a8, a6
	s32i.n	a2, a7, 0
	s32i.n	a4, a7, 8
	s32i.n	a5, a7, 12
	s32i.n	a8, a7, 16
	s32i.n	a9, a7, 20
	l32i.n	a2, a7, 8
	l32i.n	a3, a7, 12
	l32i.n	a4, a7, 16
	l32i.n	a5, a7, 20
	mov.n	a14, a4
	mov.n	a15, a5
	mov.n	a12, a2
	mov.n	a13, a3
	l32i.n	a10, a7, 0
	call8	__sync_bool_compare_and_swap_8
	mov.n	a2, a10
	retw.n
	.size	rust_xtensa__sync_bool_compare_and_swap_8, .-rust_xtensa__sync_bool_compare_and_swap_8
	.ident	"GCC: (crosstool-NG crosstool-ng-1.22.0-80-g6c4433a) 5.2.0"
