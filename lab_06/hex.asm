PUBLIC SHex

EXTRN N : WORD

Code SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:Code
		
SHex PROC NEAR
	mov dx, N
    mov di, dx
    mov cl, 4
    mov si, 4
	test dx, dx
	jns skip ; если не отрицательное
	neg di
	mov dl, '-'
	mov ah, 2
	int 21h
	skip:
    output_loop:
        dec si
        mov dx, di
        xor bx, bx
        mov bl, dh
        shl bx, cl
        shl dx, cl
        mov di, dx
        mov dl, bh
        cmp dl, 9
        jbe plus10
        jmp plusA
        outpp:
            mov ah, 2
            int 21h
            cmp si, 0
            jne output_loop
            ret
    plus10:
        add dl, '0'
        jmp outpp
    plusA:
        sub dl, 10
        add dl, 'A'
        jmp outpp
	ret
SHex ENDP
		
Code ENDS
    END