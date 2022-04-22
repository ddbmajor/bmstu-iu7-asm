PUBLIC UOct

EXTRN N : WORD

Code SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:Code
		
UOct PROC NEAR
    mov ax, N
    xor cx, cx
    mov bx, 8 
oi2:
    xor dx,dx
    div bx

    push dx
    inc cx

    test ax, ax
    jnz oi2

    mov ah, 02h
oi3:
    pop dx

    add dl, '0'
    int 21h

    loop oi3
    
    ret
UOct ENDP
		
Code ENDS
    END