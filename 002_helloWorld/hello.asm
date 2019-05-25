; Hello World Program 001 from - asmtutor.com
; Compile with: nasm -f elf64 hello.asm
; Link with ld hello.o
; Run with: ./helloworld
 
SECTION .data           ;constant data goes here
msg     db      'Eyyy World!', 0Ah     ; (0Ah here is line feed character)
 
SECTION .text           ; code goes here   
global  _start          ; defining default entry point for program

_start:
    mov     rax, 1      ; opcode
    mov     rdi, 2      ; output file fd
    mov     rsi, msg    ; char buffer to be written to fd
    mov     rdx, 12     ; length of msg
    syscall
 
    mov     rax, 60     ; invoke SYS_EXIT (kernel opcode 1)
    mov     rdi, 0      ; return 0 status on exit - 'No Errors'
    syscall



