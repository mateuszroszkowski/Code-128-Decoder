###	COMPUTER ARCHITECTURE - MIPS PROJECT	###
###	MATEUSZ ROSZKOWSKI			###
###	BARCODE 128 DECODER - CODE SET A	###

# ILOŚĆ CHUJOWEGO KODU W TYM PROJEKCIE WŁAŚNIE PRZEKROCZYŁA ROCZNĄ NORMĘ, NAWET JAK NA MOJE MOŻLIWOŚCI
# Z GÓRY PRZEPRASZAM ZA NAJBLIŻSZĄ DIAGNOZĘ NOWOTWORU ZŁOŚLIWEGO W KLINICE ONKOLOGICZNEJ
# MAM NADZIEJĘ, ŻE MI WYBACZYSZ

.data

code_0:			.asciiz "212222"
code_1:			.asciiz "222122"
code_2:			.asciiz "222221"
code_3:			.asciiz "121223"
code_4:			.asciiz "121322"
code_5:			.asciiz "131222"
code_6:			.asciiz "122213"
code_7:			.asciiz	"122312"
code_8:			.asciiz	"132212"
code_9:			.asciiz "221213"
code_10:		.asciiz "221312"
code_11:		.asciiz "231212"
code_12:		.asciiz "112232"
code_13:		.asciiz "122132"
code_14:		.asciiz "122231"
code_15:		.asciiz	"113222"
code_16:		.asciiz "123122"
code_17:		.asciiz "123221"
code_18:		.asciiz "223211"
code_19:		.asciiz "221132"
code_20:		.asciiz "221231"
code_21:		.asciiz "213212"
code_22:		.asciiz "223112"
code_23:		.asciiz "312131"
code_24:		.asciiz "311222"
code_25:		.asciiz	"321122"
code_26:		.asciiz "321221"
code_27:		.asciiz "312212"
code_28:		.asciiz "322112"
code_29:		.asciiz "322211"
code_30:		.asciiz "212123"
code_31:		.asciiz "212321"
code_32:		.asciiz "232121"
code_33:		.asciiz "111323"
code_34:		.asciiz "131123"
code_35:		.asciiz "131321"
code_36:		.asciiz "112313"
code_37:		.asciiz "132113"
code_38:		.asciiz "132311"
code_39:		.asciiz "211313"
code_40:		.asciiz "231113"
code_41:		.asciiz "231311"
code_42:		.asciiz "112133"
code_43:		.asciiz "112331"
code_44:		.asciiz "132131"
code_45:		.asciiz "113123"
code_46:		.asciiz "113321"
code_47:		.asciiz "133121"
code_48:		.asciiz "313121"
code_49:		.asciiz	"211331"
code_50:		.asciiz	"231131"
code_51:		.asciiz	"213113"
code_52:		.asciiz "213311"
code_53:		.asciiz "213131"
code_54:		.asciiz "311123"
code_55:		.asciiz	"311321"
code_56:		.asciiz	"331121"
code_57:		.asciiz "312113"
code_58:		.asciiz "312311"
code_59:		.asciiz "332111"
code_60:		.asciiz "314111"
code_61:		.asciiz "221411"
code_62:		.asciiz "431111"
code_63:		.asciiz "111224"
code_64:		.asciiz "111422"
code_65:		.asciiz "121124"
code_66:		.asciiz "121421"
code_67:		.asciiz "141122"
code_68:		.asciiz	"141221"
code_69:		.asciiz "112214"
code_70:		.asciiz "112412"
code_71:		.asciiz "122114"
code_72:		.asciiz "122411"
code_73:		.asciiz "142112"
code_74:		.asciiz "142211"
code_75:		.asciiz "241211"
code_76:		.asciiz "221114"
code_77:		.asciiz "413111"
code_78:		.asciiz "241112"
code_79:		.asciiz "134111"
code_80:		.asciiz "111242"
code_81:		.asciiz "121142"
code_82:		.asciiz "121241"
code_83:		.asciiz "114212"
code_84:		.asciiz "124112"
code_85:		.asciiz "124211"
code_86:		.asciiz "411212"
code_87:		.asciiz "421112"
code_88:		.asciiz "421211"
code_89:		.asciiz "212141"
code_90:		.asciiz "214121"
code_91:		.asciiz "412121"
code_92:		.asciiz "111143"
code_93:		.asciiz "111341"
code_94:		.asciiz "131141"
code_95:		.asciiz "114113"
code_96:		.asciiz "114311"
code_97:		.asciiz "411113"
code_98:		.asciiz "411311"
code_99:		.asciiz	"113141"
code_100:		.asciiz "114131"
code_101:		.asciiz "311141"
code_102:		.asciiz "411131"
code_103:		.asciiz "211412"
code_104:		.asciiz "211214"
code_105:		.asciiz "211232"
code_106:		.asciiz "2331112"

array_of_codes:
			.word	code_1, code_2, code_3, code_4, code_5, code_6, code_7, code_8, code_9, code_10,
				code_11, code_12, code_13, code_14, code_15, code_16, code_17, code_18, code_19, code_20,
				code_21, code_22, code_23, code_24, code_25, code_26, code_27, code_28, code_29, code_30
				code_31, code_32, code_33, code_34, code_35, code_36, code_37, code_38, code_39, code_40,
				code_41, code_42, code_43, code_44, code_45, code_46, code_47, code_48, code_49, code_50,
				code_51, code_52, code_53, code_54, code_55, code_56, code_57, code_58, code_59, code_60
				code_61, code_62, code_63, code_64, code_65, code_66, code_67, code_68, code_69, code_70,
				code_71, code_72, code_73, code_74, code_75, code_76, code_77, code_78, code_79, code_80,
				code_81, code_82, code_83, code_84, code_85, code_86, code_87, code_88, code_89, code_90,
				code_91, code_92, code_93, code_94, code_95, code_96, code_97, code_98, code_99, code_100,
				code_101, code_102, code_103, code_104, code_105, code_106



buffer:			.space	2
header:			.space	54
width:			.word	600
height:			.word	50
code_buffer:		.space	7
special_code_buffer:	.space	8

dsc_error_msg: 		.asciiz "File descriptor error!"
bitmap_error_msg: 	.asciiz	"Loaded file is not a bitmap!"
format_error_msg:	.asciiz "Loaded bmp resolution is not 24-bit!"
size_error_msg:		.asciiz	"Wrong file size! Allowed size is 600x50."

no_black_pixel:		.asciiz "There is no barcode in the bitmap!"
placeholder:		.asciiz "Black pixel found!"

fpath:			.asciiz	"/home/mateusz/develop/projects/ecoar/mips/Code-128-Decoder/test.bmp"

.text
open_file:
	li	$t1, '\0'
	sb	$t1, code_buffer+6
	sb	$t1, special_code_buffer+7
	li	$t1, '*'
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
	move	$t9, $s4
	addiu	$t9, $t9, 88200 # top left pixel
	li	$t8, 0 # chcecking if we passed full row	
	
look_for_black:
	lb	$t0, ($t9)
	beqz	$t0, black_found
	
iterate:
	addiu	$t9, $t9, 3
	addiu	$t8, $t8, 1
	beq	$t8, 599, end_of_row
	j	look_for_black

black_found:
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
	sb	$t1, ($s6)
	addiu	$s6, $s6, 1
	lb	$t1, ($s6)
	li	$t3, '\0'
	beq	$t1, $t3, exit #########
	lb	$t2, ($t9) # color changed
	j	prepare
	
		
end_of_row:
	mul	$t8, $t8, 3
	beq	$t9, $t8, black_not_found
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
	li	$v0, 4
	la	$a0, code_buffer
	syscall
	li	$v0, 10
	syscall
