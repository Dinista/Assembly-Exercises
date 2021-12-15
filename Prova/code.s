.section .data
	titulo: 			.asciz "\n============ Prova PIHS - RA110752 ============\n\n"
	pedeTam: 			.asciz "\nDigite o tamanho do %d vetor \n> "
	pedeNum: 			.asciz "Entre com o elemento %d \n> "
	mostraMedia: 		.asciz "A media dos elementos é de = %d \n\n"

	mostraVetCon: 		.asciz "\n\nVetor concatenado:"

	msgLeit: 			.asciz "\nLEITURA DO VETOR %d:\n\n"
	mostraVet: 			.asciz "\nVetor %d lido : "

	pedeReexec: 		.asciz "\nDeseja Reexecutar: \n<1>Sim\n<2>Nao\n> "
	
	tipoIn: 			.asciz "%d"
	mostraElem: 		.asciz " %d"
	pulaLin: 			.asciz "\n"

	tam: 				.int 	0
	tam2: 				.int 	0
	tam3:				.int 	0
	soma: 				.int 	0
	resp: 				.int 	0
	num:				.int	0
	numAnt:				.int	0

	v1: 				.space 120 # primeiro vetor
	V2: 				.space 120 # segundo  vetor
	V3: 				.space 120 # vetor concatenado

.section .text

.globl _start

_start:

	# Mostra Abertura
	
	pushl	$titulo
	call	printf

	# CALL/RET

	call	_leTam
	call	leiaVetor
	call	mostraVetor
	call	inverteVetor
	call	inverteVetor2
	call	concatenaVetores
	call 	calculaMedia

	# Implementacao da reexecucao

	pushl	$pedeReexec
	call	printf
	pushl	$resp
	pushl	$tipoIn
	call	scanf

	addl	$12, %esp

	movl	resp, %eax
	cmpl	$1, %eax
	je	_start
	

fim:
	pushl 	$0
	call 	exit


# 	Solicita tamanho
# 	O numero correspondente ao vetor é posto na pilha 

_leTam:
	pushl	$1
	pushl	$pedeTam
	call	printf
	pushl	$tam
	pushl	$tipoIn
	call	scanf
	addl	$16, %esp

	pushl	$2
	pushl	$pedeTam
	call	printf
	pushl	$tam2
	pushl	$tipoIn
	call	scanf
	addl	$16, %esp

	ret


# 	Aloca cada vetor, conforme aprendido em sala de aula
#	incluido o vetor 'resultado'

_alocaVetores:

	movl	tam, %eax
	movl	$4, %ebx
	mull	%ebx
	pushl	%eax
	call	malloc
	movl	%eax, v1
	
	movl	tam2, %eax
	movl	$4, %ebx
	mull	%ebx
	pushl	%eax
	call	malloc
	movl	%eax, V2
	addl	$8, %esp

	movl	tam, %eax
	addl	tam2, %eax
	movl	%eax, tam3
	
	movl	tam3, %eax
	movl	$4, %ebx
	mull	%ebx
	pushl	%eax
	call	malloc
	movl	%eax, V3
	addl	$8, %esp

	ret

# 	Fucao leiaVetor
# 	que passa vetor e tamamnho para LeNum que executa o loop

 leiaVetor:
	movl	$0, numAnt
	pushl	$1
	pushl	$msgLeit
	call	printf
	addl	$8, %esp

	movl	tam, %ecx
	movl	$v1, %edi
	movl	$1, %ebx
	call	leNum

	movl	$0, numAnt
	pushl	$2
	pushl	$msgLeit
	call	printf
	addl	$8, %esp

	movl	tam2, %ecx
	movl	$V2, %edi
	movl	$1, %ebx
	call	leNum

	ret

# Executa propriamente a insercao de acordo com os parametros passados ateriormente

leNum:

	pushl	%ebx
	pushl	%ecx
	pushl	%edi

	pushl	%ebx
	pushl	$pedeNum
	call	printf
	pushl	%edi
	pushl	$tipoIn
	call	scanf
	addl	$16, %esp
	
	movl	(%edi), %eax
	movl	numAnt, %edx

	cmpl %eax, %edx
	jg	resolicita

	movl	%eax, numAnt

	popl	%edi
	popl	%ecx
	popl	%ebx

	incl	%ebx
	addl	$4, %edi
	loop	leNum

	ret

resolicita:	
	popl	%edi
	popl	%ecx
	popl	%ebx
	
	jmp leNum

# Funcao que mostra o vetor
# V1 e V2, e futuramente mostrar V3
# Passa parametros para volta que executara para respectivo vetor

mostraVetor:

	pushl	$1
	pushl	$mostraVet
	call	printf

	addl	$8, %esp
	movl	$v1, %edi
	movl	tam, %ecx
	call 	volta

	pushl	$2
	pushl	$mostraVet
	call	printf

	addl	$8, %esp
	movl	$V2, %edi
	movl	tam2, %ecx
	call 	volta

	ret



