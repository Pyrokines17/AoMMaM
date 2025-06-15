	.file	"main.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"set_cpu: pthread_setaffinity failed for cpu %d\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"set_cpu: set cpu %d\n"
	.text
	.p2align 4
	.globl	set_cpu
	.type	set_cpu, @function
set_cpu:
.LFB62:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	subq	$144, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	call	pthread_self@PLT
	movq	%rsp, %rdx
	movl	$16, %ecx
	movq	%rax, %r8
	movq	%rdx, %rdi
	xorl	%eax, %eax
	rep stosq
	movslq	%ebx, %rax
	cmpq	$1023, %rax
	ja	.L2
	shrq	$6, %rax
	movl	$1, %esi
	movl	%ebx, %ecx
	salq	%cl, %rsi
	orq	%rsi, (%rdx,%rax,8)
.L2:
	movl	$128, %esi
	movq	%r8, %rdi
	call	pthread_setaffinity_np@PLT
	testl	%eax, %eax
	jne	.L8
	movl	%ebx, %edx
	leaq	.LC1(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L1:
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L9
	addq	$144, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	movl	%ebx, %ecx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rdx
	call	__fprintf_chk@PLT
	jmp	.L1
.L9:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE62:
	.size	set_cpu, .-set_cpu
	.section	.rodata.str1.1
.LC2:
	.string	"%d "
	.text
	.p2align 4
	.globl	print_matrix
	.type	print_matrix, @function
print_matrix:
.LFB63:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	addq	$16008000, %r13
	leaq	.LC2(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	8000(%rdi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	.p2align 4,,10
	.p2align 3
.L11:
	leaq	-8000(%rbp), %rbx
	.p2align 4,,10
	.p2align 3
.L12:
	movl	(%rbx), %edx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%rbp, %rbx
	jne	.L12
	movl	$10, %edi
	leaq	8000(%rbx), %rbp
	call	putchar@PLT
	cmpq	%r13, %rbp
	jne	.L11
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE63:
	.size	print_matrix, .-print_matrix
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"End of warming up\nTime: %f\nIter count: %d\n\n"
	.align 8
.LC9:
	.string	"End of lab\nTicks taken: %lld\nLatency: %f\nResult: %f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB64:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$2, %edi
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	set_cpu
	movl	$16000000, %edi
	call	malloc@PLT
	movl	$16000000, %edi
	movq	%rax, %rbp
	call	malloc@PLT
	movl	$16000000, %edi
	movq	%rax, %r12
	call	malloc@PLT
	movq	%rbp, %rsi
	xorl	%edx, %edx
	movl	$3435973837, %r10d
	movq	%rax, %rbx
.L17:
	leal	(%rdx,%rdx), %ecx
	movq	%rsi, %r8
	leal	2000(%rdx), %r11d
	movq	%rsi, %rdi
.L18:
	movl	%ecx, %eax
	addq	$4, %rdi
	addq	$8000, %r8
	imulq	%r10, %rax
	shrq	$35, %rax
	leal	(%rax,%rax,4), %r9d
	movl	%ecx, %eax
	addl	$1, %ecx
	addl	%r9d, %r9d
	subl	%r9d, %eax
	movl	%eax, -4(%rdi)
	movl	%eax, -8000(%r8)
	cmpl	%r11d, %ecx
	jne	.L18
	addl	$1, %edx
	addq	$8004, %rsi
	cmpl	$2000, %edx
	jne	.L17
	movl	$16000000, %edx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	xorl	%r14d, %r14d
	call	memcpy@PLT
	leaq	16000000(%r12), %r13
	call	clock@PLT
	movq	%rax, %r15
.L20:
	movq	%rbx, %rsi
	xorl	%edi, %edi
.L26:
	imulq	$8000, %rdi, %r8
	movq	%r13, %rcx
	leaq	8000(%rsi), %r9
	addq	%rbp, %r8
.L22:
	leaq	-16000000(%rcx), %rax
	movq	%r8, %rdx
	pxor	%xmm3, %xmm3
	.p2align 4,,10
	.p2align 3
.L21:
	movd	(%rdx), %xmm4
	movdqu	(%rax), %xmm1
	addq	$8000, %rax
	addq	$4, %rdx
	movdqu	-8000(%rax), %xmm0
	pshufd	$0, %xmm4, %xmm2
	pmuludq	%xmm2, %xmm1
	psrlq	$32, %xmm0
	psrlq	$32, %xmm2
	pmuludq	%xmm2, %xmm0
	pshufd	$8, %xmm1, %xmm1
	pshufd	$8, %xmm0, %xmm0
	punpckldq	%xmm0, %xmm1
	paddd	%xmm1, %xmm3
	cmpq	%rcx, %rax
	jne	.L21
	movups	%xmm3, (%rsi)
	addq	$16, %rsi
	leaq	16(%rax), %rcx
	cmpq	%r9, %rsi
	jne	.L22
	addq	$1, %rdi
	cmpq	$2000, %rdi
	jne	.L26
	call	clock@PLT
	pxor	%xmm0, %xmm0
	addl	$1, %r14d
	movsd	.LC5(%rip), %xmm5
	subq	%r15, %rax
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC4(%rip), %xmm0
	comisd	%xmm0, %xmm5
	ja	.L20
	movl	%r14d, %edx
	movl	$2, %edi
	movl	$1, %eax
	leaq	.LC6(%rip), %rsi
	call	__printf_chk@PLT
	cmpl	$1234, (%rbx)
	je	.L38
.L27:
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movsd	.LC3(%rip), %xmm1
	movsd	.LC7(%rip), %xmm0
#APP
# 98 "main.c" 1
	rdtscp

# 0 "" 2
#NO_APP
	movq	%rax, %rcx
	movl	$1000000000, %eax
.L28:
	mulsd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm1
	subl	$2, %eax
	jne	.L28
#APP
# 104 "main.c" 1
	rdtscp

# 0 "" 2
#NO_APP
	subq	%rcx, %rax
	movq	%rax, %rdx
	js	.L29
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
.L30:
	leaq	.LC9(%rip), %rsi
	movl	$2, %edi
	movl	$2, %eax
	divsd	.LC8(%rip), %xmm0
	call	__printf_chk@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
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
.L38:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	print_matrix
	jmp	.L27
.L29:
	movq	%rdx, %rcx
	shrq	%rax
	pxor	%xmm0, %xmm0
	andl	$1, %ecx
	orq	%rcx, %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L30
	.cfi_endproc
.LFE64:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	-1717986918
	.long	1072798105
	.align 8
.LC4:
	.long	0
	.long	1093567616
	.align 8
.LC5:
	.long	858993459
	.long	1076769587
	.align 8
.LC7:
	.long	-1030792151
	.long	1072703733
	.align 8
.LC8:
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
