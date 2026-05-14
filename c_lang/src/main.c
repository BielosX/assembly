#include "inout.h"
#include "str.h"
#include <string.h>
#include <stdio.h>

int main() {
    char* str = "Hello World\n";
    buf_write((uint8_t*)str, string_length(str));
    flush();
    printf("len: %llu\n", string_length(str));
    return 0;
}