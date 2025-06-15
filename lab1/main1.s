	.file	"main1.c"
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
	addq	$38452400, %r13
	leaq	.LC2(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	12400(%rdi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	.p2align 4,,10
	.p2align 3
.L11:
	leaq	-12400(%rbp), %rbx
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
	leaq	12400(%rbx), %rbp
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
.LC12:
	.string	"End of warming up\nTime: %f\nIter count: %d\n\n"
	.align 8
.LC16:
	.string	"End of lab\nTicks taken: %lld\nThroughput: %f\nResult: %f\n"
	.align 8
.LC17:
	.string	"Result1: %f\nResult2: %f\nResult3: %f\nResult4: %f\nResult5: %f\nResult6: %f\n"
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	call	set_cpu
	movl	$38440000, %edi
	call	malloc@PLT
	movl	$38440000, %edi
	movq	%rax, %rbp
	call	malloc@PLT
	movl	$38440000, %edi
	movq	%rax, %r12
	call	malloc@PLT
	movq	%rbp, %rsi
	xorl	%edx, %edx
	movl	$3435973837, %r10d
	movq	%rax, %rbx
.L17:
	leal	(%rdx,%rdx), %ecx
	movq	%rsi, %r8
	leal	3100(%rdx), %r11d
	movq	%rsi, %rdi
.L18:
	movl	%ecx, %eax
	addq	$4, %rdi
	addq	$12400, %r8
	imulq	%r10, %rax
	shrq	$35, %rax
	leal	(%rax,%rax,4), %r9d
	movl	%ecx, %eax
	addl	$1, %ecx
	addl	%r9d, %r9d
	subl	%r9d, %eax
	movl	%eax, -4(%rdi)
	movl	%eax, -12400(%r8)
	cmpl	%r11d, %ecx
	jne	.L18
	addl	$1, %edx
	addq	$12404, %rsi
	cmpl	$3100, %edx
	jne	.L17
	movl	$38440000, %edx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	xorl	%r14d, %r14d
	call	memcpy@PLT
	leaq	38440000(%r12), %r13
	call	clock@PLT
	movq	%rax, %r15
.L20:
	movq	%rbx, %rsi
	xorl	%edi, %edi
.L26:
	imulq	$12400, %rdi, %r8
	movq	%r13, %rcx
	leaq	12400(%rsi), %r9
	addq	%rbp, %r8
.L22:
	leaq	-38440000(%rcx), %rax
	movq	%r8, %rdx
	pxor	%xmm3, %xmm3
	.p2align 4,,10
	.p2align 3
.L21:
	movd	(%rdx), %xmm6
	movdqu	(%rax), %xmm1
	addq	$12400, %rax
	addq	$4, %rdx
	movdqu	-12400(%rax), %xmm0
	pshufd	$0, %xmm6, %xmm2
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
	cmpq	$3100, %rdi
	jne	.L26
	call	clock@PLT
	pxor	%xmm0, %xmm0
	addl	$1, %r14d
	movsd	.LC11(%rip), %xmm7
	subq	%r15, %rax
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC10(%rip), %xmm0
	comisd	%xmm0, %xmm7
	ja	.L20
	movl	%r14d, %edx
	movl	$2, %edi
	movl	$1, %eax
	leaq	.LC12(%rip), %rsi
	call	__printf_chk@PLT
	cmpl	$1234, (%rbx)
	je	.L37
.L27:
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movsd	.LC3(%rip), %xmm5
	movsd	.LC4(%rip), %xmm4
	movsd	.LC5(%rip), %xmm3
	movsd	.LC6(%rip), %xmm2
	movsd	.LC7(%rip), %xmm7
	movsd	.LC8(%rip), %xmm6
	movsd	.LC9(%rip), %xmm1
	movsd	.LC13(%rip), %xmm0
#APP
# 99 "main1.c" 1
	rdtscp

# 0 "" 2
#NO_APP
	movq	%rax, %rcx
	movl	$1000000000, %eax
.L28:
	mulsd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm6
	mulsd	%xmm0, %xmm7
	mulsd	%xmm0, %xmm2
	mulsd	%xmm0, %xmm3
	mulsd	%xmm0, %xmm4
	mulsd	%xmm0, %xmm5
	subl	$1, %eax
	jne	.L28
#APP
# 111 "main1.c" 1
	rdtscp

# 0 "" 2
#NO_APP
	subq	%rcx, %rax
	movq	%rax, %rdx
	js	.L29
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
.L30:
	movl	$2, %edi
	movl	$2, %eax
	leaq	.LC16(%rip), %rsi
	movsd	%xmm5, 40(%rsp)
	movsd	%xmm4, 32(%rsp)
	divsd	.LC14(%rip), %xmm0
	divsd	.LC15(%rip), %xmm0
	movsd	%xmm3, 24(%rsp)
	movsd	%xmm2, 16(%rsp)
	movsd	%xmm7, 8(%rsp)
	movsd	%xmm6, (%rsp)
	call	__printf_chk@PLT
	movsd	8(%rsp), %xmm7
	movsd	(%rsp), %xmm6
	leaq	.LC17(%rip), %rsi
	movsd	40(%rsp), %xmm5
	movl	$2, %edi
	movl	$6, %eax
	movsd	32(%rsp), %xmm4
	movsd	24(%rsp), %xmm3
	movsd	16(%rsp), %xmm2
	movapd	%xmm7, %xmm1
	movapd	%xmm6, %xmm0
	call	__printf_chk@PLT
	addq	$56, %rsp
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
.L37:
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
	.long	99252915
	.long	1047710301
	.align 8
.LC4:
	.long	698640683
	.long	1047534379
	.align 8
.LC5:
	.long	-1698910392
	.long	1047189490
	.align 8
.LC6:
	.long	-500134854
	.long	1046837646
	.align 8
.LC7:
	.long	698640683
	.long	1046485803
	.align 8
.LC8:
	.long	-500134854
	.long	1045789070
	.align 8
.LC9:
	.long	-500134854
	.long	1044740494
	.align 8
.LC10:
	.long	0
	.long	1093567616
	.align 8
.LC11:
	.long	-858993459
	.long	1078856908
	.align 8
.LC13:
	.long	45035996
	.long	1072693248
	.align 8
.LC14:
	.long	0
	.long	1104006501
	.align 8
.LC15:
	.long	0
	.long	1075576832
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
