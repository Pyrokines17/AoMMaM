	.text
	.file	"non_temp.c"
	.globl	set_cpu                         # -- Begin function set_cpu
	.p2align	4, 0x90
	.type	set_cpu,@function
set_cpu:                                # 
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$128, %rsp
	.cfi_def_cfa_offset 144
	.cfi_offset %rbx, -16
	movl	%edi, %ebx
	callq	pthread_self
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, 96(%rsp)
	vmovups	%ymm0, 64(%rsp)
	vmovups	%ymm0, 32(%rsp)
	vmovups	%ymm0, (%rsp)
	cmpl	$1023, %ebx                     # imm = 0x3FF
	ja	.LBB0_2
# %bb.1:
	movl	$1, %ecx
	shlxq	%rbx, %rcx, %rcx
	movl	%ebx, %edx
	shrl	$6, %edx
	orq	%rcx, (%rsp,%rdx,8)
.LBB0_2:
	movq	%rsp, %rdx
	movl	$128, %esi
	movq	%rax, %rdi
	vzeroupper
	callq	pthread_setaffinity_np
	testl	%eax, %eax
	jne	.LBB0_3
# %bb.4:
	movl	$.L.str.1, %edi
	movl	%ebx, %esi
	xorl	%eax, %eax
	callq	printf
	addq	$128, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB0_3:
	.cfi_def_cfa_offset 144
	movq	stderr(%rip), %rdi
	movl	$.L.str, %esi
	movl	%ebx, %edx
	xorl	%eax, %eax
	callq	fprintf
	addq	$128, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	set_cpu, .Lfunc_end0-set_cpu
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function int_write
.LCPI1_0:
	.quad	0x408f400000000000              #  1000
.LCPI1_1:
	.quad	4294967297                      # 0x100000001
.LCPI1_2:
	.quad	0x3e112e0be826d695              #  1.0000000000000001E-9
.LCPI1_3:
	.quad	0x3e10000000000000              #  9.3132257461547852E-10
	.text
	.globl	int_write
	.p2align	4, 0x90
	.type	int_write,@function
int_write:                              # 
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdi, %r15
	movq	%rsi, %rax
	shrq	$2, %rax
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	cmpq	$4, %rsi
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	jae	.LBB1_1
# %bb.9:
	leaq	32(%rsp), %r12
	movl	$1, %edi
	movq	%r12, %rsi
	callq	clock_gettime
	leaq	16(%rsp), %r13
	movl	$1, %edi
	movq	%r13, %rsi
	callq	clock_gettime
	movq	stdout(%rip), %rdi
	movl	(%r15), %edx
	movl	40(%r15), %ecx
	movl	80(%r15), %r8d
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	subq	32(%rsp), %rax
	vcvtsi2sd	%rax, %xmm0, %xmm0
	subq	40(%rsp), %rcx
	vcvtsi2sd	%rcx, %xmm1, %xmm1
	vfmadd132sd	.LCPI1_2(%rip), %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
	vminsd	.LCPI1_0(%rip), %xmm1, %xmm0
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	movl	$1, %edi
	movq	%r12, %rsi
	callq	clock_gettime
	movl	$1, %edi
	movq	%r13, %rsi
	callq	clock_gettime
	movq	stdout(%rip), %rdi
	movl	(%r15), %edx
	movl	40(%r15), %ecx
	movl	80(%r15), %r8d
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	subq	32(%rsp), %rax
	vcvtsi2sd	%rax, %xmm2, %xmm0
	subq	40(%rsp), %rcx
	vcvtsi2sd	%rcx, %xmm2, %xmm1
	vfmadd132sd	.LCPI1_2(%rip), %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
	vminsd	(%rsp), %xmm1, %xmm0            # 8-byte Folded Reload
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	movl	$1, %edi
	movq	%r12, %rsi
	callq	clock_gettime
	movl	$1, %edi
	movq	%r13, %rsi
	callq	clock_gettime
	movq	stdout(%rip), %rdi
	movl	(%r15), %edx
	movl	40(%r15), %ecx
	movl	80(%r15), %r8d
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	subq	32(%rsp), %rax
	vcvtsi2sd	%rax, %xmm2, %xmm0
	subq	40(%rsp), %rcx
	vcvtsi2sd	%rcx, %xmm2, %xmm1
	vfmadd132sd	.LCPI1_2(%rip), %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
	vminsd	(%rsp), %xmm1, %xmm0            # 8-byte Folded Reload
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
.LBB1_8:
	movq	stdout(%rip), %rdi
	movl	$.L.str.3, %esi
	movq	48(%rsp), %rdx                  # 8-byte Reload
	xorl	%eax, %eax
	callq	fprintf
	vcvtusi2sdq	8(%rsp), %xmm2, %xmm0   # 8-byte Folded Reload
	vmulsd	.LCPI1_3(%rip), %xmm0, %xmm1
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vdivsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, 8(%rsp)                  # 8-byte Spill
	movq	stdout(%rip), %rdi
	movl	$.L.str.4, %esi
	movb	$1, %al
	callq	fprintf
	vmovsd	8(%rsp), %xmm0                  # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addq	$72, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB1_1:
	.cfi_def_cfa_offset 128
	leaq	31(%rax), %r14
	movq	%r14, %rbp
	shrq	$8, %rbp
	leaq	(,%rbp,8), %r12
	shrq	$5, %r14
	leaq	-1(%rax), %rcx
	shrq	$5, %rcx
	leaq	960(%r15), %rbx
	movq	%rbp, %rax
	shlq	$10, %rax
	leaq	64(%rax,%r15), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	subq	%r12, %rcx
	incq	%rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	vmovsd	.LCPI1_0(%rip), %xmm0           # xmm0 = [1.0E+3,0.0E+0]
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	xorl	%r13d, %r13d
	jmp	.LBB1_2
	.p2align	4, 0x90
.LBB1_7:                                #   in Loop: Header=BB1_2 Depth=1
	movl	$1, %edi
	leaq	16(%rsp), %rsi
	vzeroupper
	callq	clock_gettime
	movq	stdout(%rip), %rdi
	movl	(%r15), %edx
	movl	40(%r15), %ecx
	movl	80(%r15), %r8d
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	subq	32(%rsp), %rax
	vcvtsi2sd	%rax, %xmm2, %xmm0
	subq	40(%rsp), %rcx
	vcvtsi2sd	%rcx, %xmm2, %xmm1
	vfmadd132sd	.LCPI1_2(%rip), %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vminsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	incq	%r13
	cmpq	$3, %r13
	je	.LBB1_8
.LBB1_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_3 Depth 2
                                        #     Child Loop BB1_6 Depth 2
	movl	$1, %edi
	leaq	32(%rsp), %rsi
	callq	clock_gettime
	movq	%rbp, %rax
	movq	%rbx, %rcx
	cmpq	$900, 8(%rsp)                   # 8-byte Folded Reload
                                        # imm = 0x384
	vbroadcastsd	.LCPI1_1(%rip), %zmm0   # zmm0 = [4294967297,4294967297,4294967297,4294967297,4294967297,4294967297,4294967297,4294967297]
	jb	.LBB1_4
	.p2align	4, 0x90
.LBB1_3:                                #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovntpd	%zmm0, -960(%rcx)
	vmovntpd	%zmm0, -896(%rcx)
	vmovntpd	%zmm0, -832(%rcx)
	vmovntpd	%zmm0, -768(%rcx)
	vmovntpd	%zmm0, -704(%rcx)
	vmovntpd	%zmm0, -640(%rcx)
	vmovntpd	%zmm0, -576(%rcx)
	vmovntpd	%zmm0, -512(%rcx)
	vmovntpd	%zmm0, -448(%rcx)
	vmovntpd	%zmm0, -384(%rcx)
	vmovntpd	%zmm0, -320(%rcx)
	vmovntpd	%zmm0, -256(%rcx)
	vmovntpd	%zmm0, -192(%rcx)
	vmovntpd	%zmm0, -128(%rcx)
	vmovntpd	%zmm0, -64(%rcx)
	vmovntpd	%zmm0, (%rcx)
	addq	$1024, %rcx                     # imm = 0x400
	decq	%rax
	jne	.LBB1_3
