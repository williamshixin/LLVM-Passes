	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_fib
	.align	4, 0x90
_fib:                                   ## @fib
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
	subq	$64, %rsp
	movl	%edi, %eax
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	movl	-12(%rbp), %eax         ## 4-byte Reload
	movl	%eax, %ecx
	movl	%ecx, -16(%rbp)         ## 4-byte Spill
	movl	-16(%rbp), %eax         ## 4-byte Reload
	movl	%eax, -8(%rbp)
	cmpl	$2, -8(%rbp)
	jge	LBB0_2
## BB#1:                                ## %if.then
	movl	-8(%rbp), %eax
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	movl	-20(%rbp), %eax         ## 4-byte Reload
	movl	%eax, -4(%rbp)
	jmp	LBB0_3
LBB0_2:                                 ## %if.end
	movl	-8(%rbp), %eax
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	movl	-24(%rbp), %eax         ## 4-byte Reload
	movl	%eax, %edx
	movl	%edx, -28(%rbp)         ## 4-byte Spill
	movl	-28(%rbp), %eax         ## 4-byte Reload
	subl	$1, %eax
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	movl	-28(%rbp), %eax         ## 4-byte Reload
	movl	%eax, %edi
	callq	_fib
	movl	%eax, -32(%rbp)         ## 4-byte Spill
	movl	-8(%rbp), %eax
	movl	%eax, -36(%rbp)         ## 4-byte Spill
	movl	-36(%rbp), %eax         ## 4-byte Reload
	movl	%eax, %esi
	movl	%esi, -40(%rbp)         ## 4-byte Spill
	movl	-40(%rbp), %eax         ## 4-byte Reload
	subl	$2, %eax
	movl	%eax, -40(%rbp)         ## 4-byte Spill
	movl	-40(%rbp), %eax         ## 4-byte Reload
	movl	%eax, %edi
	callq	_fib
	movl	%eax, -44(%rbp)         ## 4-byte Spill
	movl	-32(%rbp), %eax         ## 4-byte Reload
	movl	%eax, %edi
	movl	%edi, -48(%rbp)         ## 4-byte Spill
	movl	-44(%rbp), %eax         ## 4-byte Reload
	movl	-48(%rbp), %r8d         ## 4-byte Reload
	addl	%eax, %r8d
	movl	%r8d, -48(%rbp)         ## 4-byte Spill
	movl	-48(%rbp), %eax         ## 4-byte Reload
	movl	%eax, -4(%rbp)
LBB0_3:                                 ## %return
	movl	-4(%rbp), %eax
	movl	%eax, -52(%rbp)         ## 4-byte Spill
	movl	-52(%rbp), %eax         ## 4-byte Reload
	addq	$64, %rsp
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
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
Ltmp6:
	.cfi_offset %rbx, -32
Ltmp7:
	.cfi_offset %r14, -24
	movl	$40, %eax
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	movl	-20(%rbp), %r8d         ## 4-byte Reload
	movl	%r8d, %edi
	callq	_fib
	movl	%eax, %r9d
	movl	%r9d, -24(%rbp)         ## 4-byte Spill
	leaq	L_.str(%rip), %rax
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	movq	-32(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	movl	-24(%rbp), %r10d        ## 4-byte Reload
	movl	%r10d, %esi
	movb	$0, %al
	callq	_printf
	movl	%eax, %r11d
	movl	%r11d, -36(%rbp)        ## 4-byte Spill
	movl	$0, %ebx
	movl	%ebx, -40(%rbp)         ## 4-byte Spill
	movl	-40(%rbp), %r14d        ## 4-byte Reload
	movl	%r14d, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d\n"


.subsections_via_symbols
