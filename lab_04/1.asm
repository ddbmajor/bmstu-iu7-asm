EXTRN Print: far
StkSeg SEGMENT PARA STACK 'STACK'
    DB 200h DUP (?)
StkSeg ENDS

PUBLIC String
DataS SEGMENT WORD 'DATA'
    MaxLen DB 100
    Len DB ?
    String DB 100 DUP ('$')
DataS ENDS

Code SEGMENT WORD 'CODE'
    ASSUME CS:Code, DS:DataS
ReadStr:
    mov AX,DataS ;загрузка в AX адреса сегмента данных
    mov DS,AX ;установка DS
    mov DX,OFFSET MaxLen ;DS:DX - адрес строки
    mov AH,10 ;АН=0Ah Считать строку с stdin в буфер
    int 21h ;вызов функции DOS

    jmp Print 
    
Code ENDS
    END ReadStr