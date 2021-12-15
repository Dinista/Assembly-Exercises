.section .data

	abertura:	.asciz	"\nPrograma para Calcular a Media de uma Turma\n\n"

	pedeNAlunos:	.asciz	"\nDigite o numero de alunos da turma => "

	pedeNotaF:	.asciz	"\nDigite a nota final do aluno %d => "

	mostraMediaT:	.asciz	"\nMedia da Turma = %d"

	mostraMaior:	.asciz	"\nMaior Nota Final = %d"

	mostraMenor:	.asciz	"\nMenor Nota Final = %d"

	mostraNAprov:	.asciz	"\nNumero de Aprovados = %d"

	mostraNReprov:	.asciz	"\nNumero de Reprovados = %d\n\n"

	NAlunos:	.int	0

	notaF:		.int	0

	mediaT:		.int	0

	maiorNF:	.int	0

	menorNF:	.int	0

	nAprov:		.int	0

	nReprov:	.int	0

	tipoDado:	.asciz	"%d"

	
.section .text


.globl	_start

_start:

	pushl	$abertura
	call	printf

	pushl	$pedeNAlunos
	call	printf

	pushl	$NAlunos
	pushl	$tipoDado
	call	scanf

	movl	NAlunos, %eax
	cmpl	$0, %eax
	jle	_fim


	movl	NAlunos, %ecx
	movl	$1,  %ebx
	movl	$0,  nAprov
	movl	$0,  nReprov
	movl	$-1, maiorNF
	movl	$11, menorNF

_leNotas:

	pushl	%ecx		# para backupear/proteger contra alteracoes que
                                # podem ser causadas pelas chamadas de biblioteca  

	pushl	%ebx		# contador do numero do aluno
	pushl	$pedeNotaF
	call	printf

	pushl	$notaF
	pushl	$tipoDado
	call	scanf

	addl	$12, %esp

	popl	%ebx
	incl	%ebx

	popl	%ecx		# para restaurar o %ecx

	movl	mediaT, %eax
	addl	notaF, %eax
	movl	%eax, mediaT

	movl	notaF, %eax
	cmpl	$6, %eax
	jl	_cont1
	
	# incrementa o numero de aprovados em 1
	movl	nAprov, %eax
	incl	%eax
	movl	%eax, nAprov

_cont1:

	movl	notaF, %eax
	cmpl	maiorNF, %eax
	jle	_cont2

	# substitui a maior nota guardada
	movl	%eax, maiorNF

_cont2:

	cmpl	menorNF, %eax
	jge	_cont3

	# substitui a menor nota guardada
	movl	%eax, menorNF	

_cont3:

	loop 	_leNotas	# decrementa %ecx em 1 e salta se ainda nao for zero

	movl	NAlunos, %eax
	subl	nAprov, %eax
	movl	%eax, nReprov

	movl	$0, %edx
	movl	mediaT, %eax
	divl	NAlunos
	movl	%eax, mediaT

	pushl	mediaT
	pushl	$mostraMediaT
	call	printf

	pushl	maiorNF
	pushl	$mostraMaior
	call	printf

	pushl	menorNF
	pushl	$mostraMenor
	call	printf

	pushl	nAprov
	pushl	$mostraNAprov
	call	printf

	pushl	nReprov
	pushl	$mostraNReprov
	call	printf

	addl	$40, %esp



_fim:

	addl	$16, %esp
	pushl	$0
	call	exit

    