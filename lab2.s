.section .data
 
string1: .ascii "foo"
string2: .ascii "bar"
len = . - string1
msg1: .ascii "the bit difference is "
len1 = . - msg1



.section .text
.globl _start
_start:
    movl $string1, %edi 
    movl $string2, %esi
    movl $0, %ebx # holds the hamming distance
    movl $0, %edx # holds the loop amount 
    movl $len, %ecx # holds the max amount of loops

    xor %edi, %edi
    xor %edi, %esi

repeat:
    shr $1, %edi
    incl %edx 
    jc is_diff
    cmpl %edx, %ecx
    jee print


is_diff:
    incl %ebx
    incl %edi
    incl %esi

print:
   
    mov $1, %rax # write
    mov $1, %rdi # stdout
    mov $msg1, %rsi # buf
    mov $len1, %rdx # len
    syscall
    mov $diff_count, %rsi
    mov $len3, %rdx
    syscall
    mov $60, %rax # exit
    mov $0, %rdi # status
    syscall




.section .note.GNU-stack,"",@progbits


# write program that prompts user for inputs strings, compute hamming distance
# hamming distance is the number of bits that dont match in a string