.LBB1_4:                                #   in Loop: Header=BB1_2 Depth=1
	cmpq	%r14, %r12
	jae	.LBB1_7
# %bb.5:                                #   in Loop: Header=BB1_2 Depth=1
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	56(%rsp), %rcx                  # 8-byte Reload
	.p2align	4, 0x90
.LBB1_6:                                #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovntpd	%zmm0, -64(%rcx)
	vmovntpd	%zmm0, (%rcx)
	subq	$-128, %rcx
	decq	%rax
	jne	.LBB1_6
	jmp	.LBB1_7
.Lfunc_end1:
	.size	int_write, .Lfunc_end1-int_write
	.cfi_endproc
                                        # -- End function
	.globl	thread_func                     # -- Begin function thread_func
	.p2align	4, 0x90
	.type	thread_func,@function
thread_func:                            # 
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$152, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movl	(%rdi), %r14d
	movq	8(%rdi), %r12
	leaq	16(%rsp), %rdi
	movl	$64, %esi
	movq	%r12, %rdx
	callq	posix_memalign
	testl	%eax, %eax
	jne	.LBB2_2
# %bb.1:
	movq	16(%rsp), %r15
	testq	%r15, %r15
	je	.LBB2_2
# %bb.3:
	callq	pthread_self
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, 112(%rsp)
	vmovups	%ymm0, 80(%rsp)
	vmovups	%ymm0, 48(%rsp)
	vmovups	%ymm0, 16(%rsp)
	cmpl	$1023, %r14d                    # imm = 0x3FF
	ja	.LBB2_5
# %bb.4:
	movl	$1, %ecx
	shlxq	%r14, %rcx, %rcx
	movl	%r14d, %edx
	shrl	$6, %edx
	orq	%rcx, 16(%rsp,%rdx,8)
.LBB2_5:
	leaq	16(%rsp), %rdx
	movl	$128, %esi
	movq	%rax, %rdi
	vzeroupper
	callq	pthread_setaffinity_np
	testl	%eax, %eax
	jne	.LBB2_6
# %bb.7:
	movl	$.L.str.1, %edi
	movl	%r14d, %esi
	xorl	%eax, %eax
	callq	printf
.LBB2_8:
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	int_write
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	movq	stdout(%rip), %rdi
	movl	$.L.str.6, %esi
	movl	%r14d, %edx
	movb	$1, %al
	callq	fprintf
	movq	%r15, %rdi
	callq	free
	movq	%rbx, %rdi
	callq	free
	movl	$8, %edi
	callq	malloc
	vmovsd	8(%rsp), %xmm0                  # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rax)
.LBB2_9:
	addq	$152, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB2_2:
	.cfi_def_cfa_offset 192
	movq	stderr(%rip), %rcx
	movl	$.L.str.5, %edi
	movl	$25, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	xorl	%eax, %eax
	jmp	.LBB2_9
.LBB2_6:
	movq	stderr(%rip), %rdi
	movl	$.L.str, %esi
	movl	%r14d, %edx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB2_8
.Lfunc_end2:
	.size	thread_func, .Lfunc_end2-thread_func
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # 
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$216, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	vstmxcsr	-256(%rbp)
	orl	$32832, -256(%rbp)              # imm = 0x8040
	movq	%rsi, %r13
	vldmxcsr	-256(%rbp)
	cmpl	$3, %edi
	jne	.LBB3_1
