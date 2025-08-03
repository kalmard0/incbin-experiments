#include <stdio.h>
#include <stdint.h>

extern char blob_data[];
const unsigned long blob_size = 1024 * 1024 * 512;

int main (int argc, char *argv[]) {
    uint64_t blob_sum = 0;
    for (unsigned long i = 0; i < blob_size; i++) {
        blob_sum += (unsigned char)blob_data[i];
    }
    printf("Sum: %lu\n", blob_sum);
    return 0;
}