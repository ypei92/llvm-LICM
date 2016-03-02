	.text
	.file	"loc_test.bc"
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
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
	subq	$112, %rsp
	movl	$0, -52(%rbp)
	movl	%edi, -68(%rbp)
	movq	%rsi, -64(%rbp)
	movq	8(%rsi), %rdi
	callq	atoi
	movl	%eax, -8(%rbp)
	movq	-64(%rbp), %rax
	movq	16(%rax), %rdi
	callq	atoi
	movl	%eax, -40(%rbp)
	movq	-64(%rbp), %rax
	movq	24(%rax), %rdi
	callq	atoi
	movl	%eax, -16(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$10, -108(%rbp)
	.p2align	4, 0x90
.LBB0_1:                                # %do.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cltd
	idivl	-8(%rbp)
	movl	%eax, -36(%rbp)
	movl	-4(%rbp), %eax
	incl	%eax
	movl	%eax, -4(%rbp)
	cmpl	$5, %eax
	jl	.LBB0_1
# BB#2:                                 # %do.end
	movl	$0, -4(%rbp)
	jmp	.LBB0_3
	.p2align	4, 0x90
.LBB0_4:                                # %while.body
                                        #   in Loop: Header=BB0_3 Depth=1
	movl	-16(%rbp), %eax
	cltd
	idivl	-8(%rbp)
	movl	%eax, -36(%rbp)
	incl	-4(%rbp)
.LBB0_3:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$4, -4(%rbp)
	jle	.LBB0_4
# BB#5:                                 # %while.end
	movl	$0, -4(%rbp)
	jmp	.LBB0_6
	.p2align	4, 0x90
.LBB0_10:                               # %for.inc18
                                        #   in Loop: Header=BB0_6 Depth=1
	incl	-4(%rbp)
.LBB0_6:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_8 Depth 2
	cmpl	$1, -4(%rbp)
	jg	.LBB0_11
# BB#7:                                 # %for.body
                                        #   in Loop: Header=BB0_6 Depth=1
	movl	$0, -12(%rbp)
	jmp	.LBB0_8
	.p2align	4, 0x90
.LBB0_9:                                # %for.inc
                                        #   in Loop: Header=BB0_8 Depth=2
	movl	-8(%rbp), %eax
	imull	-40(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-16(%rbp), %eax
	shll	$2, %eax
	movl	%eax, -44(%rbp)
	addl	-48(%rbp), %eax
	movl	%eax, -32(%rbp)
	imull	$3, -44(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	-12(%rbp), %eax
	addl	-4(%rbp), %eax
	movl	%eax, -24(%rbp)
	movl	-40(%rbp), %eax
	movslq	-8(%rbp), %rcx
	addl	-112(%rbp,%rcx,4), %eax
	movl	%eax, -20(%rbp)
	incl	-12(%rbp)
.LBB0_8:                                # %for.cond10
                                        #   Parent Loop BB0_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$1, -12(%rbp)
	jle	.LBB0_9
	jmp	.LBB0_10
.LBB0_11:                               # %for.end20
	movl	-36(%rbp), %esi
	movl	-32(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-20(%rbp), %r9d
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	movl	-52(%rbp), %eax
	addq	$112, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d %d %d %d %d\n"
	.size	.L.str, 16


	.ident	"clang version 3.9.0 (http://llvm.org/git/clang.git e88720a6287e5fa399e833ed5ddf4f0b475c37bd) (http://llvm.org/git/llvm.git 9867695c88ba0998618aa879e86315800c49c7c8)"
	.section	".note.GNU-stack","",@progbits
