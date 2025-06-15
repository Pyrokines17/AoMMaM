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

    switch (in_data_type) { 
        case INT: {
            int* int_buf = (int*)buf;
            size_t int_el_count = size_in_bytes / sizeof(int);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            for (size_t i = 0; i < int_el_count; i += 16) {
                _mm512_storeu_epi32(&int_buf[i], _mm512_set1_epi32(1));
            }
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            fprintf(stdout, "Buffer have values in idex 0, 10, 20: %d, %d, %d\n", int_buf[0], int_buf[10], int_buf[20]);
            fprintf(stdout, "Buffer initialized with %zu elements\n", int_el_count);
            
            break;
        }
        case FLOAT: {
            float* float_buf = (float*)buf;
            size_t float_el_count = size_in_bytes / sizeof(float);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            for (size_t i = 0; i < float_el_count; i += 16) {
                _mm512_storeu_ps(&float_buf[i], _mm512_set1_ps(1.0f));
            }
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            fprintf(stdout, "Buffer have values in idex 0, 10, 20: %f, %f, %f\n", float_buf[0], float_buf[10], float_buf[20]);
            fprintf(stdout, "Buffer initialized with %zu elements\n", float_el_count);

            break;
        }
        case DOUBLE: {
            double* double_buf = (double*)buf;
            size_t double_el_count = size_in_bytes / sizeof(double);
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            
            for (size_t i = 0; i < double_el_count; i += 8) {
                _mm512_storeu_pd(&double_buf[i], _mm512_set1_pd(1.0));
            }
            
            clock_gettime(CLOCK_MONOTONIC, &end);
            fprintf(stdout, "Buffer have values in idex 0, 10, 20: %f, %f, %f\n", double_buf[0], double_buf[10], double_buf[20]);
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

    FILE* file = fopen("bandwidth.csv", "a");

    if (file == NULL) {
        fprintf(stderr, "Failed to open file for writing\n");
        return EXIT_FAILURE;
    }

    fprintf(file, "write;vect;%d;%d;1;1;%.2f;\n", in_data_type, arg_count/2, gbps);
    fclose(file);

    fprintf(stdout, "Data written to file\n");

    return EXIT_SUCCESS;
}
