###	COMPUTER ARCHITECTURE - MIPS PROJECT	###
###	MATEUSZ ROSZKOWSKI			###
###	BARCODE 128 DECODER - CODE SET A	###

.data
.include		"data.asm"

buffer:			.space	2
header:			.space	54
width:			.word	600
height:			.word	50
output:			.space 	100

dsc_error_msg: 		.asciiz "File descriptor error!"
bitmap_error_msg: 	.asciiz	"Loaded file is not a bitmap!"
format_error_msg:	.asciiz "Loaded bmp resolution is not 24-bit!"
size_error_msg:		.asciiz	"Wrong file size! Allowed size is 600x50."
checksum_error_msg:	.asciiz "Wrong checksum value!"
char_code_error_msg:	.asciiz "Character code not found!"
no_barcode_error_msg:	.asciiz "There is no barcode in the picture!"

no_black_pixel:		.asciiz "There is no barcode in the bitmap!"
decoded_text:		.asciiz "Text decoded from barcode: "

fpath:			.asciiz	"/home/mateusz/develop/projects/ecoar/mips/Code-128-Decoder/ecoar2018_fat.bmp"

.text
open_file:

	li	$v0, 13
	la	$a0, fpath
	li	$a1, 0
	li	$a2, 0
	syscall
	
	bltz	$v0, dsc_file_error
	move	$s0, $v0
	
	li	$v0, 14
	move	$a0, $s0
	la	$a1, header
	li	$a2, 54
	syscall
	
	li	$t0, 0x4D42
	lhu	$t1, header
	
	bne	$t0, $t1, bitmap_error
	
	lw	$t0, width
	lw	$s1, header+18
	bne	$t0, $s1, size_error
	lw	$t0, height
	lw	$s2, header+22
	bne	$t0, $s2, size_error
	
	li	$t0, 24
	lb	$t1, header+28
	bne	$t0, $t1, format_error
	
	lw	$s3, header+34
	
	li	$v0, 9
	move	$a0, $s3
	syscall
	move	$s4, $v0
	
	li	$v0, 14
	move	$a0, $s0
	move	$a1, $s4
	move	$a2, $s3
	syscall
	
close_file:
	li	$v0, 16
	move	$a0, $s0
	syscall
	
set_up:
	move	$t9, $s4
	li	$s4, 0
	li	$t7, 30 #line_number
	li	$t6, 1800
	mul	$t7, $t7, $t6
	addu	$t9, $t9, $t7
	li	$t8, 0 # chcecking if we passed full row
	la	$a3, output
	xor	$s4, $s4, $s4
	xor	$s7, $s7, $s7
	xor	$s6, $s6, $s6
	xor	$s5, $s5, $s5
	
look_for_black:
	lb	$t0, ($t9)
	beqz	$t0, black_found
	
iterate:
	addiu	$t9, $t9, 3
	addiu	$t8, $t8, 1
	beq	$t8, 599, no_barcode
	j	look_for_black

black_found:
	li	$t1, 1
	la	$t7, ($t9)
	
find_width:
	addiu	$t7, $t7, 3
	lb	$t0, ($t7)
	bnez	$t0, end_of_bar
	addiu	$t1, $t1, 1
	j	find_width

end_of_bar:
	divu	$t6, $t1, 2
	move	$t7, $t6 # width of the thinest bar in pixels
	mulu	$t6, $t7, 5 # firt width which exceeds limit of 5
	
pre_prepare:
	xor	$s0, $s0, $s0 # pattern
	xor	$s1, $s1, $s1 # number of shifts
	li	$s2, 1
	li	$s3, 0
	
prepare:
	li	$t1, 0
	lb	$t2, ($t9) # current color

get_bar:
	lb	$t0, ($t9)
	addiu	$t1, $t1, 1
	addiu	$t9, $t9, 3
	move	$t3, $t2 # hold color
	beq	$t1, $t7, bar_obtained
	j	get_bar
	
