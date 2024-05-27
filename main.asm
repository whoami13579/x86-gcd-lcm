; Hello World Program (Count to 10 itoa)
; Compile with: nasm -f elf helloworld-itoa.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-itoa.o -o helloworld-itoa
; Run with: ./helloworld-itoa
 
%include        'functions.asm'
 
section .bss
    buffer resb 16

SECTION .text

section .data
    number1 dd 0
    number2 dd 0
    gcd dd 0

global  _start
 
_start:
    mov eax, 3
    mov ebx, 0
    lea ecx, [buffer]
    mov edx, 16
    int 0x80

    ; Convert string to number
    xor eax, eax
    lea esi, [buffer]

convert1:
    movzx edx, byte [esi]
    cmp dl, 0x0A   ; newline character
    je done1
    imul eax, 10
    sub edx, '0'
    add eax, edx
    inc esi
    jmp convert1

done1:
    mov [number1], eax

    mov eax, 3
    mov ebx, 0
    lea ecx, [buffer]
    mov edx, 16
    int 0x80

    ; Convert string to number
    xor eax, eax
    lea esi, [buffer]

convert2:
    movzx edx, byte [esi]
    cmp dl, 0x0A   ; newline character
    je done2
    imul eax, 10
    sub edx, '0'
    add eax, edx
    inc esi
    jmp convert2

done2:
    mov [number2], eax
    mov ebx, [number1]

loop:
    xor edx, edx
    div ebx
    mov eax, ebx
    mov ebx, edx
    cmp ebx, 0
    jnz loop
    mov [gcd], eax
    call    iprintLF        ; NOTE call our new integer printing function (itoa)

    mov eax, [number1]
    mov ebx, [number2]
    mul ebx

    mov ebx, [gcd]
    xor edx, edx
    div ebx
    call    iprintLF        ; NOTE call our new integer printing function (itoa)
 
    call    quit