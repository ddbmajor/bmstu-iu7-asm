PUBLIC Print
EXTRN String:BYTE
Code SEGMENT WORD 'CODE'
    ASSUME CS:Code
Print:
    mov DL,10 ;код новой строки
    mov AH,2 ;перевод на новую строку
    int 21h


    mov AL,String+4
    mov DL,AL
    mov AH,2 ;АН=02h выдать на дисплей символ
    int 21h ;вызов функции DOS

    mov AH,7 ;АН=07h ввести символ без эха
    INT 21h ;вызов функции DOS
    mov AH,4Ch ;АН=4Ch завершить процесс
    int 21h ;вызов функции DOS
Code ENDS
    END Print