	.text
	.file	"outTestCase.bc"
	.section	.debug_info,"",@progbits
.Lsection_info:
	.section	.debug_abbrev,"",@progbits
.Lsection_abbrev:
	.section	.debug_line,"",@progbits
.Lsection_line:
	.section	.debug_pubnames,"",@progbits
	.section	.debug_pubtypes,"",@progbits
	.section	.debug_str,"MS",@progbits,1
.Linfo_string:
	.section	.debug_loc,"",@progbits
.Lsection_debug_loc:
	.section	.debug_ranges,"",@progbits
.Ldebug_range:
	.text
	.globl	fun1
	.align	16, 0x90
	.type	fun1,@function
fun1:                                   # @fun1
.Lfunc_begin0:
	.file	1 "TestCase.c"
	.loc	1 3 0                   # TestCase.c:3:0
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp2:
	.cfi_def_cfa_register %rbp
	.loc	1 5 2 prologue_end      # TestCase.c:5:2
.Ltmp3:
	movl	$3, -8(%rbp)
.LBB0_1:                                # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
	.loc	1 7 4 discriminator 1   # TestCase.c:7:4
.Ltmp4:
	cmpl	$0, -8(%rbp)
	je	.LBB0_26
.Ltmp5:
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 8 3                   # TestCase.c:8:3
	movl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)         # 4-byte Spill
	movl	-44(%rbp), %eax         # 4-byte Reload
	movl	%eax, %ecx
	movl	%ecx, -48(%rbp)         # 4-byte Spill
	movl	-48(%rbp), %eax         # 4-byte Reload
	addl	$4294967295, %eax       # imm = 0xFFFFFFFF
	movl	%eax, -48(%rbp)         # 4-byte Spill
	movl	-48(%rbp), %eax         # 4-byte Reload
	movl	%eax, -8(%rbp)
	.loc	1 9 6                   # TestCase.c:9:6
.Ltmp6:
	cmpl	$0, -8(%rbp)
	jne	.LBB0_4
# BB#3:                                 # %if.then
	.loc	1 10 4                  # TestCase.c:10:4
	movl	-8(%rbp), %eax
	movl	%eax, -52(%rbp)         # 4-byte Spill
	movl	-52(%rbp), %eax         # 4-byte Reload
	movl	%eax, -4(%rbp)
	jmp	.LBB0_27
.Ltmp7:
.LBB0_4:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 12 6                  # TestCase.c:12:6
	cmpl	$1, -8(%rbp)
	jne	.LBB0_10
# BB#5:                                 # %if.then2
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 13 4                  # TestCase.c:13:4
.Ltmp8:
	movl	$1, -12(%rbp)
	.loc	1 14 4                  # TestCase.c:14:4
	movl	$1, -16(%rbp)
	.loc	1 15 12                 # TestCase.c:15:12
.Ltmp9:
	movl	$1, -12(%rbp)
.LBB0_6:                                # %for.cond
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 15 12 discriminator 2 # TestCase.c:15:12
.Ltmp10:
	cmpl	$5, -12(%rbp)
	jg	.LBB0_9
.Ltmp11:
# BB#7:                                 # %for.body
                                        #   in Loop: Header=BB0_6 Depth=2
	.loc	1 16 5                  # TestCase.c:16:5
	movl	-12(%rbp), %eax
	movl	%eax, -56(%rbp)         # 4-byte Spill
	movl	-16(%rbp), %eax
	movl	%eax, -60(%rbp)         # 4-byte Spill
	movl	-60(%rbp), %eax         # 4-byte Reload
	movl	%eax, %ecx
	movl	%ecx, -64(%rbp)         # 4-byte Spill
	movl	-56(%rbp), %eax         # 4-byte Reload
	movl	-64(%rbp), %ecx         # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -64(%rbp)         # 4-byte Spill
	movl	-64(%rbp), %eax         # 4-byte Reload
	movl	%eax, -16(%rbp)
.Ltmp12:
# BB#8:                                 # %for.inc
                                        #   in Loop: Header=BB0_6 Depth=2
	.loc	1 15 23                 # TestCase.c:15:23
	movl	-12(%rbp), %eax
	movl	%eax, -68(%rbp)         # 4-byte Spill
	movl	-68(%rbp), %eax         # 4-byte Reload
	movl	%eax, %ecx
	movl	%ecx, -72(%rbp)         # 4-byte Spill
	movl	-72(%rbp), %eax         # 4-byte Reload
	addl	$1, %eax
	movl	%eax, -72(%rbp)         # 4-byte Spill
	movl	-72(%rbp), %eax         # 4-byte Reload
	movl	%eax, -12(%rbp)
	jmp	.LBB0_6
.Ltmp13:
.LBB0_9:                                # %for.end
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 18 3                  # TestCase.c:18:3
	jmp	.LBB0_25
.Ltmp14:
.LBB0_10:                               # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 20 11                 # TestCase.c:20:11
	cmpl	$2, -8(%rbp)
	jne	.LBB0_24
# BB#11:                                # %if.then5
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 21 4                  # TestCase.c:21:4
.Ltmp15:
	movl	$1, -20(%rbp)
	.loc	1 22 6                  # TestCase.c:22:6
	movl	$2, -24(%rbp)
	.loc	1 23 7                  # TestCase.c:23:7
.Ltmp16:
	movl	-20(%rbp), %eax
	movl	%eax, -76(%rbp)         # 4-byte Spill
	movl	-76(%rbp), %eax         # 4-byte Reload
	cmpl	-24(%rbp), %eax
	jle	.LBB0_16
# BB#12:                                # %if.then7
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 24 5                  # TestCase.c:24:5
.Ltmp17:
	movl	$3, -28(%rbp)
	.loc	1 25 5                  # TestCase.c:25:5
	movl	$4, -32(%rbp)
	.loc	1 26 8                  # TestCase.c:26:8
.Ltmp18:
	movl	-28(%rbp), %eax
	movl	%eax, -80(%rbp)         # 4-byte Spill
	movl	-80(%rbp), %eax         # 4-byte Reload
	cmpl	-32(%rbp), %eax
	jle	.LBB0_14
# BB#13:                                # %if.then9
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 27 6                  # TestCase.c:27:6
.Ltmp19:
	movl	$10, -24(%rbp)
	.loc	1 28 5                  # TestCase.c:28:5
	jmp	.LBB0_15
.Ltmp20:
.LBB0_14:                               # %if.else10
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 30 6                  # TestCase.c:30:6
	movl	$-10, -24(%rbp)
.Ltmp21:
.LBB0_15:                               # %if.end11
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 32 4                  # TestCase.c:32:4
	jmp	.LBB0_23
.Ltmp22:
.LBB0_16:                               # %if.else12
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 33 12                 # TestCase.c:33:12
	movl	-20(%rbp), %eax
	movl	%eax, -84(%rbp)         # 4-byte Spill
	movl	-84(%rbp), %eax         # 4-byte Reload
	cmpl	-24(%rbp), %eax
	jge	.LBB0_21
# BB#17:                                # %if.then14
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 34 5                  # TestCase.c:34:5
.Ltmp23:
	movl	$5, -36(%rbp)
	.loc	1 35 5                  # TestCase.c:35:5
	movl	$6, -40(%rbp)
	.loc	1 36 8                  # TestCase.c:36:8
.Ltmp24:
	movl	-36(%rbp), %eax
	movl	%eax, -88(%rbp)         # 4-byte Spill
	movl	-88(%rbp), %eax         # 4-byte Reload
	cmpl	-40(%rbp), %eax
	jge	.LBB0_19
# BB#18:                                # %if.then16
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 37 6                  # TestCase.c:37:6
.Ltmp25:
	movl	$20, -40(%rbp)
	.loc	1 38 5                  # TestCase.c:38:5
	jmp	.LBB0_20
.Ltmp26:
.LBB0_19:                               # %if.else17
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 40 6                  # TestCase.c:40:6
	movl	$-20, -40(%rbp)
.Ltmp27:
.LBB0_20:                               # %if.end18
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 42 4                  # TestCase.c:42:4
	jmp	.LBB0_22
.Ltmp28:
.LBB0_21:                               # %if.else19
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 44 5                  # TestCase.c:44:5
	movl	$0, -20(%rbp)
.Ltmp29:
.LBB0_22:                               # %if.end20
                                        #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_23
.LBB0_23:                               # %if.end21
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 45 3                  # TestCase.c:45:3
	jmp	.LBB0_24
.Ltmp30:
.LBB0_24:                               # %if.end22
                                        #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_25
.LBB0_25:                               # %if.end23
                                        #   in Loop: Header=BB0_1 Depth=1
	.loc	1 46 3                  # TestCase.c:46:3
	jmp	.LBB0_1
.Ltmp31:
.LBB0_26:                               # %while.end
	.loc	1 47 2                  # TestCase.c:47:2
	movl	-8(%rbp), %eax
	movl	%eax, -92(%rbp)         # 4-byte Spill
	movl	-92(%rbp), %eax         # 4-byte Reload
	movl	%eax, -4(%rbp)
.LBB0_27:                               # %return
	.loc	1 48 1                  # TestCase.c:48:1
	movl	-4(%rbp), %eax
	movl	%eax, -96(%rbp)         # 4-byte Spill
	movl	-96(%rbp), %eax         # 4-byte Reload
	popq	%rbp
	retq
.Ltmp32:
.Ltmp33:
	.size	fun1, .Ltmp33-fun1
.Lfunc_end0:
	.cfi_endproc

	.globl	fun2
	.align	16, 0x90
	.type	fun2,@function
fun2:                                   # @fun2
.Lfunc_begin1:
	.loc	1 50 0                  # TestCase.c:50:0
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp34:
	.cfi_def_cfa_offset 16
.Ltmp35:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp36:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movabsq	$.L.str, %rax
	.loc	1 51 2 prologue_end     # TestCase.c:51:2
.Ltmp37:
	movq	%rax, -8(%rbp)          # 8-byte Spill
	movq	-8(%rbp), %rcx          # 8-byte Reload
	movq	%rcx, %rdi
	movb	$0, %al
	callq	printf
	.loc	1 52 1                  # TestCase.c:52:1
	movl	%eax, -12(%rbp)         # 4-byte Spill
	addq	$16, %rsp
	popq	%rbp
	retq
.Ltmp38:
.Ltmp39:
	.size	fun2, .Ltmp39-fun2
.Lfunc_end1:
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\n This is a test case"
	.size	.L.str, 22

	.text
.Ldebug_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 3.5.0 (tags/RELEASE_350/final)"
.Linfo_string1:
	.asciz	"TestCase.c"
.Linfo_string2:
	.asciz	"/home/student/llvm/lib/Transforms/RegAllocSource"
.Linfo_string3:
	.asciz	"fun1"
.Linfo_string4:
	.asciz	"int"
.Linfo_string5:
	.asciz	"fun2"
.Linfo_string6:
	.asciz	"choice"
.Linfo_string7:
	.asciz	"i"
.Linfo_string8:
	.asciz	"p"
.Linfo_string9:
	.asciz	"a"
.Linfo_string10:
	.asciz	"b"
.Linfo_string11:
	.asciz	"c"
.Linfo_string12:
	.asciz	"d"
.Linfo_string13:
	.asciz	"e"
.Linfo_string14:
	.asciz	"f"
	.section	.debug_info,"",@progbits
.L.debug_info_begin0:
	.long	347                     # Length of Unit
	.short	4                       # DWARF version number
	.long	.Lsection_abbrev        # Offset Into Abbrev. Section
	.byte	8                       # Address Size (in bytes)
	.byte	1                       # Abbrev [1] 0xb:0x154 DW_TAG_compile_unit
	.long	.Linfo_string0          # DW_AT_producer
	.short	12                      # DW_AT_language
	.long	.Linfo_string1          # DW_AT_name
	.long	.Lline_table_start0     # DW_AT_stmt_list
	.long	.Linfo_string2          # DW_AT_comp_dir
	.quad	.Lfunc_begin0           # DW_AT_low_pc
.Lset0 = .Lfunc_end1-.Lfunc_begin0      # DW_AT_high_pc
	.long	.Lset0
	.byte	2                       # Abbrev [2] 0x2a:0x117 DW_TAG_subprogram
	.quad	.Lfunc_begin0           # DW_AT_low_pc
.Lset1 = .Lfunc_end0-.Lfunc_begin0      # DW_AT_high_pc
	.long	.Lset1
	.byte	1                       # DW_AT_frame_base
	.byte	86
	.long	.Linfo_string3          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	3                       # DW_AT_decl_line
	.long	343                     # DW_AT_type
                                        # DW_AT_external
	.byte	1                       # DW_AT_accessibility
                                        # DW_ACCESS_public
	.byte	3                       # Abbrev [3] 0x44:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	120
	.long	.Linfo_string6          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	5                       # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0x52:0xee DW_TAG_lexical_block
	.quad	.Ltmp5                  # DW_AT_low_pc
.Lset2 = .Ltmp31-.Ltmp5                 # DW_AT_high_pc
	.long	.Lset2
	.byte	4                       # Abbrev [4] 0x5f:0xe0 DW_TAG_lexical_block
	.quad	.Ltmp7                  # DW_AT_low_pc
.Lset3 = .Ltmp30-.Ltmp7                 # DW_AT_high_pc
	.long	.Lset3
	.byte	4                       # Abbrev [4] 0x6c:0x2a DW_TAG_lexical_block
	.quad	.Ltmp8                  # DW_AT_low_pc
.Lset4 = .Ltmp14-.Ltmp8                 # DW_AT_high_pc
	.long	.Lset4
	.byte	3                       # Abbrev [3] 0x79:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	116
	.long	.Linfo_string7          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	13                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0x87:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	112
	.long	.Linfo_string8          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	14                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	4                       # Abbrev [4] 0x96:0xa8 DW_TAG_lexical_block
	.quad	.Ltmp14                 # DW_AT_low_pc
.Lset5 = .Ltmp30-.Ltmp14                # DW_AT_high_pc
	.long	.Lset5
	.byte	4                       # Abbrev [4] 0xa3:0x9a DW_TAG_lexical_block
	.quad	.Ltmp15                 # DW_AT_low_pc
.Lset6 = .Ltmp30-.Ltmp15                # DW_AT_high_pc
	.long	.Lset6
	.byte	3                       # Abbrev [3] 0xb0:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	108
	.long	.Linfo_string9          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	21                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0xbe:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	104
	.long	.Linfo_string10         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	22                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0xcc:0x70 DW_TAG_lexical_block
	.quad	.Ltmp16                 # DW_AT_low_pc
.Lset7 = .Ltmp29-.Ltmp16                # DW_AT_high_pc
	.long	.Lset7
	.byte	4                       # Abbrev [4] 0xd9:0x2a DW_TAG_lexical_block
	.quad	.Ltmp17                 # DW_AT_low_pc
.Lset8 = .Ltmp22-.Ltmp17                # DW_AT_high_pc
	.long	.Lset8
	.byte	3                       # Abbrev [3] 0xe6:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	100
	.long	.Linfo_string11         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	24                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0xf4:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	96
	.long	.Linfo_string12         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	25                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	4                       # Abbrev [4] 0x103:0x38 DW_TAG_lexical_block
	.quad	.Ltmp22                 # DW_AT_low_pc
.Lset9 = .Ltmp29-.Ltmp22                # DW_AT_high_pc
	.long	.Lset9
	.byte	4                       # Abbrev [4] 0x110:0x2a DW_TAG_lexical_block
	.quad	.Ltmp23                 # DW_AT_low_pc
.Lset10 = .Ltmp28-.Ltmp23               # DW_AT_high_pc
	.long	.Lset10
	.byte	3                       # Abbrev [3] 0x11d:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	92
	.long	.Linfo_string13         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	34                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0x12b:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	88
	.long	.Linfo_string14         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	35                      # DW_AT_decl_line
	.long	343                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	5                       # Abbrev [5] 0x141:0x16 DW_TAG_subprogram
	.quad	.Lfunc_begin1           # DW_AT_low_pc
.Lset11 = .Lfunc_end1-.Lfunc_begin1     # DW_AT_high_pc
	.long	.Lset11
	.byte	1                       # DW_AT_frame_base
	.byte	86
	.long	.Linfo_string5          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	50                      # DW_AT_decl_line
                                        # DW_AT_external
	.byte	1                       # DW_AT_accessibility
                                        # DW_ACCESS_public
	.byte	6                       # Abbrev [6] 0x157:0x7 DW_TAG_base_type
	.long	.Linfo_string4          # DW_AT_name
	.byte	5                       # DW_AT_encoding
	.byte	4                       # DW_AT_byte_size
	.byte	0                       # End Of Children Mark
.L.debug_info_end0:
	.section	.debug_abbrev,"",@progbits
	.byte	1                       # Abbreviation Code
	.byte	17                      # DW_TAG_compile_unit
	.byte	1                       # DW_CHILDREN_yes
	.byte	37                      # DW_AT_producer
	.byte	14                      # DW_FORM_strp
	.byte	19                      # DW_AT_language
	.byte	5                       # DW_FORM_data2
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	16                      # DW_AT_stmt_list
	.byte	23                      # DW_FORM_sec_offset
	.byte	27                      # DW_AT_comp_dir
	.byte	14                      # DW_FORM_strp
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	2                       # Abbreviation Code
	.byte	46                      # DW_TAG_subprogram
	.byte	1                       # DW_CHILDREN_yes
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	64                      # DW_AT_frame_base
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	73                      # DW_AT_type
	.byte	19                      # DW_FORM_ref4
	.byte	63                      # DW_AT_external
	.byte	25                      # DW_FORM_flag_present
	.byte	50                      # DW_AT_accessibility
	.byte	11                      # DW_FORM_data1
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	3                       # Abbreviation Code
	.byte	52                      # DW_TAG_variable
	.byte	0                       # DW_CHILDREN_no
	.byte	2                       # DW_AT_location
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	73                      # DW_AT_type
	.byte	19                      # DW_FORM_ref4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	4                       # Abbreviation Code
	.byte	11                      # DW_TAG_lexical_block
	.byte	1                       # DW_CHILDREN_yes
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	5                       # Abbreviation Code
	.byte	46                      # DW_TAG_subprogram
	.byte	0                       # DW_CHILDREN_no
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	64                      # DW_AT_frame_base
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	63                      # DW_AT_external
	.byte	25                      # DW_FORM_flag_present
	.byte	50                      # DW_AT_accessibility
	.byte	11                      # DW_FORM_data1
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	6                       # Abbreviation Code
	.byte	36                      # DW_TAG_base_type
	.byte	0                       # DW_CHILDREN_no
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	62                      # DW_AT_encoding
	.byte	11                      # DW_FORM_data1
	.byte	11                      # DW_AT_byte_size
	.byte	11                      # DW_FORM_data1
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	0                       # EOM(3)
	.section	.debug_ranges,"",@progbits
	.section	.debug_loc,"",@progbits
	.section	.debug_pubnames,"",@progbits
.Lset12 = .LpubNames_end0-.LpubNames_begin0 # Length of Public Names Info
	.long	.Lset12
.LpubNames_begin0:
	.short	2                       # DWARF Version
	.long	.L.debug_info_begin0    # Offset of Compilation Unit Info
.Lset13 = .L.debug_info_end0-.L.debug_info_begin0 # Compilation Unit Length
	.long	.Lset13
	.long	42                      # DIE offset
	.asciz	"fun1"                  # External Name
	.long	321                     # DIE offset
	.asciz	"fun2"                  # External Name
	.long	0                       # End Mark
.LpubNames_end0:
	.section	.debug_pubtypes,"",@progbits
.Lset14 = .LpubTypes_end0-.LpubTypes_begin0 # Length of Public Types Info
	.long	.Lset14
.LpubTypes_begin0:
	.short	2                       # DWARF Version
	.long	.L.debug_info_begin0    # Offset of Compilation Unit Info
.Lset15 = .L.debug_info_end0-.L.debug_info_begin0 # Compilation Unit Length
	.long	.Lset15
	.long	343                     # DIE offset
	.asciz	"int"                   # External Name
	.long	0                       # End Mark
.LpubTypes_end0:

	.ident	"clang version 3.5.0 (tags/RELEASE_350/final)"
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
