SECTION .text

;--------------------------------------------------------------------------------------------------------------------
; int strLen(%rax string)
; returns %rax - length of string
strLen:
    push rdi
    mov rdi, rax
strLen_nextChar:
    cmp byte[rax],0
    jz strLen_nullByteFound
    inc rax
    jmp strLen_nextChar
    
strLen_nullByteFound:
    sub     rax,rdi
    pop     rdi
    ret
;--------------------------------------------------------------------------------------------------------------------
; void print_noLinefeed(%rax string)
print_linefeed:
    call print_noLinefeed   ; print current string
    push rax                ; store rax on stack
    mov rax, 0Ah            ; store linefeed in rax
    push rax                ; push linefeed to stack
    mov rax, rsp            ; move stack pointer to rax
    call print_noLinefeed   ; print linefeed
    pop rax                 ; pop linefeed
    pop rax                 ; pop init rax
    ret
;--------------------------------------------------------------------------------------------------------------------
; void print_linefeed(%rax string)
print_noLinefeed:
    push rdi
    push rsi
    push rdx
    push rax
    call strLen    
    mov     rdx, rax        ; strlen subroutine stores string length in rax
    pop     rax
    push    rax
    mov     rsi, rax
    mov     rax, 1          ; opcode for sys_write
    mov     rdi, 1          ; file descriptor
    syscall
    pop rax
    pop rdx
    pop rsi
    pop rdi
    ret
;--------------------------------------------------------------------------------------------------------------------
print_raxChar:
    call print_linefeed
    ret
;--------------------------------------------------------------------------------------------------------------------
print_rdiChar:
    push rax
    mov rax,rdi
    call print_linefeed
    pop rax
    ret
;--------------------------------------------------------------------------------------------------------------------
print_rdxChar:
    push rax
    mov rax,rdx
    call print_linefeed
    pop rax
    ret
;--------------------------------------------------------------------------------------------------------------------
print_rsiChar:
    push rax
    mov rax,rsi
    call print_linefeed
    pop rax
    ret

