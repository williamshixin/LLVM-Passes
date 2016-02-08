	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.section	__DWARF,__debug_info,regular,debug
Lsection_info:
	.section	__DWARF,__debug_abbrev,regular,debug
Lsection_abbrev:
	.section	__DWARF,__debug_line,regular,debug
Lsection_line:
	.section	__DWARF,__debug_str,regular,debug
Linfo_string:
	.section	__DWARF,__debug_loc,regular,debug
Lsection_debug_loc:
	.section	__DWARF,__debug_ranges,regular,debug
Ldebug_range:
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
Lfunc_begin0:
	.file	1 "test1.c"
	.loc	1 9 0                   ## test1.c:9:0
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	.loc	1 10 2 prologue_end     ## test1.c:10:2
Ltmp3:
	callq	_func1
	.loc	1 11 2                  ## test1.c:11:2
	callq	_func3
	.loc	1 12 2                  ## test1.c:12:2
	callq	_func5
	.loc	1 13 2                  ## test1.c:13:2
	leaq	L_.str(%rip), %rdi
	leaq	L_.str1(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	.loc	1 14 1                  ## test1.c:14:1
	popq	%rbp
	retq
Ltmp4:
Lfunc_end0:
	.cfi_endproc

	.globl	_func1
	.align	4, 0x90
_func1:                                 ## @func1
Lfunc_begin1:
	.loc	1 16 0                  ## test1.c:16:0
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp5:
	.cfi_def_cfa_offset 16
Ltmp6:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp7:
	.cfi_def_cfa_register %rbp
	.loc	1 17 2 prologue_end     ## test1.c:17:2
Ltmp8:
	subq	$16, %rsp
	movl	$11, -4(%rbp)
	.loc	1 18 2                  ## test1.c:18:2
	leaq	L_.str(%rip), %rdi
	leaq	L_.str2(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	.loc	1 19 2                  ## test1.c:19:2
	movl	-4(%rbp), %edi
	callq	_func2
	.loc	1 20 1                  ## test1.c:20:1
	addq	$16, %rsp
	popq	%rbp
	retq
Ltmp9:
Lfunc_end1:
	.cfi_endproc

	.globl	_func2
	.align	4, 0x90
_func2:                                 ## @func2
Lfunc_begin2:
	.loc	1 22 0                  ## test1.c:22:0
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp10:
	.cfi_def_cfa_offset 16
Ltmp11:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp12:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	.loc	1 23 2 prologue_end     ## test1.c:23:2
Ltmp13:
	leaq	L_.str(%rip), %rdi
	leaq	L_.str3(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	.loc	1 24 1                  ## test1.c:24:1
	addq	$16, %rsp
	popq	%rbp
	retq
Ltmp14:
Lfunc_end2:
	.cfi_endproc

	.globl	_func3
	.align	4, 0x90
_func3:                                 ## @func3
Lfunc_begin3:
	.loc	1 26 0                  ## test1.c:26:0
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp15:
	.cfi_def_cfa_offset 16
Ltmp16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp17:
	.cfi_def_cfa_register %rbp
	.loc	1 27 2 prologue_end     ## test1.c:27:2
Ltmp18:
	subq	$16, %rsp
	movl	$1, -4(%rbp)
	.loc	1 28 2                  ## test1.c:28:2
	leaq	L_.str(%rip), %rdi
	leaq	L_.str4(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	.loc	1 29 2                  ## test1.c:29:2
	movl	-4(%rbp), %edi
	callq	_func2
	.loc	1 30 1                  ## test1.c:30:1
	addq	$16, %rsp
	popq	%rbp
	retq
Ltmp19:
Lfunc_end3:
	.cfi_endproc

	.globl	_func4
	.align	4, 0x90
_func4:                                 ## @func4
Lfunc_begin4:
	.loc	1 32 0                  ## test1.c:32:0
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp20:
	.cfi_def_cfa_offset 16
Ltmp21:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp22:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	.loc	1 33 2 prologue_end     ## test1.c:33:2
Ltmp23:
	leaq	L_.str(%rip), %rdi
	leaq	L_.str5(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	.loc	1 34 1                  ## test1.c:34:1
	addq	$16, %rsp
	popq	%rbp
	retq
Ltmp24:
Lfunc_end4:
	.cfi_endproc

	.globl	_func5
	.align	4, 0x90
_func5:                                 ## @func5
Lfunc_begin5:
	.loc	1 36 0                  ## test1.c:36:0
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp25:
	.cfi_def_cfa_offset 16
Ltmp26:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp27:
	.cfi_def_cfa_register %rbp
	.loc	1 37 2 prologue_end     ## test1.c:37:2
Ltmp28:
	subq	$16, %rsp
	movl	$2, -4(%rbp)
	movl	$3, -8(%rbp)
	.loc	1 38 2                  ## test1.c:38:2
	leaq	L_.str(%rip), %rdi
	leaq	L_.str6(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	.loc	1 39 2                  ## test1.c:39:2
	movl	-4(%rbp), %edi
	callq	_func2
	.loc	1 40 2                  ## test1.c:40:2
	movl	-8(%rbp), %edi
	callq	_func4
	.loc	1 41 1                  ## test1.c:41:1
	addq	$16, %rsp
	popq	%rbp
	retq
Ltmp29:
Lfunc_end5:
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%s\n"

L_.str1:                                ## @.str1
	.asciz	"Main function is called by program. This is a test for -dot-callgraph pass in LLVM."

L_.str2:                                ## @.str2
	.asciz	"Function1 was callsed by program."

L_.str3:                                ## @.str3
	.asciz	"Function2 was called by program."

L_.str4:                                ## @.str4
	.asciz	"Function3 was called by program."

L_.str5:                                ## @.str5
	.asciz	"Function4 was called by program."

L_.str6:                                ## @.str6
	.asciz	"Function5 was called by program."

	.section	__TEXT,__text,regular,pure_instructions
Ldebug_end0:
	.section	__DWARF,__debug_str,regular,debug
Linfo_string0:
	.asciz	"clang version 3.5.0 (tags/RELEASE_350/final)"
Linfo_string1:
	.asciz	"test1.c"
Linfo_string2:
	.asciz	"/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests"
Linfo_string3:
	.asciz	"main"
Linfo_string4:
	.asciz	"func1"
Linfo_string5:
	.asciz	"func2"
Linfo_string6:
	.asciz	"func3"
Linfo_string7:
	.asciz	"func4"
Linfo_string8:
	.asciz	"func5"
Linfo_string9:
	.asciz	"int"
Linfo_string10:
	.asciz	"num"
Linfo_string11:
	.asciz	"num1"
Linfo_string12:
	.asciz	"num2"
	.section	__DWARF,__debug_info,regular,debug
L__DWARF__debug_info_begin0:
	.long	303                     ## Length of Unit
	.short	2                       ## DWARF version number
Lset0 = Lsection_abbrev-Lsection_abbrev ## Offset Into Abbrev. Section
	.long	Lset0
	.byte	8                       ## Address Size (in bytes)
	.byte	1                       ## Abbrev [1] 0xb:0x128 DW_TAG_compile_unit
Lset1 = Linfo_string0-Linfo_string      ## DW_AT_producer
	.long	Lset1
	.short	12                      ## DW_AT_language
Lset2 = Linfo_string1-Linfo_string      ## DW_AT_name
	.long	Lset2
Lset3 = Lline_table_start0-Lsection_line ## DW_AT_stmt_list
	.long	Lset3
Lset4 = Linfo_string2-Linfo_string      ## DW_AT_comp_dir
	.long	Lset4
	.quad	Lfunc_begin0            ## DW_AT_low_pc
Lset5 = Lfunc_end5-Lfunc_begin0         ## DW_AT_high_pc
	.long	Lset5
	.byte	2                       ## Abbrev [2] 0x2a:0x1f DW_TAG_subprogram
	.quad	Lfunc_begin0            ## DW_AT_low_pc
	.quad	Lfunc_end0              ## DW_AT_high_pc
	.byte	1                       ## DW_AT_frame_base
	.byte	86
Lset6 = Linfo_string3-Linfo_string      ## DW_AT_name
	.long	Lset6
	.byte	1                       ## DW_AT_decl_file
	.byte	9                       ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	1                       ## DW_AT_external
	.byte	1                       ## DW_AT_accessibility
                                        ## DW_ACCESS_public
	.byte	3                       ## Abbrev [3] 0x49:0x2a DW_TAG_subprogram
	.quad	Lfunc_begin1            ## DW_AT_low_pc
	.quad	Lfunc_end1              ## DW_AT_high_pc
	.byte	1                       ## DW_AT_frame_base
	.byte	86
Lset7 = Linfo_string4-Linfo_string      ## DW_AT_name
	.long	Lset7
	.byte	1                       ## DW_AT_decl_file
	.byte	16                      ## DW_AT_decl_line
	.byte	1                       ## DW_AT_external
	.byte	1                       ## DW_AT_accessibility
                                        ## DW_ACCESS_public
	.byte	4                       ## Abbrev [4] 0x64:0xe DW_TAG_variable
	.byte	2                       ## DW_AT_location
	.byte	145
	.byte	124
Lset8 = Linfo_string10-Linfo_string     ## DW_AT_name
	.long	Lset8
	.byte	1                       ## DW_AT_decl_file
	.byte	17                      ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	0                       ## End Of Children Mark
	.byte	5                       ## Abbrev [5] 0x73:0x2b DW_TAG_subprogram
	.quad	Lfunc_begin2            ## DW_AT_low_pc
	.quad	Lfunc_end2              ## DW_AT_high_pc
	.byte	1                       ## DW_AT_frame_base
	.byte	86
Lset9 = Linfo_string5-Linfo_string      ## DW_AT_name
	.long	Lset9
	.byte	1                       ## DW_AT_decl_file
	.byte	22                      ## DW_AT_decl_line
	.byte	1                       ## DW_AT_prototyped
	.byte	1                       ## DW_AT_external
	.byte	1                       ## DW_AT_accessibility
                                        ## DW_ACCESS_public
	.byte	6                       ## Abbrev [6] 0x8f:0xe DW_TAG_formal_parameter
	.byte	2                       ## DW_AT_location
	.byte	145
	.byte	124
Lset10 = Linfo_string10-Linfo_string    ## DW_AT_name
	.long	Lset10
	.byte	1                       ## DW_AT_decl_file
	.byte	22                      ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	0                       ## End Of Children Mark
	.byte	3                       ## Abbrev [3] 0x9e:0x2a DW_TAG_subprogram
	.quad	Lfunc_begin3            ## DW_AT_low_pc
	.quad	Lfunc_end3              ## DW_AT_high_pc
	.byte	1                       ## DW_AT_frame_base
	.byte	86
Lset11 = Linfo_string6-Linfo_string     ## DW_AT_name
	.long	Lset11
	.byte	1                       ## DW_AT_decl_file
	.byte	26                      ## DW_AT_decl_line
	.byte	1                       ## DW_AT_external
	.byte	1                       ## DW_AT_accessibility
                                        ## DW_ACCESS_public
	.byte	4                       ## Abbrev [4] 0xb9:0xe DW_TAG_variable
	.byte	2                       ## DW_AT_location
	.byte	145
	.byte	124
Lset12 = Linfo_string10-Linfo_string    ## DW_AT_name
	.long	Lset12
	.byte	1                       ## DW_AT_decl_file
	.byte	27                      ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	0                       ## End Of Children Mark
	.byte	5                       ## Abbrev [5] 0xc8:0x2b DW_TAG_subprogram
	.quad	Lfunc_begin4            ## DW_AT_low_pc
	.quad	Lfunc_end4              ## DW_AT_high_pc
	.byte	1                       ## DW_AT_frame_base
	.byte	86
Lset13 = Linfo_string7-Linfo_string     ## DW_AT_name
	.long	Lset13
	.byte	1                       ## DW_AT_decl_file
	.byte	32                      ## DW_AT_decl_line
	.byte	1                       ## DW_AT_prototyped
	.byte	1                       ## DW_AT_external
	.byte	1                       ## DW_AT_accessibility
                                        ## DW_ACCESS_public
	.byte	6                       ## Abbrev [6] 0xe4:0xe DW_TAG_formal_parameter
	.byte	2                       ## DW_AT_location
	.byte	145
	.byte	124
Lset14 = Linfo_string10-Linfo_string    ## DW_AT_name
	.long	Lset14
	.byte	1                       ## DW_AT_decl_file
	.byte	32                      ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	0                       ## End Of Children Mark
	.byte	3                       ## Abbrev [3] 0xf3:0x38 DW_TAG_subprogram
	.quad	Lfunc_begin5            ## DW_AT_low_pc
	.quad	Lfunc_end5              ## DW_AT_high_pc
	.byte	1                       ## DW_AT_frame_base
	.byte	86
Lset15 = Linfo_string8-Linfo_string     ## DW_AT_name
	.long	Lset15
	.byte	1                       ## DW_AT_decl_file
	.byte	36                      ## DW_AT_decl_line
	.byte	1                       ## DW_AT_external
	.byte	1                       ## DW_AT_accessibility
                                        ## DW_ACCESS_public
	.byte	4                       ## Abbrev [4] 0x10e:0xe DW_TAG_variable
	.byte	2                       ## DW_AT_location
	.byte	145
	.byte	124
Lset16 = Linfo_string11-Linfo_string    ## DW_AT_name
	.long	Lset16
	.byte	1                       ## DW_AT_decl_file
	.byte	37                      ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	4                       ## Abbrev [4] 0x11c:0xe DW_TAG_variable
	.byte	2                       ## DW_AT_location
	.byte	145
	.byte	120
Lset17 = Linfo_string12-Linfo_string    ## DW_AT_name
	.long	Lset17
	.byte	1                       ## DW_AT_decl_file
	.byte	37                      ## DW_AT_decl_line
	.long	299                     ## DW_AT_type
	.byte	0                       ## End Of Children Mark
	.byte	7                       ## Abbrev [7] 0x12b:0x7 DW_TAG_base_type
Lset18 = Linfo_string9-Linfo_string     ## DW_AT_name
	.long	Lset18
	.byte	5                       ## DW_AT_encoding
	.byte	4                       ## DW_AT_byte_size
	.byte	0                       ## End Of Children Mark
L__DWARF__debug_info_end0:
	.section	__DWARF,__debug_abbrev,regular,debug
	.byte	1                       ## Abbreviation Code
	.byte	17                      ## DW_TAG_compile_unit
	.byte	1                       ## DW_CHILDREN_yes
	.byte	37                      ## DW_AT_producer
	.byte	14                      ## DW_FORM_strp
	.byte	19                      ## DW_AT_language
	.byte	5                       ## DW_FORM_data2
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	16                      ## DW_AT_stmt_list
	.byte	6                       ## DW_FORM_data4
	.byte	27                      ## DW_AT_comp_dir
	.byte	14                      ## DW_FORM_strp
	.byte	17                      ## DW_AT_low_pc
	.byte	1                       ## DW_FORM_addr
	.byte	18                      ## DW_AT_high_pc
	.byte	6                       ## DW_FORM_data4
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	2                       ## Abbreviation Code
	.byte	46                      ## DW_TAG_subprogram
	.byte	0                       ## DW_CHILDREN_no
	.byte	17                      ## DW_AT_low_pc
	.byte	1                       ## DW_FORM_addr
	.byte	18                      ## DW_AT_high_pc
	.byte	1                       ## DW_FORM_addr
	.byte	64                      ## DW_AT_frame_base
	.byte	10                      ## DW_FORM_block1
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	63                      ## DW_AT_external
	.byte	12                      ## DW_FORM_flag
	.byte	50                      ## DW_AT_accessibility
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	3                       ## Abbreviation Code
	.byte	46                      ## DW_TAG_subprogram
	.byte	1                       ## DW_CHILDREN_yes
	.byte	17                      ## DW_AT_low_pc
	.byte	1                       ## DW_FORM_addr
	.byte	18                      ## DW_AT_high_pc
	.byte	1                       ## DW_FORM_addr
	.byte	64                      ## DW_AT_frame_base
	.byte	10                      ## DW_FORM_block1
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	63                      ## DW_AT_external
	.byte	12                      ## DW_FORM_flag
	.byte	50                      ## DW_AT_accessibility
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	4                       ## Abbreviation Code
	.byte	52                      ## DW_TAG_variable
	.byte	0                       ## DW_CHILDREN_no
	.byte	2                       ## DW_AT_location
	.byte	10                      ## DW_FORM_block1
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	5                       ## Abbreviation Code
	.byte	46                      ## DW_TAG_subprogram
	.byte	1                       ## DW_CHILDREN_yes
	.byte	17                      ## DW_AT_low_pc
	.byte	1                       ## DW_FORM_addr
	.byte	18                      ## DW_AT_high_pc
	.byte	1                       ## DW_FORM_addr
	.byte	64                      ## DW_AT_frame_base
	.byte	10                      ## DW_FORM_block1
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	39                      ## DW_AT_prototyped
	.byte	12                      ## DW_FORM_flag
	.byte	63                      ## DW_AT_external
	.byte	12                      ## DW_FORM_flag
	.byte	50                      ## DW_AT_accessibility
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	6                       ## Abbreviation Code
	.byte	5                       ## DW_TAG_formal_parameter
	.byte	0                       ## DW_CHILDREN_no
	.byte	2                       ## DW_AT_location
	.byte	10                      ## DW_FORM_block1
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	58                      ## DW_AT_decl_file
	.byte	11                      ## DW_FORM_data1
	.byte	59                      ## DW_AT_decl_line
	.byte	11                      ## DW_FORM_data1
	.byte	73                      ## DW_AT_type
	.byte	19                      ## DW_FORM_ref4
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	7                       ## Abbreviation Code
	.byte	36                      ## DW_TAG_base_type
	.byte	0                       ## DW_CHILDREN_no
	.byte	3                       ## DW_AT_name
	.byte	14                      ## DW_FORM_strp
	.byte	62                      ## DW_AT_encoding
	.byte	11                      ## DW_FORM_data1
	.byte	11                      ## DW_AT_byte_size
	.byte	11                      ## DW_FORM_data1
	.byte	0                       ## EOM(1)
	.byte	0                       ## EOM(2)
	.byte	0                       ## EOM(3)
	.section	__DWARF,__debug_ranges,regular,debug
	.section	__DWARF,__debug_loc,regular,debug
	.section	__DWARF,__apple_names,regular,debug
Lnames_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	6                       ## Header Bucket Count
	.long	6                       ## Header Hash Count
	.long	12                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	1                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.long	0                       ## Bucket 0
	.long	1                       ## Bucket 1
	.long	2                       ## Bucket 2
	.long	3                       ## Bucket 3
	.long	4                       ## Bucket 4
	.long	-1                      ## Bucket 5
	.long	259443906               ## Hash in Bucket 0
	.long	259443907               ## Hash in Bucket 1
	.long	259443908               ## Hash in Bucket 2
	.long	259443909               ## Hash in Bucket 3
	.long	259443910               ## Hash in Bucket 4
	.long	2090499946              ## Hash in Bucket 4
	.long	LNames3-Lnames_begin    ## Offset in Bucket 0
	.long	LNames4-Lnames_begin    ## Offset in Bucket 1
	.long	LNames5-Lnames_begin    ## Offset in Bucket 2
	.long	LNames0-Lnames_begin    ## Offset in Bucket 3
	.long	LNames1-Lnames_begin    ## Offset in Bucket 4
	.long	LNames2-Lnames_begin    ## Offset in Bucket 4
LNames3:
Lset19 = Linfo_string4-Linfo_string     ## func1
	.long	Lset19
	.long	1                       ## Num DIEs
	.long	73
	.long	0
LNames4:
Lset20 = Linfo_string5-Linfo_string     ## func2
	.long	Lset20
	.long	1                       ## Num DIEs
	.long	115
	.long	0
LNames5:
Lset21 = Linfo_string6-Linfo_string     ## func3
	.long	Lset21
	.long	1                       ## Num DIEs
	.long	158
	.long	0
LNames0:
Lset22 = Linfo_string7-Linfo_string     ## func4
	.long	Lset22
	.long	1                       ## Num DIEs
	.long	200
	.long	0
LNames1:
Lset23 = Linfo_string8-Linfo_string     ## func5
	.long	Lset23
	.long	1                       ## Num DIEs
	.long	243
	.long	0
LNames2:
Lset24 = Linfo_string3-Linfo_string     ## main
	.long	Lset24
	.long	1                       ## Num DIEs
	.long	42
	.long	0
	.section	__DWARF,__apple_objc,regular,debug
Lobjc_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	1                       ## Header Bucket Count
	.long	0                       ## Header Hash Count
	.long	12                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	1                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.long	-1                      ## Bucket 0
	.section	__DWARF,__apple_namespac,regular,debug
Lnamespac_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	1                       ## Header Bucket Count
	.long	0                       ## Header Hash Count
	.long	12                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	1                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.long	-1                      ## Bucket 0
	.section	__DWARF,__apple_types,regular,debug
Ltypes_begin:
	.long	1212240712              ## Header Magic
	.short	1                       ## Header Version
	.short	0                       ## Header Hash Function
	.long	1                       ## Header Bucket Count
	.long	1                       ## Header Hash Count
	.long	20                      ## Header Data Length
	.long	0                       ## HeaderData Die Offset Base
	.long	3                       ## HeaderData Atom Count
	.short	1                       ## DW_ATOM_die_offset
	.short	6                       ## DW_FORM_data4
	.short	3                       ## DW_ATOM_die_tag
	.short	5                       ## DW_FORM_data2
	.short	4                       ## DW_ATOM_type_flags
	.short	11                      ## DW_FORM_data1
	.long	0                       ## Bucket 0
	.long	193495088               ## Hash in Bucket 0
	.long	Ltypes0-Ltypes_begin    ## Offset in Bucket 0
Ltypes0:
Lset25 = Linfo_string9-Linfo_string     ## int
	.long	Lset25
	.long	1                       ## Num DIEs
	.long	299
	.short	36
	.byte	0
	.long	0

.subsections_via_symbols
	.section	__DWARF,__debug_line,regular,debug
Lline_table_start0:
