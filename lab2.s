.section .data
 
string1: .ascii "foo"
string2: .ascii "bar"
diff_count: .byte 0b0000
count: .byte 0b0000
len = . - string1
msg1: .ascii "the bit difference is "
len1 = . - msg1
len3 = . - diff_count


.section .text
.globl _start
_start:
    movl $string1, %esi 
    movl $string2, %edi
    movl count, %edx
    movl $len, %ecx

repeat:
    test %edx, %esi 
    jz is_zero
    jmp is_one
    cmpl %edx, %ecx
    jne repeat


is_zero:
    test %edx, %edi
    jz is_same
    jmp is_diff

is_one:
    test %edx, %edi
    jz is_diff
    jmp is_same

is_same:
    incb diff_count
    incl %edx
    incl %edi
    incl %esi

is_diff:
    incl %edx
    incl %esi
    incl %edi

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

