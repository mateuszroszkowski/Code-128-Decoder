###	COMPUTER ARCHITECTURE - MIPS PROJECT	###
###	MATEUSZ ROSZKOWSKI			###
###	BARCODE 128 DECODER - CODE SET A	###

.data
.include		"data.asm"

buffer:			.space	2
header:			.space	54
width:			.word	600
height:			.word	50
code_buffer:		.space	7
special_code_buffer:	.space	8
output:			.space 	100

dsc_error_msg: 		.asciiz "File descriptor error!"
bitmap_error_msg: 	.asciiz	"Loaded file is not a bitmap!"
format_error_msg:	.asciiz "Loaded bmp resolution is not 24-bit!"
size_error_msg:		.asciiz	"Wrong file size! Allowed size is 600x50."
checksum_error_msg:	.asciiz "Wrong checksum value!"
char_code_error_msg:	.asciiz "Character code not found!"
no_barcode_error_msg:	.asciiz "There is no barcode in the pricture!"

no_black_pixel:		.asciiz "There is no barcode in the bitmap!"
placeholder:		.asciiz "Black pixel found!"

fpath:			.asciiz	"/home/mateusz/develop/projects/ecoar/mips/Code-128-Decoder/abcd.bmp"

.text
open_file:
	li	$t1, '\0'
	sb	$t1, code_buffer+6
	sb	$t1, special_code_buffer+7
	la	$t1, code_buffer
	la	$t2, special_code_buffer
	li	$t3, '*'
	sb	$t1, code_buffer
	sb	$t1, special_code_buffer
	sb	$t1, code_buffer+1
	sb	$t1, special_code_buffer+1
	sb	$t1, code_buffer+2
	sb	$t1, special_code_buffer+2
	sb	$t1, code_buffer+3
	sb	$t1, special_code_buffer+3
	sb	$t1, code_buffer+4
	sb	$t1, special_code_buffer+4
	sb	$t1, code_buffer+5
	sb	$t1, special_code_buffer+5
	sb	$t1, special_code_buffer+6

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
	
set_up_top_left:
	xor	$s1, $s1, $s1
	xor	$s2, $s2, $s2
	xor	$s3, $s3, $s3
	move	$t9, $s4
	li	$s4, 0
	addiu	$t9, $t9, 88200 # top left pixel
	li	$t8, 0 # chcecking if we passed full row
	la	$s7, output
	xor	$s4, $s4, $s4
	
look_for_black:
	lb	$t0, ($t9)
	beqz	$t0, black_found
	
iterate:
	addiu	$t9, $t9, 3
	addiu	$t8, $t8, 1
	beq	$t8, 599, end_of_row
	j	look_for_black
	
no_barcode:
	li	$v0, 4
	la	$a0, no_barcode_error_msg
	syscall
	j	exit

black_found:
	xor	$s4, $s4, $s4
	li	$t1, 1
	la	$t7, ($t9)
	la	$s6, code_buffer
	la	$s5, special_code_buffer

find_width:
	addiu	$t7, $t7, 3
	lb	$t0, ($t7)
	bnez	$t0, end_of_bar
	addiu	$t1, $t1, 1
	j	find_width

end_of_bar:
	divu	$t6, $t1, 2
	move	$t7, $t6  # t7 holds width of thinest bar in pixels
	mulu	$t6, $t7, 5 # first width which exceeds limit of 5
	
prepare:
	li	$t1, 0
	lb	$t2, ($t9) # current color
	
check_width:
	lb	$t0, ($t9)
	bne	$t0, $t2, bar_finished
	addiu	$t1, $t1, 1
	addiu	$t9, $t9, 3
	beq	$t1, $t6, exit
	j	check_width
	
bar_finished:
	divu	$t1, $t1, $t7
	addiu	$t1, $t1, 48
	sb	$t1, ($s6)
	addiu	$s6, $s6, 1
	lb	$t1, ($s6)
	li	$t3, '\0'
	beq	$t1, $t3, finished_reading
	lb	$t2, ($t9) # color changed
	j	prepare
	
finished_reading:
	li	$t1, 0
	la	$a1, array_of_codes
	
prepare_for_str_cmp:
	lw	$a2, ($a1)
	la	$a3, ($a2)
	la	$s6, code_buffer
	li	$t3, '\0'

str_cmp:
	lb	$t5, ($a3)
	lb	$t4, ($s6)
	beq	$t5, $t3, equal
	bne	$t5, $t4, not_equal
	
inc:
	addiu	$s6, $s6, 1
	addiu	$a3, $a3, 1
	j	str_cmp
	
equal:
	beq	$t1, 103, start
	addiu	$s1, $s1, 1	# $s1 holds current number of charactes read - START SYMBOL
	move	$s2, $t1	# $s2 holds last character value
	mulu	$s3, $s1, $s2	# component of a checksum
	addu	$s4, $s4, $s3	# checksum	
	addiu	$t1, $t1, 32
	sb	$t1, ($s7)
	addiu	$s7, $s7, 1
	la	$s6, code_buffer
	j	prepare
	
start:
	addu	$s4, $s4, $t1
	la	$s6, code_buffer
	j	prepare

not_equal:
	addiu	$t1, $t1, 1
	beq	$t1, 105, possible_stop
	addiu	$a1, $a1, 4
	la	$s6, code_buffer
	lw	$a2, ($a1)
	la	$a3, ($a2)
	j	str_cmp	

possible_stop:
	la	$s6, code_buffer
	la	$s5, special_code_buffer
	li	$t3, '\0'
	
copy:
	lb	$t1, ($s6)
	beq	$t1, $t3, get_one_bar
	sb	$t1, ($s5)
	addiu	$s5, $s5, 1
	addiu	$s6, $s6, 1
	j	copy

get_one_bar:
	li	$t1, 0
	lb	$t2, ($t9) # current color
	
one_bar_width:
	lb	$t0, ($t9)
	bne	$t0, $t2, finalize
	addiu	$t1, $t1, 1
	addiu	$t9, $t9, 3
	beq	$t1, $t6, exit
	j	one_bar_width

finalize:
	divu	$t1, $t1, $t7
	addiu	$t1, $t1, 48
	sb	$t1, special_code_buffer+6
	
check_if_stop:
	la	$a1, array_of_codes+424
	la	$s5, special_code_buffer
	lw	$a2, ($a1)
	la	$a3, ($a2)
	li	$t3, '\0'
	
cmp:
	lb	$t5, ($s5)
	beq	$t5, $t3, match
	lb	$t4, ($a3)
	bne	$t4, $t5, wrong_code
	addiu	$a3, $a3, 1
	addiu	$s5, $s5, 1
	j	cmp
	
match:
	subu	$s4, $s4, $s3
	li	$t4, 103
	divu	$s4, $t4
	xor	$t4, $t4, $t4
	mfhi	$t4
	bne	$t4, $s2, wrong_checksum
	
finish:
	li	$t3, '\0'
	subiu	$s7, $s7, 1
	sb	$t3, ($s7)

exit_success:
	li	$v0, 4
	la	$a0, output
	syscall
	li	$v0, 10
	syscall

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
	

		
end_of_row:
	addiu	$s4, $s4, 1
	beq	$s4, 49, no_barcode
	li	$t8, 0
	subiu	$t9, $t9, 3597 # from rightmost pixel in n-th row to leftmost pixel in (n-1)th row
	j	look_for_black
	
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