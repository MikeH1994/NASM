%include        'utils.asm'
 
SECTION .text
global  _start
 
_start:
 
    mov     rsi, 0
 
nextNumber:
    inc     rsi
    mov     rax, rsi
    call    iprintLF
    cmp     rsi, 10
    jne     nextNumber
 
    call    quit
