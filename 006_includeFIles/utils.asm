;------------------------------------------
; int slen(String message)
; calculates length of string
; arguments:    rax - pointer to string buffer
; returns:      rax - string length
slen:
    push    rdi
    mov     rdi, rax
 
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rdi
    pop     rdi
    ret
 
 
;------------------------------------------
; void sprint(String message)
; Prints string pointed to by rax
; arguments:    rax - pointer to string buffer
sprint:
    push    rdx 
    push    rsi 
    push    rdi
    push    rax         ;
    call    slen        ;
    
    mov     rdx, rax    ; length of string is now in rax; move this to rdx
    pop     rax         ; pop the last element of the string (pointer to string)
                        ; back on to rax
 
    mov     rsi, rax    ; move char* to rsi
    mov     rdi, 1      ; set fd to 1
    mov     rax, 4      ; set opcode to 4 (sys_write)
    syscall
                
    pop     rdi         ; pop elements in stack in reverse order
    pop     rsi
    pop     rdx
    ret
 
 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     rdi, 0
    mov     rax, 60
    syscall
    ret

