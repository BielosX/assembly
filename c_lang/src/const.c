#include <unistd.h>
#include <stdlib.h>
#include "const.h"

static uint64_t page_size;

__attribute__((constructor))
static void init(void) {
    long r;
    r = sysconf(_SC_PAGESIZE);    
    if (r < 0) {
        exit(r);
    }
    page_size = (uint64_t)r;
}

uint64_t get_page_size() {
    return page_size;
}