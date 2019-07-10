

SECTION .data
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

call exit



doubleMultiply:
;
;
;

doubleAdd:
;
;
;

doubleSubtract:
;
;
;

doubleDivide:
;
;
;

;--------------------------------------------------------------------------------------------------------------------
; int doubleGetMantissa(%rax double)
; returns the mantissa of a 64 bit floating point (first 52 bits of a double are the mantissa)
;---------------------------------
doubleGetMantissa:
    AND rax, 0xFFFFFFFFFFFFF  ;mantissa is last 52 bits of float; do 'and' operation on rax and 0xFFFFFFFFFFFFF
                              ;(0xFFFFFFFFFFFFF is is 2^52 - 1) 
    add rax, 0x10000000000000 ;add hidden bit
    ret
;--------------------------------------------------------------------------------------------------------------------
; int doubleGetExponent(%rax double)
; returns the exponent of a 64 bit floating point (11 bits starting at bit 52)
;---------------------------------
doubleGetExponent:
    shr rax, 52
    AND rax, 0x7FF          ; (0x7FF is 2^11 - 1)
    ret

;--------------------------------------------------------------------------------------------------------------------
; int doubleGetSign(%rax double)
; returns the sign of a 64 bit floating point
;---------------------------------
doubleGetSign:
    shr rax, 63
    ret


;--------------------------------------------------------------------------------------------------------------------
; int getPositionOfLeading1(%rax input)
; returns the position of the first nonzero bit
;---------------------------------
getPositionOfLeading1:
    push rdx                    ; store rdx
    push rdi                    ; store rdi
    mov rdi,8000000000000000    ; bit 63 is 1- all others zero
        
.checkNextBit
