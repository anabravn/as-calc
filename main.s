.global _start

.section .data
    str_size: .asciz "Quantidade de números: "
    fmt_int: .asciz " %d"
    str_menu: .asciz "Selecione a operação:\n\t[1] Adição\n\t[2] Multiplicação\n\t[3] Subtração\n\t[4] Divisão\n\t[5] Raíz Quadrada\n\t[6] Área do triangulo\n> "
    option: .int 0
    size: .int 0
    result: .float 1

.section .text
    _start:

    // Selecionar operação
    pushl $str_menu
    call printf
    addl $4, %esp

    pushl $option
    pushl $fmt_int
    call scanf
    addl $8, %esp

    // Alocar array de 2 elementos
    // p/ calcular área do triangulo
    movl $2, size

    movl option, %eax
    cmpl $6, %eax
    je read_numbers

    // Ler tamanho
    pushl $str_size
    call printf
    addl $4, %esp

    pushl $size
    pushl $fmt_int
    call scanf
    addl $8, %esp

    read_numbers:

    // Ler números
    pushl size
    call alloc_array
    addl $4, %esp

    pushl %eax
    pushl size
    call input

    // Selecionar operações

    switch_operations:
        movl option, %eax

        cmpl $1, %eax
        je switch_sum

        cmpl $2, %eax
        je switch_mul

        cmpl $3, %eax
        je switch_sub

        cmpl $4, %eax
        je switch_div

        cmpl $5, %eax
        je switch_sqrt

        cmpl $6, %eax
        je switch_triangle

        jmp end

        switch_sum:
            pushl $result
            call sum_float
            addl $8, %esp
            jmp print_result

        switch_mul:
            pushl $result
            call mul_float
            addl $8, %esp
            jmp print_result

        switch_sub:
            pushl $result
            call sub_float
            addl $8, %esp
            jmp print_result

        switch_div:
            pushl $result
            call div_float
            addl $8, %esp
            jmp print_result

        switch_sqrt:
            call sqrt_float
            jmp print_array

        switch_triangle:
            addl $4, %esp

            pushl $result
            call area_triangle
            addl $4, %esp
            jmp print_result

    print_array:
        call output
        addl $4, %esp
        jmp end

    print_result:
        pushl $result
        call print_float
        addl $4, %esp

    end:

    call free

    pushl $0
    call exit