# Executa propriamente a mostra do vetor de acordo com os parametros passados ateriormente

volta:

	pushl	%ecx
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$mostraElem
	call	printf
	addl	$8, %esp

	popl	%edi
	popl	%ecx

	addl	$4, %edi
	loop	volta

	pushl	$pulaLin
	call	printf
	addl	$4, %esp

	ret

# A ideia aqui eh inverter o V1 e V2 (jah que sao inseridos em ordem crescentes)
# para que ambos fiquem decrescentes, desse modo, torna-se mais simples contatena-los em ordem decrescente
# depois de invertido basta comparar o primeiro elemento deles
# aquele que tem o primeiro elemento maior ficara por primeiro
# EXEMPLO:

# V1 = 1 2 3 4
# V1(invertido) = 4 3 2 1

# V2 = 7 8 9 10
# V2(invertido) = 10 9 8 7

# V2 tem o primeiro elemento maior que V1 (10 > 4), logo V2 na frente seguido de V1:

# V3 = 10 9 8 7 4 3 2 1


# Inverte vetor V1, passando parametros necessarios para funcao volta2

inverteVetor:

	movl	$v1,	%esi
	movl	%esi, %edi

	movl	tam, %eax
	decl	%eax
	movl	$4, %ebx
	mull	%ebx
	addl	%eax, %edi

	movl	$0, %edx
	movl	tam, %eax
	movl	$2, %ebx
	divl	%ebx
	movl	%eax, %ecx
	

# funcao que executa propriamente a inversao de vetor
# de acordo com os parametros passados anterior

volta2:
	movl 	(%esi), %eax
	movl	(%edi), %ebx
	movl	%ebx, (%esi)
	movl	%eax, (%edi)

	addl	$4, %esi
	subl	$4, %edi

	loop	volta2

	ret

# Inverte vetor V2, passando parametros necessarios para funcao volta2

inverteVetor2:

	movl	$V2,	%esi
	movl	%esi, %edi

	movl	tam2, %eax
	decl	%eax
	movl	$4, %ebx
	mull	%ebx
	addl	%eax, %edi

	movl	$0, %edx
	movl	tam2, %eax
	movl	$2, %ebx
	divl	%ebx
	movl	%eax, %ecx

	call volta2

	ret

# Funcao que concatena os vetores,
# de acordo com a ordem explicado anteriormente.
# Caso V1 fique na frente ira pular para funcao _vetor_primeiro
# Caso contrário continua

concatenaVetores:

	movl	tam, %eax
	addl	tam2, %eax
	movl	%eax, tam3
	
	movl	$v1, %edi
	movl	(%edi), %eax
	
	movl	$V2, %edi
	movl	(%edi), %ebx

	cmpl	%eax, %ebx
	jl	_vetor_primeiro

	movl	$V2, %edi
	movl	tam2, %ecx
	movl	$V3, %esi
	call 	volta_conc

	movl	$v1, %edi
	movl	tam,	%ecx
	movl	$V3, %esi
	movl	tam2, %eax
	movl	$4, %ebx
	mull	%ebx
	addl	%eax, %esi
	call	volta_conc

	pushl	$mostraVetCon
	call	printf

	addl	$4, %esp
	movl	$V3, %edi
	movl	tam3, %ecx
	call 	volta

	ret

# Caso V1 fique na frente, como explicado anteriormente

_vetor_primeiro:

	movl	$v1, %edi
	movl	tam, %ecx
	movl	$V3, %esi
	call 	volta_conc

	movl	$V2, %edi
	movl	tam2,	%ecx
	movl	$V3, %esi
	movl	tam, %eax
	movl	$4, %ebx
	mull	%ebx
	addl	%eax, %esi
	call	volta_conc

	pushl	$mostraVetCon
	call	printf

	addl	$4, %esp
	movl	$V3, %edi
	movl	tam3, %ecx
	call 	volta

	jmp	calculaMedia

# volta_conc: Loop responsavel por percorrer e concatenar  os vetores em V3

volta_conc:

	pushl	%ecx
	pushl	%edi

	movl	(%edi), %eax
	movl	%eax, (%esi)
	
	popl	%edi
	popl	%ecx

	addl	$4, %edi
	addl	$4, %esi
	
	loop	volta_conc

	ret


# Funcao para calcular a media do vetor V3 concatenado,
# passa parametros para volta3

calculaMedia:
	movl	$V3, %edi
	movl	tam3, %ecx
	movl	$0, %eax


volta3:

	addl	(%edi), %eax
	addl	$4, %edi
	loop	volta3
	
	movl	tam3, %ebx
	movl 	$0, %edx
	div		%ebx
	
	pushl	%eax
	pushl	$mostraMedia
	call	printf
	addl	$8, %esp

	ret





