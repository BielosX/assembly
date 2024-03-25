.include "syscall.S"

.text

.global _start

# https://developer.arm.com/documentation/102374/0101/Loads-and-stores---addressing
# https://learn.arm.com/learning-paths/servers-and-cloud-computing/exploiting-stack-buffer-overflow-aarch64/frame-layout/
# https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst

# x30 -> link register, bl call saves return address there
# x29 -> frame pointer, saved caller stack pointer

# void base_encode(uint8_t* input, uint64_t input_len, uint8_t* output)
# x0: input, x1: input_len, x2: output
base64_encode:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    ldp x29, x30, [sp], #16
    ret


_start:
    # [sp, #-16]! -> Pre-indexed addressing, (sp - 16) is addressed and sp = sp - 16
    # STP -> Store Pair of registers
    # According to ABI the calee is responsible for storing RET address and pointer to previous SP on STACK
    # Comapring to AMD64 https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf
    # (manual page 130) where CALL operation saves next instruction pointer directly on STACK
    stp x29, x30, [sp, #-16]! 
    mov x29, sp

    # https://developer.arm.com/documentation/dui0802/b/A64-Data-Transfer-Instructions/LDR-pseudo-instruction
    ldr x0, =text_to_encode
    mov x1, #text_to_encode_len
    ldr x2, =output
    bl base64_encode

    # Load Pair of registers
    ldp x29, x30, [sp], #16
    exit 0

.section .rodata

text_to_encode:
    .ascii "Text To Encode"
text_to_encode_end:
    text_to_encode_len = (text_to_encode_end - text_to_encode)

.bss
.lcomm output, text_to_encode_len * 2
