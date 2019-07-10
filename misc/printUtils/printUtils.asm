SECTION .text

;--------------------------------------------------------------------------------------------------------------------
; int strLen(%rax string)
; returns %rax - length of string
;---------------------------------
; %rax - pointer to current position in string
; %rdi - pointer to start of string
strLen:
    push rdi
    mov rdi, rax
.nextChar:
    cmp byte[rax],0
    jz .nullByteFound
    inc rax
    jmp .nextChar
.nullByteFound:
    sub     rax,rdi
    pop     rdi
    ret

;--------------------------------------------------------------------------------------------------------------------
; void printChar_LF(%rax string)
;---------------------------------
printChar_LF:
    call printChar              ; print current string
    push rax                    ; store rax on stack
    mov rax, 0Ah                ; store linefeed in rax
    push rax                    ; push linefeed to stack
    mov rax, rsp                ; move stack pointer to rax
    call printChar              ; print linefeed
    pop rax                     ; pop linefeed
    pop rax                     ; pop init rax
    ret

;--------------------------------------------------------------------------------------------------------------------
; void printChar(%rax string)
;---------------------------------
; %rax opcode
; %rdi file descriptor
; %rsi string
; %rdx string length
printChar:
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

;------------------------------------------
; void printInt(%rax int)
;---------------------------------
; %rax quotient from idiv
; %rdx remainder from idiv
; %rsi number of bytes to print
; %rcx divisor (10)
printInt:
    push    rax             ; preserve rax, rsi, rdx, rcx by pushing to stack
    push    rsi             ; 
    push    rdx             ;
    push    rcx             ; 
    mov     rsi, 0          ; counter of how many bytes needed to print
    cmp     rax, 0          ; compare initial number to 0
    jl      .addNegSign     ; if rax<0, we need to add a negative sign to start of stringo
    jmp     .divideLoop     ;      
.addNegSign:
    push    '-'
    inc     rsi    
.divideLoop:
    inc     rsi             ; 
    mov     rdx, 0          ; empty rdx
    mov     rcx, 10         ; mov 10 into rcx
    idiv    rcx             ; divide rax by rcx
    add     rdx, 48         ; convert rdx to ascii
    push    rdx             ; push rdx on to stack
    cmp     rax, 0          ; if rax is zero, it cannot be devided anymore
    jnz     .divideLoop     ; else divide the current quotient in rax again
.printLoop:
    dec     rsi             ; count down each byte that we put on the stack
    mov     rax, rsp        ; mov the stack pointer into rax for printing
    call    printChar       ; call our string print function
    pop     rax             ; remove last character from the stack to move rsp forward
    cmp     rsi, 0          ; have we printed all bytes we pushed onto the stack?
    jnz     .printLoop      ; jump is not zero to the label printLoop
 
    pop     rcx             ; restore rcs, rdx, rsi, rax
    pop     rdx             ;
    pop     rsi             ;
    pop     rax             ;
    ret

;------------------------------------------
; void printInt_LF(Integer number)
; Integer printing function with linefeed (itoa)
;---------------------------------
printInt_LF:
    call    printInt        ; call our integer printing function
 
    push    rax             ; push rax onto the stack to preserve it while we use the rax register in this function
    mov     rax, 0Ah        ; move 0Ah into rax - 0Ah is the ascii character for a linefeed
    push    rax             ; push the linefeed onto the stack so we can get the address
    mov     rax, rsp        ; move the address of the current stack pointer into rax for sprint
    call    printChar_LF    ; call our sprint function
    pop     rax             ; remove our linefeed character from the stack
    pop     rax             ; restore the original value of rax before our function was called
    ret
;--------------------------------------------------------------------------------------------------------------------
printChar_rax:
    call printChar_LF
    ret
;--------------------------------------------------------------------------------------------------------------------
printChar_rdi:
    push rax
    mov rax,rdi
    call printChar_LF
    pop rax
    ret
;--------------------------------------------------------------------------------------------------------------------
printChar_rdx:
    push rax
    mov rax,rdx
    call printChar_LF
    pop rax
    ret
;--------------------------------------------------------------------------------------------------------------------
printChar_rsi:
    push rax
    mov rax,rsi
    call printChar_LF
    pop rax
    ret

