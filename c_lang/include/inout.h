#ifndef __INOUT_H__
#define __INOUT_H__

#include <unistd.h>
#include <stdint.h>

int64_t flush();
int64_t buf_write(uint8_t* buffer, uint64_t len);
int64_t print(char* buffer);

#endif