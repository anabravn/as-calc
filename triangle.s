.section .data
    two: .int 2

.section .text
area_triangle:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %edi # Endereço do resultado
    movl 12(%ebp), %esi # Endereço dos valores base e altura

    finit # Reinicia FPU

    flds (%esi)
    flds 4(%esi)
    fmul %st(1), %st(0)

    movl $two, %eax
    filds (%eax) 
    fdivr %st(1), %st(0)

    fstps (%edi)

    popl %ebp
    ret




