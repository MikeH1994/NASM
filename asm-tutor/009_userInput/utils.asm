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
    mov     rax, 1      ; set opcode to 4 (sys_write)
    syscall
                
    pop     rdi         ; pop elements in stack in reverse order
    pop     rsi
    pop     rdx
    ret
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
 
    push    rax         ; push rax onto the stack to preserve it while we use the rax register in this function
    mov     rax, 0Ah    ; move linefeed character to 0Ah
    push    rax         ; push 0Ah on to stack
    mov     rax, rsp    ; move the address of the current stack pointer into rax for sprint
    call    sprint      ; call our sprint function
    pop     rax         ; remove our linefeed character from the stack
    pop     rax         ; restore the original value of eax before our function was called
    ret                 ; return to our program
 
 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     rdi, 0
    mov     rax, 60
    syscall
    ret

