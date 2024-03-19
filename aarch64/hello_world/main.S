.text

.global _start

_start:
    mov x0, #1
    ldr x1, =hello
    mov x2, #hello_len
    mov x8, #64
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0

.section .rodata

hello:
    .string "Hello World\n"
hello_end:
    hello_len = (hello_end - hello)
