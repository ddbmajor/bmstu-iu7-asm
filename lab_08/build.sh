nasm -f elf64 -o strcpy.o strcpy.asm
g++ -c -ggdb -g -masm=intel -o main.o main.cpp
g++ -ggdb -g main.o strcpy.o -o app.exe

