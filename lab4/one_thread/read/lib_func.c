#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define HALF_GB 512*1024*1024ULL
#define GB 1024*1024*1024ULL

enum data_type {
    INT = 0,
    FLOAT = 1,
    DOUBLE = 2,
    CHAR = 3,
};

void buf_init_int(int* buf, size_t el_count) {
    for (size_t i = 0; i < el_count; ++i) {
        buf[i] = 1;
    }

    fprintf(stdout, "Buffer initialized with %zu elements\n", el_count);
}

void buf_init_float(float* buf, size_t el_count) {
    for (size_t i = 0; i < el_count; ++i) {
        buf[i] = 1.0f;
    }

    fprintf(stdout, "Buffer initialized with %zu elements\n", el_count);
}

void buf_init_double(double* buf, size_t el_count) {
    for (size_t i = 0; i < el_count; ++i) {
        buf[i] = 1.0;
    }

    fprintf(stdout, "Buffer initialized with %zu elements\n", el_count);
}

void buf_init_char(char* buf, size_t el_count) {
    for (size_t i = 0; i < el_count; ++i) {
        buf[i] = 1;
    }

    fprintf(stdout, "Buffer initialized with %zu elements\n", el_count);
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <count_halfs_of_gb> <data_type>\n", argv[0]);
        return EXIT_FAILURE;
    }

    int arg_count = atoi(argv[1]);
    size_t size_in_bytes = arg_count * HALF_GB;

    void* buf = malloc(size_in_bytes);

    if (buf == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    int in_data_type = atoi(argv[2]);
    struct timespec start, end;
    void* ret;

    switch (in_data_type) { 
        case INT: {
            int* int_buf = (int*)buf;
            size_t int_el_count = size_in_bytes / sizeof(int);
            
            buf_init_int(int_buf, int_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            ret = memchr(int_buf, 2, size_in_bytes);
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            
            break;
        }
        case FLOAT: {
            float* float_buf = (float*)buf;
            size_t float_el_count = size_in_bytes / sizeof(float);
            
            buf_init_float(float_buf, float_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            ret = memchr(float_buf, 2, size_in_bytes);
            
            clock_gettime(CLOCK_MONOTONIC, &end);

            break;
        }
        case DOUBLE: {
            double* double_buf = (double*)buf;
            size_t double_el_count = size_in_bytes / sizeof(double);
            
            buf_init_double(double_buf, double_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            ret = memchr(double_buf, 2, size_in_bytes);
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            
            break;
        }
        case CHAR: {
            char* char_buf = (char*)buf;
            size_t char_el_count = size_in_bytes / sizeof(char);

            buf_init_char(char_buf, char_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            ret = memchr(char_buf, 2, size_in_bytes);
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            
            break;
        }
    }

    if (ret != NULL) {
        fprintf(stdout, "Found some value\n");
    } else {
        fprintf(stdout, "All bytes wathed\n");
    }

    double elapsed_time = (end.tv_sec - start.tv_sec) + 
                          (end.tv_nsec - start.tv_nsec) / 1e9;
    double bps = (double)size_in_bytes / elapsed_time;
    double gbps = bps / (GB);
    
    fprintf(stdout, "Time taken for summation: %.6f seconds\n", elapsed_time);
    fprintf(stdout, "Bandwidth: %.2f GB/s\n", gbps);
    free(buf);

    FILE* file = fopen("bandwidth.csv", "a");

    if (file == NULL) {
        fprintf(stderr, "Failed to open file for writing\n");
        return EXIT_FAILURE;
    }

    fprintf(file, "read;lib_func;%d;%d;1;1;%.2f;\n", in_data_type, arg_count/2, gbps);
    fclose(file);

    fprintf(stdout, "Data written to file\n");

    return EXIT_SUCCESS;
}
