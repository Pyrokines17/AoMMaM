	.file	"main1.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"a"
.LC5:
	.string	"results1.csv"
.LC6:
	.string	"Error: can not write result"
.LC7:
	.string	"%d;%f;\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB46:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	$5, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movsd	.LC1(%rip), %xmm6
	movsd	.LC2(%rip), %xmm0
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r13
	leaq	32(%rsp), %r12
	movq	%xmm6, %r15
.L2:
	movq	$0x000000000, (%rsp)
	movl	$1000000, %ebp
	.p2align 4,,10
	.p2align 3
.L7:
	movq	%r13, %rsi
	movl	$2, %edi
	movsd	%xmm0, 8(%rsp)
	movl	$50, %ebx
	call	clock_gettime@PLT
	movsd	8(%rsp), %xmm0
	pxor	%xmm1, %xmm1
	.p2align 4,,10
	.p2align 3
.L6:
	sqrtsd	%xmm0, %xmm0
.L5:
#APP
# 29 "main1.c" 1
	nop
# 0 "" 2
#NO_APP
	subl	$1, %ebx
	jne	.L6
	movq	%r12, %rsi
	movl	$2, %edi
	movsd	%xmm0, 8(%rsp)
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm2, %xmm2
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm2
	pxor	%xmm3, %xmm3
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm3
	subl	$1, %ebp
	divsd	.LC3(%rip), %xmm2
	movsd	8(%rsp), %xmm0
	addsd	%xmm3, %xmm2
	addsd	(%rsp), %xmm2
	movsd	%xmm2, (%rsp)
	jne	.L7
	movq	%r15, %xmm5
	minsd	%xmm2, %xmm5
	movq	%xmm5, %r15
	subl	$1, %r14d
	jne	.L2
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L21
	movl	nop_count(%rip), %ecx
	leaq	.LC7(%rip), %rbp
	movq	%rax, %rdi
	movq	%r15, %xmm0
	movq	%rbp, %rdx
	movl	$2, %esi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movl	nop_count(%rip), %edx
	movq	%r15, %xmm0
	movq	%rbp, %rsi
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
	xorl	%eax, %eax
.L1:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L22
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	call	sqrt@PLT
	pxor	%xmm1, %xmm1
	jmp	.L5
.L21:
	movq	stderr(%rip), %rcx
	movl	$27, %edx
	movl	$1, %esi
	leaq	.LC6(%rip), %rdi
	call	fwrite@PLT
	orl	$-1, %eax
	jmp	.L1
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE46:
	.size	main, .-main
	.globl	nop_count
	.data
	.align 4
	.type	nop_count, @object
	.size	nop_count, 4
nop_count:
	.long	1
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1083129856
	.align 8
.LC2:
	.long	-1
	.long	2146435071
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
