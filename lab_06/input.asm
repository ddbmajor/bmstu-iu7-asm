PUBLIC INPUT

EXTRN ENT : BYTE
EXTRN NLINE : BYTE

Code SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:Code
INPUT PROC NEAR
    mov  AH, 9h
	mov  DX, OFFSET ENT
	int  21h
	
	xor  BX, BX
	xor  CX, CX

    INPUT_LOOP:
        mov AH, 8h
        int 21h

        cmp AL, 13
        je INPUT_END

        cmp AL, '0'
        jb INPUT_LOOP
        cmp AL, '1'
        ja INPUT_LOOP

        mov AH, 2h
        mov DL, AL
        int 21h

        mov CL, AL
        mov AX, BX

        shl AX, 1
        mov BL, CL
        sub BL, '0'
        xor BH, BH
        add BX, AX

        jmp INPUT_LOOP

    INPUT_END:
        mov AH, 9h
        mov DX, OFFSET NLINE
        int 21h

        xor DH, DH
        mov AX, BX

        ret
        
INPUT ENDP
    
Code ENDS
    END
