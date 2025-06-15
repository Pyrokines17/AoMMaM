	.file	"main.c"
	.text
	.p2align 4
	.globl	getArray
	.type	getArray, @function
getArray:
.LFB46:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$251658240, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	malloc@PLT
	movq	%rax, %rbp
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L2:
	movq	%rax, 0(%rbp,%rax,8)
	leaq	1(%rax), %rdx
	addq	$2, %rax
	movq	%rdx, 0(%rbp,%rdx,8)
	cmpq	$31457280, %rax
	jne	.L2
	xorl	%edi, %edi
	movl	$31457279, %ebx
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	xorl	%edx, %edx
	movq	0(%rbp,%rbx,8), %rcx
	cltq
	divq	%rbx
	leaq	0(%rbp,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%rdx, 0(%rbp,%rbx,8)
	movq	%rcx, (%rax)
	subq	$1, %rbx
	jne	.L3
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE46:
	.size	getArray, .-getArray
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%ld"
.LC3:
	.string	"a"
.LC4:
	.string	"results.csv"
.LC5:
	.string	"Error: can not write result"
.LC6:
	.string	"%d;%f;\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB47:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	$5, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xorl	%ebx, %ebx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %r13
	leaq	16(%rsp), %r12
	call	getArray
	movsd	.LC0(%rip), %xmm3
	movq	%rax, %r14
	movq	%xmm3, %r15
	.p2align 4,,10
	.p2align 3
.L13:
	movq	%r13, %rsi
	movl	$2, %edi
	call	clock_gettime@PLT
	movl	$31457280, %eax
	.p2align 4,,10
	.p2align 3
.L10:
	movq	(%r14,%rbx,8), %rbx
#APP
# 47 "main.c" 1
	nop
# 0 "" 2
#NO_APP
	subq	$1, %rax
	jne	.L10
	movq	%r12, %rsi
	movl	$2, %edi
	call	clock_gettime@PLT
	movq	24(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	8(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	movq	%r15, %xmm2
	addsd	%xmm1, %xmm0
	minsd	%xmm0, %xmm2
	movq	%xmm2, %r15
	subl	$1, %ebp
	jne	.L13
	movq	%rbx, %rdx
	leaq	.LC2(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC3(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L21
	movl	nop_count(%rip), %ecx
	leaq	.LC6(%rip), %rbp
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
	movq	%r14, %rdi
	call	free@PLT
	xorl	%eax, %eax
.L9:
	movq	40(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L22
	addq	$56, %rsp
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
.L21:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$27, %edx
	movl	$1, %esi
	leaq	.LC5(%rip), %rdi
	call	fwrite@PLT
	orl	$-1, %eax
	jmp	.L9
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE47:
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
.LC0:
	.long	0
	.long	1083129856
	.align 8
.LC1:
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
