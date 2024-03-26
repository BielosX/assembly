.include "syscall.S"

.text

.global _start
.set stdout, 1

# x0: number of iterations
for_loop_func:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #16

    str x0, [sp]
    write stdout start_text start_text_len
    ldr x0, [sp]

    # let x15 be counter register
    mov x15, #0 
loop_start:
    cmp x15, x0
    # https://developer.arm.com/documentation/dui0801/a/Condition-Codes/Condition-code-suffixes
    beq loop_end
    stp x0, x15, [sp]
    write stdout iteration_text iteration_text_end
    ldp x0, x15, [sp]
    add x15, x15, #1
    b loop_start
loop_end:
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

_start:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x0, #5
    bl for_loop_func

    mov x0, #3
    bl for_loop_func

    mov x0, #4
    bl for_loop_func

    ldp x29, x30, [sp], #16
    exit 0

.section .rodata

start_text:
    .string "Starting for loop\n"
start_text_end:
    start_text_len = (start_text_end - start_text)
iteration_text:
    .string "Iteration\n"
iteration_text_end:
    iteration_text_len = (iteration_text_end - iteration_text)