bar_obtained:
	beq	$t2, 0xffffff, white_bar
	beq	$t2, 0x000000, black_bar
	
white_bar:
	or	$s0, $s0, $s3
	addiu	$s1, $s1, 1
	beq	$s1, 11, pattern_finished
	sll	$s0, $s0, 1
	j	prepare
	
black_bar:
	or	$s0, $s0, $s2
	addiu	$s1, $s1, 1
	beq	$s1, 11, pattern_finished
	sll	$s0, $s0, 1
	j	prepare
	
pattern_finished:
	li	$t1, 0
	la	$t5, array_of_codes
	
	
compare:
	lw	$t4, ($t5)
	beq	$s0, $t4, equal
	bne	$s0, $t4, not_equal

equal:
	beq	$t1, 103, start
	addiu	$s4, $s4, 1
	move	$s5, $t1
	mulu	$s6, $s4, $s5
	addu	$s7, $s7, $s6
	addiu	$t1, $t1, 32
	sb	$t1, ($a3)
	addiu	$a3, $a3, 1
	xor	$s0, $s0, $s0
	xor	$s1, $s1, $s1
	j	pre_prepare
	
start:
	addu	$s7, $s7, $t1
	j	pre_prepare
	

not_equal:
	addiu	$t1, $t1, 1
	beq	$t1, 105, possible_stop
	addiu	$t5, $t5, 4
	j	compare
	
possible_stop:
	xor	$s1, $s1, $s1
	
get_bars:
	li	$t1, 0
	lb	$t2, ($t9)
	
get_additional_bars:
	lb	$t0, ($t9)
	addiu	$t1, $t1, 1
	addiu	$t9, $t9, 3
	move	$t3, $t2 # hold color
	beq	$t1, $t7, additional_obtained
	j	get_additional_bars
	
additional_obtained:
	beq	$t2, 0xffffff, white_bar_add
	beq	$t2, 0x000000, black_bar_add
	
white_bar_add:
	sll	$s0, $s0, 1
	or	$s0, $s0, $s3
	addiu	$s1, $s1, 1
	beq	$s1, 2, finalize
	j	get_bars
	
black_bar_add:
	sll	$s0, $s0, 1
	or	$s0, $s0, $s2
	addiu	$s1, $s1, 1
	beq	$s1, 2, finalize
	j	get_bars
	
finalize:
	la	$a1, array_of_codes+424
	lw	$a2, ($a1)
	bne	$s0, $a2, wrong_code
	beq	$s0, $a2, match

match:
	subu	$s7, $s7, $s6
	li	$t4, 103
	divu	$s7, $t4
	xor	$t4, $t4, $t4
	mfhi	$t4
	bne	$t4, $s5 wrong_checksum
	
finish:
	li	$t3, '\0'
	subiu	$a3, $a3, 1
	sb	$t3, ($a3)
	
exit_success:
	li	$v0, 4
	la	$a0, decoded_text
	syscall
	la	$a0, output
	syscall
	j	exit
	
	
no_barcode:
	li	$v0, 4
	la	$a0, no_barcode_error_msg
	syscall
	j	exit
	
wrong_checksum:
	li	$v0, 4
	la	$a0, checksum_error_msg
	syscall
	j	exit

wrong_code:
	li	$v0, 4
	la	$a0, char_code_error_msg
	syscall
	j	exit
	
black_not_found:
	li	$v0, 4
	la	$a0, no_black_pixel
	syscall
	j	exit
	
	
dsc_file_error:
	li	$v0, 4
	la	$a0, dsc_error_msg
	syscall
	j	exit
	
bitmap_error:
	li	$v0, 4
	la	$a0, bitmap_error_msg
	syscall
	j	exit
	
size_error:
	li	$v0, 4
	la	$a0, size_error_msg
	syscall
	j	exit
	
format_error:
	li	$v0, 4
	la	$a0, format_error_msg
	syscall
	j	exit
	
exit:
	li	$v0, 10
	syscall
