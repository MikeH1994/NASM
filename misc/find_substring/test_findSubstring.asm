%include        'stringUtils.asm'                             ; include our external file

SECTION .data
msg_found       db      "Found",0h
msg_notFound    db      "Not Found",0h      
msg_str         db      "Test string: ",0h
msg_substr      db      "Test substring: ",0h  
msg_location    db      "Location: ",0h
testString1     db      "ferret",0h
testString2     db      "dogwhistle",0h
testSubstring1  db      "f",0h
testSubstring2  db      "tle",0h




SECTION .text           ; code goes here   
global  _start          ; defining default entry point for program

_start:
   

    mov rax, testString1
    mov rdi, testSubstring1
    call run

    mov rax, testString2
    mov rdi, testSubstring2
    call run

    mov rax, testString1
    mov rdi, testSubstring2
    call run
    
    mov rax, 60
    mov rdi, 0
    syscall
printHeader:
    push rax
    mov rax, msg_str
    call printChar
    pop rax
    call printChar_LF
    push rax
    mov rax, msg_substr
    call printChar
    mov rax, rdi
    call printChar_LF
    pop rax
    ret
run:
    call printHeader
    call findSubstring
    cmp rax,-1
    jz .notFound
    jmp .found
.found:
    push rax
    mov rax,msg_found
    call printChar_LF
    mov rax, msg_location
    call printChar
    pop rax
    call printInt_LF
    ret
.notFound:
    push rax
    mov rax,msg_notFound
    call printChar_LF
    mov rax, msg_location
    call printChar
    pop rax
    call printInt_LF
    ret
