
.section .text

sum_float:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edi # Endereço do resultado
    movl 12(%ebp), %ecx # Tamanho do vetor
    movl 16(%ebp), %esi # Endereço do vetor

    finit # Reinicia FPU
    fldz # Carrega 0

    sum_loop:
        // Carrega floats na FPU
        flds (%esi)
        fadd %st(1), %st(0) # Soma

        fsts (%edi) # Armazena resultado

        addl $4, %esi # Próximo elemento

        loop sum_loop

    popl %ebp
    ret

mul_float:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edi # Endereço do resultado
    movl 12(%ebp), %ecx # Tamanho do vetor
    movl 16(%ebp), %esi # Endereço do vetor

    finit # Reinicia FPU
    fld1 # Carrega 1

    mul_loop:
        // Carrega float na FPU
        flds (%esi)

        fmul %st(1), %st(0) # Multiplicação

        fsts (%edi) # Armazena resultado

        addl $4, %esi # Próximo elemento

        loop mul_loop

    popl %ebp
    ret

sub_float:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edi # Endereço do resultado
    movl 12(%ebp), %ecx # Tamanho do vetor
    movl 16(%ebp), %esi # Endereço do vetor

    finit # Reinicia FPU
    flds (%esi) # Valor inicial
    fldz # Carrega 0

    sub_loop:
        fsubr %st(1), %st(0) # Subtração

        fsts (%edi) # Armazena resultado

        addl $4, %esi # Próximo elemento
        flds (%esi) # Carrega número na FPU

        loop sub_loop

    popl %ebp
    ret


sqrt_float:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ecx # Tamanho do vetor
    movl 12(%ebp), %esi # Endereço do vetor

    finit # Reinicia FPU

    sqrt_loop:
        flds (%esi) # Carrega número na FPU
        fsqrt
        fstps (%esi) # Armazena resultado

        addl $4, %esi # Próximo elemento

        loop sqrt_loop

    popl %ebp
    ret

div_float:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edi # Endereço do resultado
    movl 12(%ebp), %ecx # Tamanho do vetor
    movl 16(%ebp), %esi # Endereço do vetor

    finit # Reinicia FPU
    flds (%esi) # Valor inicial
    fld1 # Carrega 1

    div_loop:
        fdivr %st(1), %st(0) # Divisão

        fsts (%edi) # Armazena resultado

        addl $4, %esi # Próximo elemento
        flds (%esi) # Carrega número na FPU

        loop div_loop

    popl %ebp
    ret


