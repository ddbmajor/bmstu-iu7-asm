StkSeg SEGMENT PARA STACK 'STACK'
    DB 200h DUP (?)
StkSeg ENDS

DataS SEGMENT WORD 'DATA'
    MatrixSize DB ?
    Matrix DB 100 DUP ('$')
DataS ENDS
;
Code SEGMENT WORD 'CODE'
    ASSUME CS:Code, DS:DataS
Prog:
	mov AX, DataS
	mov DS, AX
    ; ввод размера матрицы
    mov AH, 01h
    int 21h
	sub AL,30h
    mov MatrixSize, AL
	
	; ввод разделяющего символа
	mov AH, 01h
    int 21h
	
	; количество вводимых чисел
	mov AL, MatrixSize
    mul AL
    mov CX, AX
    mov BX, 0	; счетчик
	; цикл ввода
    inputloop:
	    mov AH, 01h
        int 21h
		sub AL, 30h
        mov [Matrix + BX], AL
        inc BX
		; ввод разделяющего символа
		mov AH, 01h
		int 21h
        loop inputloop
		
	; поменять местами элементы на главной и побочной диагоналях (построчно)
	mov CL, MatrixSize
	mov SI, 0
	taskloop:
		mov AL, MatrixSize
		mul SI
		add AX, SI
		add AX, OFFSET Matrix
		mov BX, AX
		
		mov AL, MatrixSize
		mul SI
		add AL, MatrixSize
		sub AX, SI
		sub AX, 1
		add AX, OFFSET Matrix
		
		mov DI, AX
		mov AL, [DI]
		mov DL, [BX]
		mov [DI], DL
		mov [BX], AL

		
		inc SI
		loop taskloop
		;swap(matrix + size * i + i, matrix + size * i + size - 1 - i)
    
	mov DL, 10 ;код новой строки
	mov AH, 2 ;перевод на новую строку
	int 21h
	
	; количество выводимых чисел
	mov AL, MatrixSize
	mul AL
	mov CX, AX
	mov BX, 0	; счетчик
	; цикл вывода
	outputloop:
		mov DL, [Matrix + BX]
		add DL, 30h
		
		mov AH, 02h
		int 21h
		
		mov AX, BX
		inc AX
		div MatrixSize
		cmp AH, 0
		jnz spacelabel
		
		newlinelabel:
			mov DL, 10 ;код новой строки
			mov AH, 2 ;перевод на новую строку
			int 21h
			jmp outlabel
			
		spacelabel:
			mov DL, 20h ;код пробела
			mov AH, 2h ;перевод на новую строку
			int 21h
		
		outlabel:
		inc BX
		loop outputloop

	mov AL, 0h
    mov AH,4Ch            ;АН=4Ch завершить процесс
    int 21h               ;вызов функции DOS
Code ENDS
    END Prog