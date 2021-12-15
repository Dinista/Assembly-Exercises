.section .data
    x1: .int 0
    x2: .int 0
    x3: .int 0
    x4: .int 0
    x5: .int 0

    soma: .int 0

    pede_x: .asciz "\nDigite o valor %d =>"
    saida: .asciz "\n%d + %d + %d + %d - %d = %d\n\n"

    tipo: .asciz "%d" # usado no scanf

.section .text

.globl _start

_start:
    # imprimindo msg que pede o número
    pushl $1
    pushl $pede_x
    call printf
    
    # Lendo número
    pushl $x1
    pushl $tipo
    call scanf

    # agora basta copiar e colar o código acima para as outras duas váriaveis
    pushl $2
    pushl $pede_x
    call printf

    pushl $x2
    pushl $tipo
    call scanf

    pushl $3
    pushl $pede_x
    call printf

    pushl $x3
    pushl $tipo
    call scanf

    pushl $4
    pushl $pede_x
    call printf

    pushl $x4
    pushl $tipo
    call scanf

    pushl $5
    pushl $pede_x
    call printf

    pushl $x5
    pushl $tipo
    call scanf

    addl $80, %esp

    # Vamos fazer a soma

    movl x1, %eax
    addl x2, %eax
    addl x3, %eax
    addl x4, %eax

    # fazendo a subtração

    subl x5, %eax

    # imprimindo a soma, com msg com variavel
    pushl %eax
    pushl x5
    pushl x4
    pushl x3
    pushl x2
    pushl x1
    pushl $saida
    call printf

    addl $28, %esp

    call _fim

_fim:
    pushl $0
    call exit
