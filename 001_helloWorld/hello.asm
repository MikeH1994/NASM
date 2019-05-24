; Hello World Program 001 from - asmtutor.com
; Compile with: nasm -f elf64 hello.asm
; Link with ld hello.o
; Run with: ./helloworld
 
SECTION .data           ;constant data goes here
msg     db      'Hello World!', 0Ah     ; (0Ah here is line feed character)
 
SECTION .text           ;code goes here   
global  _start          ;defining default entry point for program

_start:
    mov     edx, 13     ; length of string (12 + 1 for line feed character)
    mov     ecx, msg    ; pointer to string
    mov     ebx, 1      ; output file
    mov     eax, 4      ; opcode
    int     80h
 
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;(1) sys_exit;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Kernel opcode 1 in Linux call table
;arguments:
;%eax               opcode (1)
;%ebx               return value on sys_exit (e.g. 0 for no errors, 1 for error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;(4) sys_write;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Kernel opcode 4 in Linux call table
;arguments:
;%eax               opcode (4)
;%ebx uint          what output to use- stdout, stderr etc?
;%ecx const char*   pointer to string
;%edx size_t        length of string
 