# %bb.2:
	callq	pthread_self
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, -160(%rbp)
	vmovupd	%ymm0, -184(%rbp)
	vmovupd	%ymm0, -216(%rbp)
	vmovupd	%ymm0, -248(%rbp)
	movq	$1, -256(%rbp)
	leaq	-256(%rbp), %rdx
	movl	$128, %esi
	movq	%rax, %rdi
	vzeroupper
	callq	pthread_setaffinity_np
	testl	%eax, %eax
	jne	.LBB3_3
# %bb.4:
	movl	$.L.str.1, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
.LBB3_5:
	movq	8(%r13), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	__isoc23_strtol
	movq	%rax, %r15
	movq	16(%r13), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	__isoc23_strtol
	movq	%rax, %r14
	movq	%rsp, %rbx
	movl	%r14d, %eax
	leaq	15(,%rax,8), %rax
	andq	$-16, %rax
	movq	%rsp, %r12
	subq	%rax, %r12
	movq	%r12, %rsp
	movl	%r15d, %eax
	shll	$19, %eax
	cltq
	shlq	$10, %rax
	movslq	%r14d, %rcx
	movq	%rax, %rdx
	orq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, -104(%rbp)                # 8-byte Spill
	je	.LBB3_6
# %bb.7:
	xorl	%edx, %edx
	divq	%rcx
	jmp	.LBB3_8
.LBB3_6:
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%r14d
                                        # kill: def $eax killed $eax def $rax
.LBB3_8:
	leaq	-256(%rbp), %rdi
	movl	$64, %esi
	movq	%rax, -128(%rbp)                # 8-byte Spill
	movq	%rax, %rdx
	callq	posix_memalign
	testl	%eax, %eax
	jne	.LBB3_14
# %bb.9:
	movq	-256(%rbp), %rax
	movq	%rax, -96(%rbp)                 # 8-byte Spill
	testq	%rax, %rax
	je	.LBB3_14
# %bb.10:
	movq	%r12, -56(%rbp)                 # 8-byte Spill
	movq	%r15, -120(%rbp)                # 8-byte Spill
	movq	%rbx, -88(%rbp)                 # 8-byte Spill
	cmpl	$2, %r14d
	movq	%r13, -80(%rbp)                 # 8-byte Spill
	movq	%r14, -112(%rbp)                # 8-byte Spill
	jl	.LBB3_17
# %bb.11:
                                        # kill: def $r14d killed $r14d killed $r14 def $r14
	andl	$2147483647, %r14d              # imm = 0x7FFFFFFF
	movq	%r14, -64(%rbp)                 # 8-byte Spill
	leaq	-1(%r14), %rax
	movq	%rax, -72(%rbp)                 # 8-byte Spill
	cmpq	$2, %rax
	jb	.LBB3_45
# %bb.12:
	movq	-104(%rbp), %rax                # 8-byte Reload
	movq	%rax, %rcx
	shrq	$32, %rcx
	je	.LBB3_13
# %bb.39:
	xorl	%edx, %edx
	divq	-64(%rbp)                       # 8-byte Folded Reload
	movq	%rax, %rbx
	jmp	.LBB3_40
.LBB3_13:
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	-64(%rbp)                       # 4-byte Folded Reload
	movl	%eax, %ebx
.LBB3_40:
	movq	-56(%rbp), %rax                 # 8-byte Reload
	movq	-72(%rbp), %r15                 # 8-byte Reload
	shrq	%r15
	leaq	8(%rax), %r13
	movl	$1, %r14d
	.p2align	4, 0x90
.LBB3_41:                               # =>This Inner Loop Header: Depth=1
	movq	%r15, -48(%rbp)                 # 8-byte Spill
	movl	$24, %edi
	callq	malloc
	movq	%rax, %r12
	movl	%r14d, (%rax)
	movq	%rbx, 8(%rax)
	movl	$thread_func, %edx
	movq	%r13, %rdi
	xorl	%esi, %esi
	movq	%rax, %rcx
	callq	pthread_create
	testl	%eax, %eax
	jne	.LBB3_42
