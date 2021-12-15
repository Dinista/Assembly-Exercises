.section .data

	n1:		.int	0
	n2:		.int	0
	n3:		.int	0
    n4:		.int	0

	tipoN:		.asciz	"%d"

	resp:		.int	0

	tipoC:		.asciz	" %c"

	abertura:	.asciz	"\nPrograma Ordena 4 Numeros\n\n"

	pedeN:		.asciz	"\nDigite o numero %d = > "

	mostraN:	.asciz	"\nNumeros ordenados: %d, %d, %d, %d\n\n"

	perg:		.asciz	"\nDeseja reexecutar <s>/<n>? => "


.section .text

	
.globl _start

_start:

	pushl	$abertura
	call	printf

	pushl	$1
	pushl	$pedeN
	call	printf

	pushl	$n1
	pushl	$tipoN
	call	scanf

	pushl	$2
	pushl	$pedeN
	call	printf

	pushl	$n2
	pushl	$tipoN
	call	scanf

	pushl	$3
	pushl	$pedeN
	call	printf

	pushl	$n3
	pushl	$tipoN
	call	scanf

    pushl	$4
	pushl	$pedeN
	call	printf

	pushl	$n4
	pushl	$tipoN
	call	scanf

	movl	n2, %eax
	cmpl	n1, %eax
	jg	_n1_n2

	
_n2_n1:	

	movl	n3, %eax
	cmpl	n1, %eax
	jg	_n2_n1_n3

	cmpl	n2, %eax
	jg	_n2_n3_n1

_n1_n2:

	movl	n3, %eax
	cmpl	n2, %eax
	jg	_n1_n2_n3

	cmpl	n1, %eax
	jg	_n1_n3_n2


_n3_n2_n1:
    movl n4, %eax
    cmpl n1, %eax
    jl _n3_n2_n4_n1

	pushl   n4
    pushl	n1
	pushl	n2
	pushl	n3
	pushl	$mostraN
	call	printf
	jmp	_fim

_n3_n2_n4_n1:
    cmpl n2, %eax
    jl _n3_n4_n2_n1

    pushl   n1
    pushl	n4
	pushl	n2
	pushl	n3
	pushl	$mostraN
	call	printf
	jmp	_fim

_n3_n4_n2_n1:
    cmpl n3, %eax
    jl _n4_n3_n2_n1
    
    pushl   n1
    pushl	n2
	pushl	n4
	pushl	n3
	pushl	$mostraN
	call	printf
	jmp	_fim

_n4_n3_n2_n1:
    
    pushl   n1
    pushl	n2
	pushl	n3
	pushl	n4
	pushl	$mostraN
	call	printf
	jmp	_fim

_n3_n1_n2:

    movl n4, %eax
    cmpl n2, %eax
    jl _n3_n1_n4_n2
    
    pushl   n4
	pushl	n2
	pushl	n1
	pushl	n3
	pushl	$mostraN
	call	printf
	jmp	_fim

_n3_n1_n4_n2:
    cmpl n1, %eax
    jl _n3_n4_n1_n2

    pushl   n2
	pushl	n4
	pushl	n1
	pushl	n3
	pushl	$mostraN
	call	printf
	jmp	_fim

_n3_n4_n1_n2:
    cmpl n3, %eax
    jl _n4_n3_n1_n2

    pushl   n2
	pushl	n1
	pushl	n4
	pushl	n3
	pushl	$mostraN
	call	printf
	jmp	_fim


_n4_n3_n1_n2:
    pushl   n2
	pushl	n1
	pushl	n3
	pushl	n4
	pushl	$mostraN
	call	printf
	jmp	_fim

_n2_n1_n3:
    
    movl n4, %eax
    cmpl n3, %eax
    jl _n2_n1_n4_n3
    
    pushl   n4
	pushl	n3
	pushl	n1
	pushl	n2
	pushl	$mostraN
	call	printf
	jmp	_fim

_n2_n1_n4_n3:
    cmpl n1, %eax
    jl _n2_n4_n1_n3

    pushl   n3
	pushl	n4
	pushl	n1
	pushl	n2
	pushl	$mostraN
	call	printf
	jmp	_fim

_n2_n4_n1_n3:
    cmpl n2, %eax
    jl _n4_n2_n1_n3

    pushl   n3
	pushl	n1
	pushl	n4
	pushl	n2
	pushl	$mostraN
	call	printf
	jmp	_fim


_n4_n2_n1_n3:

    pushl   n3
	pushl	n1
	pushl	n2
	pushl	n4
	pushl	$mostraN
	call	printf
	jmp	_fim


_n2_n3_n1:

    movl n4, %eax
    cmpl n1, %eax
    jl _n2_n3_n4_n1

    pushl   n4
	pushl	n1
	pushl	n3
	pushl	n2
	pushl	$mostraN
	call	printf
	jmp	_fim


_n2_n3_n4_n1:
    cmpl n3, %eax
    jl _n2_n4_n3_n1

    pushl   n1
	pushl	n4
	pushl	n3
	pushl	n2
	pushl	$mostraN
	call	printf
	jmp	_fim

_n2_n4_n3_n1:
    cmpl n2, %eax
    jl _n4_n2_n3_n1
    
    pushl   n1
	pushl	n3
	pushl	n4
	pushl	n2
	pushl	$mostraN
	call	printf
	jmp	_fim

_n4_n2_n3_n1:
    
    pushl   n1
	pushl	n3
	pushl	n2
	pushl	n4
	pushl	$mostraN
	call	printf
	jmp	_fim

_n1_n2_n3:
    
    movl n4, %eax
    cmpl n3, %eax
    
    jl _n1_n2_n4_n3

    pushl	n4
    pushl   n3
	pushl	n2
	pushl	n1
	pushl	$mostraN
	call	printf
	jmp	_fim



_n1_n2_n4_n3:
	
    cmpl n2, %eax

    jl _n1_n4_n2_n3
    
    pushl	n3
    pushl   n4
	pushl	n2
	pushl	n1
	pushl	$mostraN
	call	printf
	jmp	_fim


_n1_n4_n2_n3:
    cmpl n1, %eax
    jl _n4_n1_n2_n3
    
    pushl	n3
	pushl	n2
	pushl	n4
    pushl	n1
	pushl	$mostraN
	call	printf
    jmp	_fim

_n4_n1_n2_n3:
    pushl	n3
    pushl	n2
    pushl	n1
    pushl	n4
	pushl	$mostraN
	call	printf
    jmp	_fim


_n1_n3_n2:
	pushl	n2
	pushl	n3
	pushl	n1
	pushl	$mostraN
	call	printf

_fim:


	pushl	$perg
	call	printf

	pushl	$resp
	pushl	$tipoC
	call	scanf

	addl	$80, %esp

	movl	resp, %eax
	cmpl	$'s', %eax
	je	_start
	
	pushl	$0
	call	exit

