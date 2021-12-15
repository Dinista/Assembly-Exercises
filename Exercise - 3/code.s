.section .data
    base:   .int    0
    altura: .int    0
    area:   .int    0
    opcao:  .int    0
    raio:   .int    0

    abertura:   .asciz "\n=========== Programa para calculo de area de figuras geometricas ============\n"
    menuOpcao:	.asciz	"\nMenu de Opcao:\n<1> Area do Retangulo\n<2> Area do Triangulo\n<3> Area da circunferencia\n<4> Sair\n"
    invalido:   .asciz  "\nValor invalido\n"    
    pedeBase:   .asciz "\nDigite o valor da base =>"
    pedeAlt:    .asciz "\nDigite o valor da autura =>"
    pedeRaio:    .asciz "\nDigite o valor do raio =>"
    pedeOpcao:	.asciz	"\nDigite a opcao => "


    pi:     .int    3
    
    result:     .asciz "\nA area é de %d\n\n"
    
    tipo:       .asciz "%d"

.section .text
.globl _start

_start:
    pushl   $abertura
    call    printf
    call _menu

    # lê menu
_menu:
    
    pushl   $menuOpcao
    call    printf

    pushl   $pedeOpcao
    call    printf

    pushl   $opcao
    pushl   $tipo
    call    scanf
    
    movl    opcao, %eax
    cmpl    $1, %eax
    je      _calRet
    
    cmpl    $2, %eax
    je      _calTri

    cmpl    $3, %eax
    je      _calCir

    cmpl    $4, %eax
    je      _fim

    pushl   $invalido
    call    printf

    addl    $24, %esp

    jmp     _menu

    ret

_calCir:
    
    # lê raio
    
    pushl $pedeRaio
    call printf

    pushl $raio
    pushl $tipo
    call  scanf

    movl   $0, %edx
    movl raio, %eax
    
    mull pi

    mull raio

    movl %eax, area

    pushl area
    pushl $result
    call printf

    addl $16, %esp

    call _menu


_calRet:

    # lê base
    
    pushl $pedeBase
    call printf

    pushl $base
    pushl $tipo
    call  scanf
    
    # lê altura
    
    pushl $pedeAlt
    call printf

    pushl $altura
    pushl $tipo
    call  scanf

    # limpa pilha

    addl $24, %esp

    # multiplica

    movl base, %eax
    mull altura
    movl %eax, area

    # mostra resultado

    pushl area
    pushl $result
    call printf

    addl $8, %esp

    call _menu

_calTri:

    # lê base
    
    pushl $pedeBase
    call printf

    pushl $base
    pushl $tipo
    call  scanf
    
    # lê altura
    
    pushl $pedeAlt
    call printf

    pushl $altura
    pushl $tipo
    call  scanf

    # limpa pilha

    addl $24, %esp

    # multiplica

    movl base, %eax
    mull altura

    # divide por 2
    movl $0, %edx
    movl $2, %ebx
    divl %ebx

    # mostra resultado
    movl %eax, area
    pushl area
    pushl $result
    call printf

    addl $8, %esp

    call _menu

_fim:
    pushl $0
    call exit