# %bb.43:                               #   in Loop: Header=BB3_41 Depth=1
	movl	$24, %edi
	callq	malloc
	movq	%rax, %r12
	movq	%rbx, %rax
	leal	1(%r14), %ebx
	movl	%ebx, (%r12)
	movq	%rax, %r15
	movq	%rax, 8(%r12)
	leaq	8(%r13), %rdi
	movl	$thread_func, %edx
	xorl	%esi, %esi
	movq	%r12, %rcx
	callq	pthread_create
	testl	%eax, %eax
	movq	-48(%rbp), %rax                 # 8-byte Reload
	jne	.LBB3_15
# %bb.44:                               #   in Loop: Header=BB3_41 Depth=1
	addl	$2, %r14d
	addq	$16, %r13
	decq	%rax
	movq	%r15, %rbx
	movq	%rax, %r15
	jne	.LBB3_41
.LBB3_45:
	movq	-72(%rbp), %rbx                 # 8-byte Reload
	testb	$1, %bl
	movq	-80(%rbp), %r13                 # 8-byte Reload
	movq	-112(%rbp), %r14                # 8-byte Reload
	je	.LBB3_17
# %bb.46:
	movl	$24, %edi
	callq	malloc
	movq	%rax, %r12
	movl	%ebx, (%rax)
	movq	-104(%rbp), %rax                # 8-byte Reload
	movq	%rax, %rcx
	shrq	$32, %rcx
	je	.LBB3_47
# %bb.48:
	xorl	%edx, %edx
	divq	-64(%rbp)                       # 8-byte Folded Reload
	jmp	.LBB3_49
.LBB3_47:
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	-64(%rbp)                       # 4-byte Folded Reload
                                        # kill: def $eax killed $eax def $rax
.LBB3_49:
	movq	%rax, 8(%r12)
	movq	-56(%rbp), %rax                 # 8-byte Reload
	leaq	(%rax,%rbx,8), %rdi
	movl	$thread_func, %edx
	xorl	%esi, %esi
	movq	%r12, %rcx
	callq	pthread_create
	testl	%eax, %eax
	jne	.LBB3_16
.LBB3_17:
	movq	-96(%rbp), %rdi                 # 8-byte Reload
	movq	-128(%rbp), %rsi                # 8-byte Reload
	callq	int_write
	movq	stdout(%rip), %rdi
	movl	$.L.str.9, %esi
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	movb	$1, %al
	callq	fprintf
	cmpl	$2, %r14d
	jl	.LBB3_18
# %bb.22:
	movl	%r14d, %r15d
	andl	$2147483647, %r15d              # imm = 0x7FFFFFFF
	leaq	-1(%r15), %r14
	cmpq	$4, %r14
	jae	.LBB3_23
.LBB3_33:
	movq	%r14, %rax
	andq	$-4, %r14
	cmpq	%rax, %r14
	jne	.LBB3_50
# %bb.34:
	movq	-80(%rbp), %r13                 # 8-byte Reload
.LBB3_18:
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
.LBB3_19:
	movq	stdout(%rip), %rdi
	movl	$.L.str.10, %esi
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	movb	$1, %al
	callq	fprintf
	movq	-96(%rbp), %rdi                 # 8-byte Reload
	callq	free
	movl	$.L.str.11, %edi
	movl	$.L.str.12, %esi
	callq	fopen
	testq	%rax, %rax
	je	.LBB3_20
