	.text
	.file	"licm_test.bc"
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
	subq	$64, %rsp
	movl	$0, -44(%rbp)
	movl	%edi, -40(%rbp)
	movq	%rsi, -32(%rbp)
	cmpl	$4, -40(%rbp)
	jle	.LBB0_10
# BB#1:                                 # %if.end
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdi
	callq	atoi
	movl	%eax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	16(%rax), %rdi
	callq	atoi
	movl	%eax, -8(%rbp)
	movq	-32(%rbp), %rax
	movq	24(%rax), %rdi
	callq	atoi
	movl	%eax, -4(%rbp)
	movq	-32(%rbp), %rax
	movq	32(%rax), %rdi
	callq	atoi
	movl	%eax, -24(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, i2(%rip)
	movl	-8(%rbp), %eax
	movl	%eax, i2+4(%rip)
	movl	$0, -12(%rbp)
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_8:                                # %for.end
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	-8(%rbp), %eax
	addl	-4(%rbp), %eax
	movl	%eax, i2+4(%rip)
	incl	-12(%rbp)
.LBB0_2:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_4 Depth 2
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.LBB0_9
# BB#3:                                 # %for.body
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	$0, -20(%rbp)
	jmp	.LBB0_4
	.p2align	4, 0x90
.LBB0_7:                                # %if.end17
                                        #   in Loop: Header=BB0_4 Depth=2
	movl	-4(%rbp), %eax
	subl	%eax, -16(%rbp)
	incl	-20(%rbp)
.LBB0_4:                                # %for.cond9
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	.LBB0_8
# BB#5:                                 # %for.body11
                                        #   in Loop: Header=BB0_4 Depth=2
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %ecx
	cltd
	idivl	%ecx
	imull	-12(%rbp), %ecx
	addl	%eax, %ecx
	movl	%ecx, -16(%rbp)
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	addl	i2(%rip), %eax
	movl	%eax, -36(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jne	.LBB0_7
# BB#6:                                 # %if.then15
                                        #   in Loop: Header=BB0_4 Depth=2
	movl	-16(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB0_7
.LBB0_9:                                # %for.end21
	movl	-16(%rbp), %esi
	movl	-8(%rbp), %edx
	movl	-4(%rbp), %ecx
	movl	-24(%rbp), %r8d
	movl	-36(%rbp), %r9d
	movl	i2(%rip), %eax
	movl	i2+4(%rip), %edi
	movl	%edi, 8(%rsp)
	movl	%eax, (%rsp)
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	-44(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	retq
.LBB0_10:                               # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"USAGE: licm a b c d\n"
	.size	.L.str, 21

	.type	i2,@object              # @i2
	.comm	i2,8,4
	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"%d %d %d %d %d %d %d\n"
	.size	.L.str.1, 22


	.ident	"clang version 3.9.0 "
	.section	".note.GNU-stack","",@progbits
