EXTRN	INPUT : NEAR
EXTRN	UOct : NEAR
EXTRN	SHex : NEAR	

PUBLIC ENT
PUBLIC NLINE
PUBLIC N

StkSeg SEGMENT PARA STACK 'STACK'
    DB 200h DUP (?)
StkSeg ENDS

DataS SEGMENT WORD 'DATA'
    F	DW	UOct, SHex
	N	DW	?
	
	MENU	DB	'MENU:', 10, 13
		DB	'   0. Menu', 10, 13
		DB	'   1. Input number', 10, 13
		DB	'   2. Oct unsigned', 10, 13
		DB	'   3. Hex signed', 10, 13
		DB	'   4. Exit', 10, 13, '$'
		
	ENT	DB	'> $'
	NLINE	DB	10, 13, '$'
DataS ENDS

Code SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:Code, DS:DataS, SS:StkSeg
Main:
    mov AX, DataS
    mov DS, AX

    PRINT_MENU:
	    mov  DX, OFFSET MENU
        mov  AH, 9h
	    int  21h
    DELAY:
        mov  AH, 9h
	    mov  DX, OFFSET ENT
	    int  21h
    SCAN_CHOICE:
        mov  AH, 1h
        int  21h
            
        cmp  AL, '0'
        jb   SCAN_CHOICE
        cmp  AL, '4'
        ja   SCAN_CHOICE
            
        mov  BL, AL
        xor  BH, BH
            
        mov  AH, 9
        mov  DX, OFFSET NLINE
        int  21h
        ;
        sub  BX, '0'
		
        cmp  BX, 4
        jae  EXIT
            
        cmp  BX, 0
        je   PRINT_MENU
            
        cmp  BX, 1
        je   INPUT_NUMBER
        
        ;find index of function
        sub  BX, 2h
        shl  BX, 1h
            
        call F[BX]
            
        jmp DELAY
    INPUT_NUMBER:
        call INPUT
            
        mov  N, AX
            
        jmp  DELAY
            
    EXIT:
        mov  AH, 4Ch
        xor  AL, AL
        int  21h
Code ENDS
    END Main