# %bb.35:
	movq	%rax, %rbx
	movq	(%r13), %r15
	movq	%r15, %rdi
	callq	strlen
	movq	%rax, %r12
	movq	%r15, %rdi
	movl	$95, %esi
	callq	strchr@PLT
	movq	%rax, %r13
	subq	%r15, %rax
	movq	%rax, %r14
	notq	%r14
	addq	%r12, %r14
	subq	%rax, %r12
	movq	%r12, %rdi
	callq	malloc
	movq	%rax, %r15
	incq	%r13
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%r14, %rdx
	callq	strncpy
	movb	$0, (%r15,%r14)
	movq	-120(%rbp), %rax                # 8-byte Reload
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%eax, %edx
	sarl	%edx
	movl	$.L.str.15, %esi
	movq	%rbx, %rdi
	movq	-112(%rbp), %rcx                # 8-byte Reload
                                        # kill: def $ecx killed $ecx killed $rcx
	movq	%r15, %r8
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movb	$1, %al
	callq	fprintf
	movq	%rbx, %rdi
	callq	fclose
	movq	%r15, %rdi
	callq	free
	movq	stdout(%rip), %rcx
	movl	$.L.str.16, %edi
	movl	$21, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	xorl	%eax, %eax
.LBB3_36:
	movq	-88(%rbp), %rbx                 # 8-byte Reload
.LBB3_37:
	movq	%rbx, %rsp
.LBB3_38:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB3_23:
	.cfi_def_cfa %rbp, 16
	movq	%r14, %r13
	shrq	$2, %r13
	movq	-56(%rbp), %rax                 # 8-byte Reload
	leaq	32(%rax), %r12
	leaq	-256(%rbp), %rbx
	jmp	.LBB3_24
	.p2align	4, 0x90
.LBB3_32:                               #   in Loop: Header=BB3_24 Depth=1
	addq	$32, %r12
	decq	%r13
	je	.LBB3_33
.LBB3_24:                               # =>This Inner Loop Header: Depth=1
	movq	-24(%r12), %rdi
	movq	%rbx, %rsi
	callq	pthread_join
	movq	-256(%rbp), %rdi
	testq	%rdi, %rdi
	je	.LBB3_26
