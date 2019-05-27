%include        'stringUtils.asm'                             ; include our external file

SECTION .data
msg_found       db      "Found",0h
msg_notFound    db      "Not Found",0h      
msg_str         db      "Test string: ",0h
msg_substr      db      "Test substring: ",0h  
testString1     db      "ferret",0h
testString2     db      "dogwhistle",0h
testSubstring1  db      "f",0h
testSubstring2  db      "tle",0h



SECTION .text           ; code goes here   
global  _start          ; defining default entry point for program

_start:
   
    mov rax, testString2
    mov rdi, testSubstring2
    call testFindSubstring
    
    mov rax, 60
    mov rdi, 0
    syscall
printHeader:
    push rax
    mov rax, msg_str
    call print_noLinefeed
    pop rax
    call print_linefeed
    push rax
    mov rax, msg_substr
    call print_noLinefeed
    mov rax, rdi
    call print_linefeed
    pop rax
    ret
testFindSubstring:
    call printHeader
    call findSubstring
    cmp rax,-1
    jz notFound
    jmp found
found:
    mov rax,msg_found
    call print_linefeed
    ret
notFound:
    mov rax,msg_notFound
    call print_linefeed
    ret
