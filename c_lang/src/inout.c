#include "inout.h"
#include "const.h"
#include "macro.h"

#include <unistd.h>

#define OUT_LEN 1024
#define IN_LEN 1024

static uint8_t out_buffer[OUT_LEN];
static uint8_t in_buffer[IN_LEN];
static uint64_t out_offset = 0;
static uint64_t in_offset = 0;

int64_t flush() {
    uint64_t offset = 0;
    ssize_t r;
    while (offset != out_offset) {
        r = write(STDOUT, (void*)(out_buffer + offset), out_offset - offset);
        if (r < 0) {
            return r;
        }
        offset += r;
    }
    out_offset = 0;
    return offset;
}

int64_t buf_write(uint8_t* buffer, uint64_t bytes) {
    uint64_t bytes_to_write;
    uint8_t* byte_ptr;
    uint64_t* quad_ptr;
    int64_t r;
    int64_t written = 0;
    while (bytes > 0) {
        quad_ptr = (uint64_t*)(out_buffer + out_offset);
        bytes_to_write = MIN(bytes, OUT_LEN - out_offset);
        while (bytes_to_write >= 8) {
            *quad_ptr = *((uint64_t*)buffer);
            quad_ptr++;
            buffer += 8;
            out_offset += 8;
            bytes -= 8;
            bytes_to_write -= 8;
            written += 8;
        }
        byte_ptr = (uint8_t*)quad_ptr;
        while (bytes_to_write > 0) {
            *byte_ptr = *buffer;
            byte_ptr++;
            buffer++;
            out_offset++;
            bytes--;
            bytes_to_write--;
            written++;
        }
        if (out_offset == OUT_LEN) {
            r = flush();
            if (r < 0) {
                return r;
            }
        }
    }
    return written;
}

int64_t print(char* buffer) {
    uint8_t* buf_ptr = (uint8_t*)buffer;
    return 0;
}