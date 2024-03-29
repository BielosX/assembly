stdout equ 1
write equ 1
exit equ 60


section .text
global _start

_start:
    mov rax, write
    mov rdi, stdout
    mov rsi, hello
    mov rdx, helloLen
    syscall

    mov rax, exit
    mov rdi, 0x0
    syscall

section .rodata

hello: db "Hello World!", 10
helloLen: equ $ - hello
