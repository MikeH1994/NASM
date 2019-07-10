%include '../printUtils/printUtils.asm'

SECTION .data
msg_0     db     " iteration: x_{k} = ",0h
msg_1     db     " iteration: x_{k+1} = ",0h
msg_2     db     " convergence failed ",0h
SECTION .text

;--------------------------------------------------------------------------------------------------------------------
; int integerSqrt(%rax n)
; returns %rax - the integer square root of n
; calculates the integer square root of n using Newton's method.
; x_{k+1} = [1/2(x_k + n/x_k)]
; if |x_{k+1}-x_k| <1, [x_{k+1}] = [sqrt(n)]
;
; rax - current x_k
; rdi - prev x_k
; rsi - n
; r10 - comparison / temp
; rbp - 
;---------------------------------
integerSqrt:
    push rbp
    push rdi        ; store rdi
    push rsi        ; store rsi
    push r10        ; store r10
    mov rsi, rax    ; rax = n
    mov rdi, rax    ; rdi = x_0 = n
    mov rbp,0       ; rbp = iteration counter
.iterate:
    mov rax,rdi     ; rax = x_k
    imul rdi        ; rax = x_k^2
    add rax,rsi     ; rax = (n+x_k^2)
    mov rdx,0       ;
    idiv rdi        ; rax = (n+x_k^2)/x_k
    mov r10,2       ;
    mov rdx,0       ;
    idiv r10        ; rax = x_{k+1} = 1/2[x_k + n/x_k]
    mov r10,rax     ; r10 = x_{k+1}
    sub r10,rdi     ; r10 = x_{k+1} - x_k
    cmp r10,0       ; if |x_{k+1}-x_k| == 0, exit
    jz .exit        ; 
    cmp r10,1       ; if x_{k+1} has only increased by 1, disregard new value and exit 
                    ; (for special case in which n = square number - 1)
    jz .nonConvergence
    mov rdi,rax     ; else, move x_{k+1} to old spot and compute next iteration
    jmp .iterate
.nonConvergence:
    mov rax,rdi     ; use old value of x_k
    jmp .exit
.exit:
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

;--------------------------------------------------------------------------------------------------------------------
; int integerPow(%rax x, rdi y)
; returns %rax - length of string
;---------------------------------
; %rax - 
; %rdi - 
;integerPow:
;    push rdi            ; store value of rd
;    
