;%include '../printUtils/printUtils.asm'
%include 'integerMaths.asm'

SECTION .data
msg_sqrt      db      "square root of ",0h
msg_eq        db      " = ",0h

SECTION .text
global _start

_start:
    mov rdi,2
    jmp loop
loop:
    mov rax,rdi
    call run
    inc rdi
    cmp rdi,150
    jge exit
    jmp loop
run:
    push rax
    mov rax,msg_sqrt
    call printChar
    pop rax
    call printInt
    push rax
    mov rax,msg_eq
    call printChar
    pop rax
    call integerSqrt
    call printInt_LF
    ret

exit:
    mov rax, 60
    mov rsi, 0
    syscall
