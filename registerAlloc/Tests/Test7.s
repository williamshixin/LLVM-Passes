	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_get
	.align	4, 0x90
_get:                                   ## @get
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
	movl	%edi, %eax
	movl	%eax, -8(%rbp)          ## 4-byte Spill
	movl	-8(%rbp), %ecx          ## 4-byte Reload
	movl	%ecx, %edx
	movl	%edx, -12(%rbp)         ## 4-byte Spill
	movl	-12(%rbp), %esi         ## 4-byte Reload
	movl	%esi, -4(%rbp)
	movl	-4(%rbp), %edi
	movl	%edi, -16(%rbp)         ## 4-byte Spill
	movl	-16(%rbp), %r8d         ## 4-byte Reload
	movl	%r8d, %eax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp5:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
Ltmp6:
	.cfi_offset %rbx, -56
Ltmp7:
	.cfi_offset %r12, -48
Ltmp8:
	.cfi_offset %r13, -40
Ltmp9:
	.cfi_offset %r14, -32
Ltmp10:
	.cfi_offset %r15, -24
	movl	$1, %r8d
	movl	%r8d, -52(%rbp)         ## 4-byte Spill
	movl	$0, -44(%rbp)
	movl	-52(%rbp), %r9d         ## 4-byte Reload
	movl	%r9d, %edi
	callq	_get
	movl	%eax, %r10d
	movl	%r10d, -56(%rbp)        ## 4-byte Spill
	movl	-56(%rbp), %r11d        ## 4-byte Reload
	cmpl	$0, %r11d
	je	LBB1_2
## BB#1:                                ## %if.then
	movl	$42, %ebx
	movl	%ebx, -60(%rbp)         ## 4-byte Spill
	movl	-60(%rbp), %r14d        ## 4-byte Reload
	movl	%r14d, %edi
	callq	_get
	movl	%eax, %r15d
	movl	%r15d, -64(%rbp)        ## 4-byte Spill
	movl	-64(%rbp), %r12d        ## 4-byte Reload
	movl	%r12d, -48(%rbp)
	jmp	LBB1_3
LBB1_2:                                 ## %if.else
	movl	$0, %r13d
	movl	%r13d, -68(%rbp)        ## 4-byte Spill
	movl	-68(%rbp), %r13d        ## 4-byte Reload
	movl	%r13d, %edi
	callq	_get
	movl	%eax, %r13d
	movl	%r13d, -72(%rbp)        ## 4-byte Spill
	movl	-72(%rbp), %r13d        ## 4-byte Reload
	movl	%r13d, -48(%rbp)
LBB1_3:                                 ## %if.end
	leaq	L_.str(%rip), %rax
	movq	%rax, -80(%rbp)         ## 8-byte Spill
	movl	-48(%rbp), %r13d
	movl	%r13d, -84(%rbp)        ## 4-byte Spill
	movq	-80(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	movl	-84(%rbp), %r13d        ## 4-byte Reload
	movl	%r13d, %esi
	movb	$0, %al
	callq	_printf
	movl	%eax, %r13d
	movl	%r13d, -88(%rbp)        ## 4-byte Spill
	movl	-44(%rbp), %r13d
	movl	%r13d, -92(%rbp)        ## 4-byte Spill
	movl	-92(%rbp), %r13d        ## 4-byte Reload
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
