	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
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
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
Ltmp3:
	.cfi_offset %rbx, -56
Ltmp4:
	.cfi_offset %r12, -48
Ltmp5:
	.cfi_offset %r13, -40
Ltmp6:
	.cfi_offset %r14, -32
Ltmp7:
	.cfi_offset %r15, -24
	leaq	L_.str(%rip), %rax
	movq	%rax, -64(%rbp)         ## 8-byte Spill
	movl	$1, -44(%rbp)
	movl	$2, -48(%rbp)
	movl	$3, -52(%rbp)
	movl	$4, -56(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -68(%rbp)         ## 4-byte Spill
	movl	-68(%rbp), %ecx         ## 4-byte Reload
	movl	%ecx, %edx
	movl	%edx, -72(%rbp)         ## 4-byte Spill
	movl	-72(%rbp), %esi         ## 4-byte Reload
	addl	-48(%rbp), %esi
	movl	%esi, -72(%rbp)         ## 4-byte Spill
	movl	-72(%rbp), %edi         ## 4-byte Reload
	movl	%edi, %r8d
	movl	%r8d, -76(%rbp)         ## 4-byte Spill
	movl	-76(%rbp), %r9d         ## 4-byte Reload
	addl	-52(%rbp), %r9d
	movl	%r9d, -76(%rbp)         ## 4-byte Spill
	movl	-76(%rbp), %r10d        ## 4-byte Reload
	movl	%r10d, %r11d
	movl	%r11d, -80(%rbp)        ## 4-byte Spill
	movl	-80(%rbp), %ebx         ## 4-byte Reload
	addl	-56(%rbp), %ebx
	movl	%ebx, -80(%rbp)         ## 4-byte Spill
	movq	-64(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	movl	-80(%rbp), %r14d        ## 4-byte Reload
	movl	%r14d, %esi
	movb	$0, %al
	callq	_printf
	movl	%eax, %r15d
	movl	%r15d, -84(%rbp)        ## 4-byte Spill
	movl	$0, %r12d
	movl	%r12d, -88(%rbp)        ## 4-byte Spill
	movl	-88(%rbp), %r13d        ## 4-byte Reload
	movl	%r13d, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d\n"


.subsections_via_symbols
