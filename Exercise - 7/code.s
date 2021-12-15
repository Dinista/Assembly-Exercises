# COMPARA IGUALDADE ENTRE VETORES

.section .data

	msgAbert:	.asciz "\n*** Programa Compara Igualdade entre Vetores 1.0 ***\n\n"
	pedeTam: 	.asciz "\nDigite o tamanho do %d vetor => "
	pedeNum: 	.asciz "Entre com o numero %d => "

	msgLeit: 	.asciz "\nLEITURA DO VETOR %d:\n\n"
	mostraVet: 	.asciz "\nVetor %d Lido : "

	tipoIn: 	.asciz "%d"
	tipoOut: 	.asciz " %d"

	msgIguais: 	.asciz "Vetores Iguais!\n\n"
	msgDifers: 	.asciz "Vetores Diferentes!\n\n"

	pulaLinha: 	.asciz "\n\n"
	pedeReexec: 	.asciz "\nDeseja Reexecucao, <1>Sim ou <2>Nao? => "

	tam: 		.int 	0
	tam2:		.int	0
	num: 		.int 	0
	resp: 		.int 	0
	vetor1: 	.space	4 	# 4 bytes para conter o endereço do vetor 1
	vetor2: 	.space 	4 	# 4 bytes para conter o endereço do vetor 1



.section .text

.globl _start
_start:

	call	_abertura
	call	_leTam
	call	_alocaVetores
	call	_leVetores
	call	_mostraVetores
	call	_comparaVet
	call	_desalocaVetores

	pushl	$pedeReexec
	call	printf
	pushl	$resp
	pushl	$tipoIn
	call	scanf

	addl	$12, %esp

	movl	resp, %eax
	cmpl	$1, %eax
	je	_start

_fim:
	
	pushl 	$0
	call 	exit

_abertura:

	pushl	$msgAbert
	call	printf
	addl	$4, %esp

	ret

_leTam:
	pushl	$1
	pushl	$pedeTam
	call	printf
	pushl	$tam
	pushl	$tipoIn
	call	scanf
	addl	$12, %esp

	pushl	$2
	pushl	$pedeTam
	call	printf
	pushl	$tam2
	pushl	$tipoIn
	call	scanf
	addl	$12, %esp

	ret

_alocaVetores:

	movl	tam, %eax
	movl	$4, %ebx
	mull	%ebx
	pushl	%eax
	call	malloc
	movl	%eax, vetor1
	
	movl	tam2, %eax
	movl	$4, %ebx
	mull	%ebx
	pushl	%eax
	call	malloc
	movl	%eax, vetor2
	addl	$4, %esp

	ret

_leVetores:

	pushl	$1
	pushl	$msgLeit
	call	printf
	addl	$8, %esp

	movl	vetor1, %edi
	movl	tam, %ecx
	movl	$1, %ebx
	call	_leVet

	pushl	$2
	pushl	$msgLeit
	call	printf
	addl	$8, %esp

	movl	vetor2, %edi
	movl	tam, %ecx
	movl	$1, %ebx
	call	_leVet

	ret


	
_leVet:

	pushl	%ecx
	pushl	%edi
	pushl	%ebx
	pushl	$pedeNum
	call	printf
	addl	$4, %esp

	pushl	$num
	pushl	$tipoIn
	call	scanf
	addl	$8, %esp

	popl	%ebx
	popl	%edi
	popl	%ecx

	movl	num, %edx
	movl	%edx, (%edi)
	addl	$4, %edi
	incl	%ebx

	loop	_leVet

	
	ret

_mostraVetores:

	pushl	$1
	pushl	$mostraVet
	call	printf
	movl	vetor1, %edi
	movl	tam, %ecx
	addl	$8, %esp
	call	_mostraVet

	pushl	$2
	pushl	$mostraVet
	call	printf
	movl	vetor2, %edi
	movl	tam, %ecx
	addl	$8, %esp
	call	_mostraVet

	pushl	$pulaLinha
	call	printf
	addl	$4, %esp

	ret


_mostraVet:

	pushl	%edi
	pushl	%ecx

	movl	(%edi), %eax
	pushl	%eax
	pushl	$tipoOut
	call	printf

	addl	$8, %esp

	popl	%ecx
	popl	%edi

	addl	$4, %edi

	loop	_mostraVet

	ret

_comparaVet:

	movl	tam, %ecx
	movl	vetor1, %edi
	movl	vetor2, %esi

_voltaComparaVet:

	movl	(%edi), %eax
	movl	(%esi), %ebx
	cmpl	%ebx, %eax
	jne	_saoDiferentes

	addl	$4, %edi
	addl	$4, %esi
	
	loop	_voltaComparaVet

_saoIguais:

	pushl	$msgIguais
	call	printf
	addl	$4, %esp

	ret

_saoDiferentes:	

	pushl	$msgDifers
	call	printf
	addl	$4, %esp

	ret

_desalocaVetores:

	pushl	vetor1
	call	free

	pushl	vetor2
	call	free

	addl	$8, %esp

	ret



	 

	


