#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h>

#define HALF_GB 512*1024*1024ULL
#define GB 1024*1024*1024ULL

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <count_halfs_of_gb>\n", argv[0]);
        return EXIT_FAILURE;
    }

    int arg_count = atoi(argv[1]);
    size_t size_in_bytes = arg_count * HALF_GB;

    void* buf = _mm_malloc(size_in_bytes, 64);

    if (buf == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    struct timespec start, end;

    int* int_buf = (int*)buf;
    size_t int_el_count = size_in_bytes / sizeof(int);
    
    clock_gettime(CLOCK_MONOTONIC, &start);
    
    for (size_t i = 0; i < int_el_count; i += 32) {
        _mm512_stream_si512(&int_buf[i], _mm512_set1_epi32(1));
        _mm512_stream_si512(&int_buf[i + 16], _mm512_set1_epi32(1));
    }
    
    clock_gettime(CLOCK_MONOTONIC, &end);
    fprintf(stdout, "Buffer have values in idex 0, 10, 20: %d, %d, %d\n", int_buf[0], int_buf[10], int_buf[20]);
    fprintf(stdout, "Buffer initialized with %zu elements\n", int_el_count);
    _mm_sfence();

    double elapsed_time = (end.tv_sec - start.tv_sec) + 
                          (end.tv_nsec - start.tv_nsec) / 1e9;
    double bps = (double)size_in_bytes / elapsed_time;
    double gbps = bps / (GB);
    
    fprintf(stdout, "Time taken for summation: %.6f seconds\n", elapsed_time);
    fprintf(stdout, "Bandwidth: %.2f GB/s\n", gbps);
    _mm_free(buf);

    FILE* file = fopen("bandwidth.csv", "a");

    if (file == NULL) {
        fprintf(stderr, "Failed to open file for writing\n");
        return EXIT_FAILURE;
    }

    fprintf(file, "write;non_temp;1;%d;1;2;%.2f;\n", arg_count/2, gbps);
    fclose(file);

    fprintf(stdout, "Data written to file\n");

    return EXIT_SUCCESS;
}
