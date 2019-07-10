%include 'printUtils.asm'

SECTION .data

msg_fizz db 'fizz',0
msg_buzz db 'buzz',0
msg_next db 'next',0
msg_LF   db 0Ah,0

SECTION .text
global _start

;---------------------
; rax - 
; rsi - current integer
; rdi - divisor
; rdx - quotient
; r8  - max number of iterations
; r9  - 2 if fizz and buzz both true

_start:
mov rax, 0
mov rsi, 0
mov rdi, 0
mov rdx, 0
mov r8,  50
jmp .mainLoop
   
.mainLoop:
inc rsi
mov r9,0
cmp rsi, r8
jz  .exit

.checkFizz:
mov rdi, 3
mov rax, rsi
mov rdx, 0
idiv rdi
cmp rdx,0       ;if rsi is not divisible by 3, skip
jne .checkBuzz  ;
inc r9          ;indicate that fizz or buzz has occurred for this number
mov rax, msg_fizz
call printChar  ;if rsi is divisble by 3, print 'fizz'

.checkBuzz:
mov rdi, 5
mov rax, rsi
mov rdx, 0
idiv rdi
cmp rdx,0       ;if rsi is not divisible by 5, skip
jne .checkInt   ;
inc r9          ;indicate that fizz or buzz has occurred for this number
mov rax, msg_buzz
call printChar  ;if rsi is divisble by 5, print 'buzz'


.checkInt:
cmp r9,0
jg .lineFeed   ;if r9>0, fizz or buzz, therefore we don't need to print number
mov rax, rsi
call printInt   ;print current number
jmp .lineFeed

.lineFeed:
mov rax,msg_LF
call printChar
jmp .mainLoop

.exit:
mov rax, 60
mov rsi, 0
syscall
