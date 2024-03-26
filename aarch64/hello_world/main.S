.include "syscall.S"

.text

.global _start

.set stdout, 1

# https://developer.arm.com/documentation/dui0801/a/Overview-of-the-ARM-Architecture/About-the-ARM-architecture

_start:
    write stdout hello hello_len
    exit 0


.section .rodata

hello:
    .string "Hello World\n"
hello_end:
    hello_len = (hello_end - hello)
