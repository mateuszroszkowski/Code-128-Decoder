###	COMPUTER ARCHITECTURE - MIPS PROJECT	###
###	MATEUSZ ROSZKOWSKI			###
###	BARCODE 128 DECORED - CODE SET A	###

.data
fpath:	.asciiz	"/home/mateusz/develop/projects/ecoar/mips/Code-128-Decoder/source.bmp"

dsc_error_msg: 		.asciiz "File descriptor error!"
bitmap_error_msg: 	.asciiz	"Loaded file is not a bitmap!"
format_error_msg:	.asciiz "Loaded bmp resolution is not 24-bit!"
size_error_msg:		.asciiz	"Wrong file size! Allowed size is 600x50."

buffer:	.space	2
header:	.space	54
width:	.word	600
height:	.word	50

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
	move	$a0, $s4
	move	$a1, $s4
	move	$a2, $s3
	syscall
	
close_file:
	li	$v0, 16
	move	$a0, $s0
	syscall
	
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