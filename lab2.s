# write program that prompts user for inputs strings, compute hamming distance
# hamming distance is the number of bits that do not match in a string

.section .data 
string1: .ascii "foo"   # hard coded first string 
len = . - string1       # holds the length of the strings
string2: .ascii "bar"   # hard coded second string
msg1: .ascii "the bit difference is " 
len1 = . - msg1 
msg2: .ascii "\n"       # holds newline character to be printed
counter: .byte 0        # used to count the bit difference
bit_diff: .skip 16      # used to print the bit difference

.section .text
.globl _start
_start:
    mov $string1, %rax 
    mov $string2, %rbx
    mov $0, %rdx    # holds the loop amount 
    mov $len, %rcx  # holds the max amount of loops

hamming_calc:
    cmp %rcx, %rdx  # checks to see if the program has looped completely
    jge print       # if looped enough then it will print the result 

    mov (%rax, %rdx, 1), %dl  # moves bits from string1 into a register
    mov (%rbx, %rdx, 1), %cl  # moves bits from string2 into a register
    xor %dl, %cl              # xors the targeted bits

count_loop:
    test %cl, %cl       # checks the amount of 1's left
    jz is_done          # if no more bits then 
    incb counter(%rip)  # increments the bit counter if jump is passed over
    shr $1, %cl         # shifts the bits to the right
    jmp count_loop      # checks the next bits 


is_done:
    inc %rdx  # increments the amount of loops done
    jmp hamming_calc 

print:

    mov counter(%rip), %al  # store byte value in a register
    add $'0', %al           # makes byte value into integer
    mov %al, bit_diff(%rip) # stores integer value
    
    mov $1, %rax
    mov $1, %rdi
    mov $msg1, %rsi
    mov $len1, %rdx
    syscall
    mov $1, %rax
    mov $1, %rdi
    mov $bit_diff, %rsi # prints the bit difference integer value  
    mov $1, %rdx 
    syscall
    mov $1, %rax
    mov $1, %rdi
    mov $msg2, %rsi # prints a new line character
    mov $1, %rdx
    syscall
    mov $60, %rax 
    mov $0, %rdi 
    syscall


.section .note.GNU-stack,"",@progbits

