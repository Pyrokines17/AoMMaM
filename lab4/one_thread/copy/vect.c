#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h>

#define HALF_GB 512*1024*1024ULL
#define GB 1024*1024*1024ULL

enum data_type {
    INT = 0,
    FLOAT = 1,
    DOUBLE = 2
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

    void* buf2 = malloc(size_in_bytes);

    if (buf2 == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        free(buf);
        return EXIT_FAILURE;
    }

    int in_data_type = atoi(argv[2]);
    struct timespec start, end;

    switch (in_data_type) { 
        case INT: {
            int* int_buf = (int*)buf;
            int* int_buf2 = (int*)buf2;

            size_t int_el_count = size_in_bytes / sizeof(int);
            
            buf_init_int(int_buf, int_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            for (size_t i = 0; i < int_el_count; i += 16) {
                __m512i v = _mm512_loadu_si512(&int_buf[i]);
                _mm512_storeu_si512(&int_buf2[i], v);
            }
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            fprintf(stdout, "Buffer have values in index 0, 10, 20: %d, %d, %d\n", int_buf2[0], int_buf2[10], int_buf2[20]);
            fprintf(stdout, "Buffer initialized with %zu elements\n", int_el_count);
            
            break;
        }
        case FLOAT: {
            float* float_buf = (float*)buf;
            float* float_buf2 = (float*)buf2;

            size_t float_el_count = size_in_bytes / sizeof(float);
            
            buf_init_float(float_buf, float_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            for (size_t i = 0; i < float_el_count; i += 16) {
                __m512 v = _mm512_loadu_ps(&float_buf[i]);
                _mm512_storeu_ps(&float_buf2[i], v);
            }
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            fprintf(stdout, "Buffer have values in index 0, 10, 20: %f, %f, %f\n", float_buf2[0], float_buf2[10], float_buf2[20]);
            fprintf(stdout, "Buffer initialized with %zu elements\n", float_el_count);

            break;
        }
        case DOUBLE: {
            double* double_buf = (double*)buf;
            double* double_buf2 = (double*)buf2;

            size_t double_el_count = size_in_bytes / sizeof(double);
            
            buf_init_double(double_buf, double_el_count);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            for (size_t i = 0; i < double_el_count; i += 8) {
                __m512d v = _mm512_loadu_pd(&double_buf[i]);
                _mm512_storeu_pd(&double_buf2[i], v);
            }
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            fprintf(stdout, "Buffer have values in index 0, 10, 20: %f, %f, %f\n", double_buf2[0], double_buf2[10], double_buf2[20]);
            fprintf(stdout, "Buffer initialized with %zu elements\n", double_el_count);
            
            break;
        }
    }

    double elapsed_time = (end.tv_sec - start.tv_sec) + 
                          (end.tv_nsec - start.tv_nsec) / 1e9;
    double bps = (double)size_in_bytes / elapsed_time;
    double gbps = bps / (GB);
    
    fprintf(stdout, "Time taken for summation: %.6f seconds\n", elapsed_time);
    fprintf(stdout, "Bandwidth: %.2f GB/s\n", gbps);
    
    free(buf);
    free(buf2);

    FILE* file = fopen("bandwidth.csv", "a");

    if (file == NULL) {
        fprintf(stderr, "Failed to open file for writing\n");
        return EXIT_FAILURE;
    }

    fprintf(file, "copy;vect;%d;%d;1;1;%.2f;\n", in_data_type, arg_count/2, gbps);
    fclose(file);

    fprintf(stdout, "Data written to file\n");

    return EXIT_SUCCESS;
}
