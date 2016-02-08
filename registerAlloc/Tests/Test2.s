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
	subq	$32, %rsp
	leaq	L_.str(%rip), %rax
	movq	%rax, -16(%rbp)         ## 8-byte Spill
	movl	$2, -4(%rbp)
	movl	$3, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	movl	-20(%rbp), %ecx         ## 4-byte Reload
	movl	%ecx, %edx
	movl	%edx, -24(%rbp)         ## 4-byte Spill
	movl	-24(%rbp), %esi         ## 4-byte Reload
	imull	-8(%rbp), %esi
	movl	%esi, -24(%rbp)         ## 4-byte Spill
	movq	-16(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	movl	-24(%rbp), %edi         ## 4-byte Reload
	movl	%edi, %esi
	movb	$0, %al
	callq	_printf
	movl	%eax, %r8d
	movl	%r8d, -28(%rbp)         ## 4-byte Spill
	movl	$0, %r9d
	movl	%r9d, -32(%rbp)         ## 4-byte Spill
	movl	-32(%rbp), %r10d        ## 4-byte Reload
	movl	%r10d, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Hello World!!! %d"


.subsections_via_symbols
