; Hello World Program (Subroutines)
; Compile with: nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len
 
SECTION .data
msg     db      'Waddup', 0Ah
 
SECTION .text
global  _start
 
_start:
 
    mov     rax, msg        ; move the address of msg in to rax
    call    strlen          ; call calculate length of msg by calling subroutine strlen

    mov     rdx, rax        ; strlen subroutine stores string length in rax
    mov     rax, 1          ; opcode for sys_write
    mov     rdi, 1          ; file descriptor
    mov     rsi, msg        ; char* buffer

    syscall
 
    mov     rax, 60         ; opcode for sys_exit
    mov     rdi, 0          ; error code on sys_exit
    syscall

strlen:                     
    push    rdi             ; push the value in rdi onto the stack to preserve it while we use rdi in this function
    mov     rdi, rax        ; move the address in rax into rdi (Both point to the same segment in memory)
 
nextchar:                   
    cmp     byte [rax], 0   ;if the byte at address held in rax is zero, set zero flag to 1
    jz      finished        ;if zero flag is 1, jump to finished
    inc     rax             ;else, increment rax
    jmp     nextchar        ;
 
finished:
    sub     rax, rdi        ; rdi = start of buffer, rax = end of buffer; rax-rdi=length of string
    pop     rdi             ; pop the value on the stack back into rdi
    ret                     ; return to where the function was called
