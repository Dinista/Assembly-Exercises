/* Programa que busca o elemento x em um vetor, caso exista, senão busca
   o mais proximo de x. Os numeros do vetot e x devem ser numeros positivos.
*/

.section .data

	abertura:  .asciz  "\nPrograma para Buscar Elemento em Vetor\n\n"

	pedeN:	   .asciz  "\nDigite o valor de n => "

	pedeX:     .asciz  "\nDigite o valor de x => "

	pedeElem:  .asciz  "\nDigite o elemento %d => "

	mostraPos: .asciz  "\n%d encontrado na posicao %d\n\n"

	valorInv:  .asciz  "\nValor Invalido!\n\n"

	n:	   	.int    0
    x: 	   	.int    0
    menorDif:       .int    0
	posMaisProx:   	.int	0
	maisProx:  	.int    0

	vetor:	   .space  120	# suficiente para alocar no maximo 30 inteiros (32 bits)

	tipoDado:  .asciz  "%d"

.section .text

.globl _start

_start:

	call	_abertura
	call	_leN
	call	_leVetor
	call	_leX
	call	_buscaX
	jmp	_fim

_abertura:

	pushl	$abertura
	call	printf
	addl	$4, %esp

	RET

_leN:	

	pushl	$pedeN
	call	printf
	pushl	$n
	pushl	$tipoDado
	call	scanf

	movl	n, %eax
	cmpl	$0, %eax
	jle	_nInvalido

	cmpl	$30, %eax
	jle	_nValido


_nInvalido:

	pushl	$valorInv
	call	printf

	addl	$20, %esp	#inclui o desempilhamento do endereco de retorno
	jmp	_fim

_nValido:

	addl	$12, %esp

	RET

_leVetor:

	movl	n, %ecx
	movl	$1, %ebx
	movl	$vetor, %edi

_volta1:

	pushl	%edi		# para backupear %edi
	pushl	%ecx		# para backupear %ecx
	pushl	%ebx
	pushl	$pedeElem
	call	printf

	pushl	$x
	pushl	$tipoDado
	call	scanf

	addl	$12, %esp
	popl	%ebx
	popl	%ecx
	popl	%edi

	movl	x, %eax
	movl	%eax, (%edi)
	addl	$4, %edi
	incl	%ebx

	loop	_volta1

	RET

_leX:

	pushl	$pedeX
	call	printf
	pushl	$x
	pushl	$tipoDado
	call	scanf

	addl	$12, %esp

	RET


_buscaX:

	movl	$vetor, %edi
	movl	$1, %ebx
	movl	(%edi),%eax
	addl	x, %eax
	movl	%eax, menorDif
	movl	n, %ecx
	
_volta2:

	movl	(%edi), %eax
	cmpl	x, %eax
	je	_saoIguais

	subl	x, %eax
	cmpl	$0, %eax
	jl	_trocaSinal

_cont:

	cmpl	menorDif, %eax
	jg	_cont2

	movl	%eax, menorDif
	movl	%ebx, posMaisProx
	movl	(%edi), %eax
	movl	%eax, maisProx

_cont2:
	
	addl	$4, %edi
	incl	%ebx
	
	loop	_volta2

_mostraProx:

	movl	maisProx, %edx	
	jmp	_mostraRes

_trocaSinal:

	negl	%eax	
	jmp	_cont
	

_saoIguais:

	movl	x, %edx
	movl	%ebx, posMaisProx

_mostraRes:

	pushl	posMaisProx
	pushl	%edx
	pushl	$mostraPos
	call	printf
	addl	$12, %esp	

	RET


_fim:

	pushl	vetor
	call	free

	pushl 	$0
	call	exit
