.text

.global _start

.set stdout, 1

.macro exit code
    mov x0, #(\code)
    mov x8, #93
    svc #0
.endm

.macro write file_desc buffer len
    mov x0, #(\file_desc)
    ldr x1, =(\buffer)
    mov x2, #(\len)
    mov x8, #64
    svc #0
.endm

_start:
    write stdout hello hello_len
    exit 0


.section .rodata

hello:
    .string "Hello World\n"
hello_end:
    hello_len = (hello_end - hello)
