; Hello World Program (Passing arguments from the command line)
; Compile with: nasm -f elf helloworld-args.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-args.o -o helloworld-args
; Run with: ./helloworld-args
 
%include        'utils.asm'
 
SECTION .text
global  _start
 
_start:
 
    pop     rcx             ; first value on the stack is the number of arguments
 
nextArg:
    cmp     rcx, 0h         ; check to see if we have any arguments left
    jz      noMoreArgs      ; if zero flag is set jump to noMoreArgs label (jumping over the end of the loop)
    pop     rax             ; pop the next argument off the stack
    call    sprintLF        ; call our print with linefeed function
    dec     rcx             ; decrease ecx (number of arguments left) by 1
    jmp     nextArg         ; jump to nextArg label
 
noMoreArgs:
    call    quit
