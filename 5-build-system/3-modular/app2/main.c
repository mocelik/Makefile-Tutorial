#include <stdio.h>
#include <stdlib.h>

#include <lib1/mylib_header.h>

int main(int argc, char **argv) {
    printf("%s is running and uses a library. The library says: [%s]\n", argv[0], 
    my_library_string());
    return EXIT_SUCCESS;
}
