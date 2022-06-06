.MODEL TINY

CODESEG SEGMENT
    assume  CS:CODESEG, DS:CODESEG
    org     100h
main:
    jmp         init
    is_init     DW  1
    handler     DD  0
    speed       DB  0
    cur_sec     DB  0

cyc09 proc

    push AX
    push CX
    push DX

    mov AH, 02h
    int 1Ah

    cmp DH, cur_sec
    je to_pop

    mov cur_sec, DH
    dec speed

    cmp speed, 01Fh
    jbe set

    mov speed, 01Fh
    
set:
    mov AL, 0F3h
    out 60h, AL
    mov AL, speed
    out 60h, AL

to_pop:
    pop DX
    pop CX
    pop AX
    jmp CS:handler

cyc09 endp

init:
    mov AX, 3509h
    int 21h

    cmp ES:is_init, 1
    je exit

    mov word ptr handler, BX
    mov word ptr handler + 2, ES 

    mov AX, 2509h
    mov DX, offset cyc09
    int 21h

    mov DX, offset init_msg
    mov AH, 09h
    int 21h

    mov DX, offset init
    int 27h

exit:
    push AX
    push DX
    push DS

    mov DX, word ptr ES:handler
    mov DS, word ptr ES:handler + 2

    mov AL, 0F3h
    out 60h, AL
    mov AL, 0
    out 60h, AL

    mov AX, 2509h
    int 21h

    pop DS
    pop DX
    pop AX

    mov DX, offset exit_msg
    mov AH, 09h
    int 21h

    mov AH, 4Ch
    int 21h

    init_msg    DB  "Install$", 13, 10
    exit_msg    DB  "Uninstall$", 13, 10

CODESEG ENDS
END main