# %bb.25:                               #   in Loop: Header=BB3_24 Depth=1
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vaddsd	(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	callq	free
.LBB3_26:                               #   in Loop: Header=BB3_24 Depth=1
	movq	-16(%r12), %rdi
	movq	%rbx, %rsi
	callq	pthread_join
	movq	-256(%rbp), %rdi
	testq	%rdi, %rdi
	je	.LBB3_28
# %bb.27:                               #   in Loop: Header=BB3_24 Depth=1
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vaddsd	(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	callq	free
.LBB3_28:                               #   in Loop: Header=BB3_24 Depth=1
	movq	-8(%r12), %rdi
	movq	%rbx, %rsi
	callq	pthread_join
	movq	-256(%rbp), %rdi
	testq	%rdi, %rdi
	je	.LBB3_30
# %bb.29:                               #   in Loop: Header=BB3_24 Depth=1
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vaddsd	(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	callq	free
.LBB3_30:                               #   in Loop: Header=BB3_24 Depth=1
	movq	(%r12), %rdi
	movq	%rbx, %rsi
	callq	pthread_join
	movq	-256(%rbp), %rdi
	testq	%rdi, %rdi
	je	.LBB3_32
# %bb.31:                               #   in Loop: Header=BB3_24 Depth=1
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vaddsd	(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	callq	free
	jmp	.LBB3_32
.LBB3_50:
	incq	%r14
	leaq	-256(%rbp), %rbx
	movq	-80(%rbp), %r13                 # 8-byte Reload
	movq	-56(%rbp), %r12                 # 8-byte Reload
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	jmp	.LBB3_51
	.p2align	4, 0x90
.LBB3_53:                               #   in Loop: Header=BB3_51 Depth=1
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	incq	%r14
	cmpq	%r14, %r15
	je	.LBB3_19
.LBB3_51:                               # =>This Inner Loop Header: Depth=1
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	movq	(%r12,%r14,8), %rdi
	movq	%rbx, %rsi
	callq	pthread_join
	movq	-256(%rbp), %rdi
	testq	%rdi, %rdi
	je	.LBB3_53
# %bb.52:                               #   in Loop: Header=BB3_51 Depth=1
	vmovsd	-48(%rbp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vaddsd	(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -48(%rbp)                # 8-byte Spill
	callq	free
	jmp	.LBB3_53
.LBB3_1:
	movq	stderr(%rip), %rdi
	movq	(%r13), %rdx
	movl	$.L.str.7, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %eax
	jmp	.LBB3_38
.LBB3_3:
	movq	stderr(%rip), %rdi
	movl	$.L.str, %esi
	xorl	%edx, %edx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB3_5
.LBB3_14:
	movq	stderr(%rip), %rcx
	movl	$.L.str.5, %edi
	movl	$25, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %eax
	jmp	.LBB3_37
.LBB3_20:
	movq	stderr(%rip), %rcx
	movl	$.L.str.13, %edi
	movl	$32, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %eax
	jmp	.LBB3_36
.LBB3_42:
	movl	%r14d, %ebx
	jmp	.LBB3_16
.LBB3_15:
                                        # kill: def $ebx killed $ebx def $rbx
.LBB3_16:
	movq	stderr(%rip), %rdi
	movl	$.L.str.8, %esi
	movl	%ebx, %edx
	xorl	%eax, %eax
	callq	fprintf
	movq	%r12, %rdi
	callq	free
	movq	-96(%rbp), %rdi                 # 8-byte Reload
	callq	free
	movl	$1, %eax
	jmp	.LBB3_36
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # 
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"set_cpu: pthread_setaffinity failed for cpu %d\n"
	.size	.L.str, 48

	.type	.L.str.1,@object                # 
.L.str.1:
	.asciz	"set_cpu: set cpu %d\n"
	.size	.L.str.1, 21

	.type	.L.str.2,@object                # 
.L.str.2:
	.asciz	"Buffer have values in index 0, 10, 20: %d, %d, %d\n"
	.size	.L.str.2, 51

	.type	.L.str.3,@object                # 
.L.str.3:
	.asciz	"Buffer initialized with %zu elements\n"
	.size	.L.str.3, 38

	.type	.L.str.4,@object                # 
.L.str.4:
	.asciz	"Time taken for summation: %.6f seconds\n"
	.size	.L.str.4, 40

	.type	.L.str.5,@object                # 
.L.str.5:
	.asciz	"Memory allocation failed\n"
	.size	.L.str.5, 26

	.type	.L.str.6,@object                # 
.L.str.6:
	.asciz	"Thread %d Bandwidth: %.2f GB/s\n"
	.size	.L.str.6, 32

	.type	.L.str.7,@object                # 
.L.str.7:
	.asciz	"Usage: %s <count_halfs_of_gb> <thread_count>\n"
	.size	.L.str.7, 46

	.type	.L.str.8,@object                # 
.L.str.8:
	.asciz	"Error creating thread %d\n"
	.size	.L.str.8, 26

	.type	.L.str.9,@object                # 
.L.str.9:
	.asciz	"Bandwidth for first: %.2f GB/s\n"
	.size	.L.str.9, 32

	.type	.L.str.10,@object               # 
.L.str.10:
	.asciz	"Total Bandwidth: %.2f GB/s\n"
	.size	.L.str.10, 28

	.type	.L.str.11,@object               # 
.L.str.11:
	.asciz	"bandwidth.csv"
	.size	.L.str.11, 14

	.type	.L.str.12,@object               # 
.L.str.12:
	.asciz	"a"
	.size	.L.str.12, 2

	.type	.L.str.13,@object               # 
.L.str.13:
	.asciz	"Failed to open file for writing\n"
	.size	.L.str.13, 33

	.type	.L.str.15,@object               # 
.L.str.15:
	.asciz	"write;non_temp;1;%d;%d;2;%s;%.2f;\n"
	.size	.L.str.15, 35

	.type	.L.str.16,@object               # 
.L.str.16:
	.asciz	"Data written to file\n"
	.size	.L.str.16, 22

	.ident	"Intel(R) oneAPI DPC++/C++ Compiler 2025.0.4 (2025.0.4.20241205)"
	.section	".note.GNU-stack","",@progbits
