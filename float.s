
.section .data
    num1: .float 0.0
    num2: .float 1.5
    fmt_scanf: .asciz " %f"    
    fmt_printf: .asciz "%f\n"

.section .text
    // Carrega num1 na FPU 
    // Não funciona se eu uso double e fldl
    movl $num1, %ebx
    flds (%ebx) 

    // Carrega num2 na FPU
    movl $num2, %ebx
    flds (%ebx)

    fmul %st(1), %st(0)


print_float:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax # Endereço do float

    // Carrega número na FPU
    finit
    flds (%eax)

    // Reserva espaço na pilha
    // Converte pra double
    subl $8, %esp
    fstpl (%esp) 

    // Escreve double
    pushl $fmt_printf
    call printf
    addl $12, %esp

    popl %ebp
    ret

