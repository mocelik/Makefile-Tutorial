#include <stdio.h>
#include <time.h>
#include <stdint.h>

#include "common.h"

void print_common() {
    time_t t = time(NULL);
    printf("[%lu] ", t );
}