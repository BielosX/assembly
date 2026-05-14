#include "str.h"
#include "const.h"
#include <stdbool.h>

uint64_t string_length(char* str) {
    uint8_t* byte_ptr;
    uint64_t page_offset;
    uint64_t value;
    uint64_t mask;
    bool zero_found = false;
    uint64_t page_size = get_page_size();
    uint64_t result = 0;
    byte_ptr = (uint8_t*)str;
    while(!zero_found) {
        page_offset = (uint64_t)byte_ptr % page_size;
        if (page_size - page_offset >= 8) {
            value = *((uint64_t*)byte_ptr);
            #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
                mask = ((uint64_t)0xFF) << 56;
            #else
                mask = (uint64_t)0xFF;
            #endif
            for (uint8_t i = 0; i < 8; i++) {
                if ((mask & value) == 0) {
                    zero_found = true;
                    break;
                }
                result++;
                #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
                    mask = mask >> 8;
                #else
                    mask = mask << 8;
                #endif
            }
            byte_ptr += 8;
        } else {
            value = (uint64_t)*byte_ptr;
            if (value == 0) {
                zero_found = true;
            }
            result++;
            byte_ptr++;
        }
    }
    return result;
}