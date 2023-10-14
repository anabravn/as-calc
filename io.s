.section .data
    fmt_in: .asciz " %f"
    linebreak: .ascii "\n"

.section .text

input:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Endereço do vetor

    input_loop:
        pushl %ecx # Salva ecx

        pushl %esi # Endereço do elemento
        pushl $fmt_in # Formato de entrada
        call scanf
        addl $8, %esp # Alinha a pilha

        // Incrementa esi (próximo elemento)
        addl $4, %esi 

        popl %ecx # Recupera ecx

        loop input_loop

    popl %ebp
    ret

output:
    pushl %ebp
    movl %esp, %ebp

    movl 8(,%ebp,), %ecx # Tamanho do vetor
    movl 12(,%ebp,), %esi # Endereço do vetor

    output_loop:
        pushl %ecx

        // Escreve float
        pushl %esi
        call print_float
        addl $4, %esp

        // Incrementa esi (próximo elemento)
        addl $4, %esi

        popl %ecx

        loop output_loop

    popl %ebp
    ret

