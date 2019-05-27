%include        'printUtils.asm'

SECTION .text 

;--------------------------------------------------------------------------------------------------------------------
; int stringFindChar(%rax String tring, %rdi String subtring)
; returns %rax - index of char in string (-1 if not found)
;====================================================================================================================
; %rax - char*  test string
; %rdi - char*  test substring
; %rsi - char*  current position in test string
; %rdx - char*  current position in test substring
; %r8 - char*  current start position of search region
; %r9 - bool   string found

findSubstring:
    push    rsi                 
    push    rdx 
    push    r8       
    push    r9         
    mov     rsi, rax
    mov     rdx, rdi
    mov     r8, rax
    mov     r9, 0

findSubstring_nextChar:
    cmp     byte [rdx], 0                           ; check if we have reached the end of the test substring
    jz      findSubstring_endOfSubstringReached     ; if we have, check to see if we've successfully found it 
    cmp     byte [rsi], 0                           ; check if we have reached the end of the test string
    jz      findSubstring_substringNotFound         ; 
    push    rsi
    push    rdx
    mov     sil, byte[rsi]                          ; deference rsi and rdx to get the character in that memory address.
    mov     dl, byte[rdx]                           ; this byte to sil and dl (lower 8 bits of rsi and rdx registers)
    cmp     sil, dl                                 ; check to see if the two characters are a match
    pop rdx                                         ; replace the characters with the pointer again
    pop rsi
    jz      findSubstring_charMatch                 ; if they match, jump here
    jmp     findSubstring_charNotMatch              ; otherwise, here

findSubstring_charMatch:
    mov     r9, 1                                  ; indicate that substring so far has been matched
    inc     rsi                                     ; move the pointer along for both the string and substring
    inc     rdx
    jmp findSubstring_nextChar

findSubstring_charNotMatch:
    mov     r9, 0                                  ; indicate that the substring so far has not been matched
    inc     r8                                     ; move the start of the search region along 1
    mov     rsi, r8                                ; move string pointer back to new search region
    mov     rdx, rdi                               ; reset substring position back to beginning
    jmp     findSubstring_nextChar

findSubstring_endOfSubstringReached:
    cmp     r9, 1                                  ; if the end of the substring has been reached and r9 is true,
    jz      findSubstring_substringFound            ; the substring has been successfully found
    jmp     findSubstring_substringNotFound         ; 

findSubstring_substringFound:                      ; if substring has been found, get first 
    sub     r8, rax                                ; relative position in string = r8-rax
    mov     rax, r8                                ; mov position to rax
    jmp     findSubstring_finished

findSubstring_substringNotFound:                    ;if substring not found, set rax to -1
    mov     rax, -1
    jmp     findSubstring_finished

findSubstring_finished:
    pop     r9
    pop     r8
    pop     rdx
    pop     rsi
    ret
