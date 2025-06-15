#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <immintrin.h>
#include <string.h>

#define HALF_GB 512*1024*1024ULL
#define GB 1024*1024*1024ULL

#define TRY_COUNT 3

enum data_type {
    INT = 0,
    FLOAT = 1,
    DOUBLE = 2
};

typedef struct thr_args {
    int id;
    size_t bytes;
    int data_type;
} thr_args_t;

void set_cpu(int n) {
    pthread_t tid = pthread_self();
    cpu_set_t cpuset;
    int err;

    CPU_ZERO(&cpuset);
    CPU_SET(n, &cpuset);

    err = pthread_setaffinity_np(tid, sizeof(cpu_set_t), &cpuset);

    if (err != EXIT_SUCCESS) {
        fprintf(stderr, "set_cpu: pthread_setaffinity failed for cpu %d\n", n);
        return;
    }

    printf("set_cpu: set cpu %d\n", n);
}

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

double int_read(void* buf, size_t size_in_bytes) {
    int* int_buf = (int*)buf;
    int s = 0;

    double elapsed_time, min_time = 1000.0;

    struct timespec start, end;

    size_t int_el_count = size_in_bytes / sizeof(int);
    
    buf_init_int(int_buf, int_el_count);

    for (size_t try = 0; try < TRY_COUNT; ++try) {    
        s = 0;

        clock_gettime(CLOCK_MONOTONIC, &start);
        
        for (size_t i = 0; i < int_el_count; i += 16) {
            __m512i v = _mm512_loadu_si512(&int_buf[i]);
            s += _mm512_reduce_add_epi32(v);
        }
        
        clock_gettime(CLOCK_MONOTONIC, &end);
        
        fprintf(stdout, "Sum of buffer elements: %d\n", s);

        elapsed_time = (end.tv_sec - start.tv_sec) + 
                       (end.tv_nsec - start.tv_nsec) / 1e9;
        min_time = elapsed_time < min_time ? elapsed_time : min_time;
    }
    
    double bps = (double)size_in_bytes / min_time;
    double gbps = bps / (GB);

    fprintf(stdout, "Time taken for summation: %.6f seconds\n", min_time);

    return gbps;
}

double float_read(void* buf, size_t size_in_bytes) {
    float* float_buf = (float*)buf;
    float s = 0.0f;

    double elapsed_time, min_time = 1000.0;

    struct timespec start, end;

    size_t float_el_count = size_in_bytes / sizeof(float);
    
    buf_init_float(float_buf, float_el_count);

    for (size_t try = 0; try < TRY_COUNT; ++try) {
        s = 0.0f;

        clock_gettime(CLOCK_MONOTONIC, &start);
        
        for (size_t i = 0; i < float_el_count; i += 16) {
            __m512 v = _mm512_loadu_ps(&float_buf[i]);
            s += _mm512_reduce_add_ps(v);
        }
        
        clock_gettime(CLOCK_MONOTONIC, &end);

        fprintf(stdout, "Sum of buffer elements: %f\n", s);

        elapsed_time = (end.tv_sec - start.tv_sec) + 
                       (end.tv_nsec - start.tv_nsec) / 1e9;
        min_time = elapsed_time < min_time ? elapsed_time : min_time;
    }

    double bps = (double)size_in_bytes / min_time;
    double gbps = bps / (GB);

    fprintf(stdout, "Time taken for summation: %.6f seconds\n", min_time);

    return gbps;
}

double double_read(void* buf, size_t size_in_bytes) {
    double* double_buf = (double*)buf;
    double s = 0.0;

    double elapsed_time, min_time = 1000.0;

    struct timespec start, end;

    size_t double_el_count = size_in_bytes / sizeof(double);
    
    buf_init_double(double_buf, double_el_count);

    for (size_t try = 0; try < TRY_COUNT; ++try) {
        s = 0.0;

        clock_gettime(CLOCK_MONOTONIC, &start);
        
        for (size_t i = 0; i < double_el_count; i += 8) {
            __m512d v = _mm512_loadu_pd(&double_buf[i]);
            s += _mm512_reduce_add_pd(v);
        }
        
        clock_gettime(CLOCK_MONOTONIC, &end);

        fprintf(stdout, "Sum of buffer elements: %f\n", s);

        elapsed_time = (end.tv_sec - start.tv_sec) + 
                       (end.tv_nsec - start.tv_nsec) / 1e9;
        min_time = elapsed_time < min_time ? elapsed_time : min_time;
    }
    
    double bps = (double)size_in_bytes / min_time;
    double gbps = bps / (GB);

    fprintf(stdout, "Time taken for summation: %.6f seconds\n", min_time);

    return gbps;
}

void* thread_func(void* args) {
    thr_args_t* thr_args = (thr_args_t*)args;
    
    int id = thr_args->id;
    int data_type = thr_args->data_type;
    size_t size_in_bytes = thr_args->bytes;

    void* buf = malloc(size_in_bytes);

    if (buf == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return NULL;
    }

    set_cpu(id);
    double gbps = 0.0;

    switch (data_type) { 
        case INT: {
            gbps = int_read(buf, size_in_bytes);
            break;
        }
        case FLOAT: {
            gbps = float_read(buf, size_in_bytes);
            break;
        }
        case DOUBLE: {
            gbps = double_read(buf, size_in_bytes);
            break;
        }
    }

    fprintf(stdout, "Thread %d Bandwidth: %.2f GB/s\n", id, gbps);

    free(buf);
    free(thr_args);
    
    double* ret_res = (double*)malloc(sizeof(double));
    
    *ret_res = gbps;
    
    return ret_res;
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <count_halfs_of_gb> <data_type> <thread_count>\n", argv[0]);
        return EXIT_FAILURE;
    }

    set_cpu(0);

    int arg_parts_count = atoi(argv[1]);
    int in_data_type = atoi(argv[2]);
    int arg_thread_count = atoi(argv[3]);

    pthread_t threads[arg_thread_count];

    size_t size_in_bytes = arg_parts_count * HALF_GB;
    size_t size_in_bytes_per_thread = size_in_bytes / arg_thread_count;

    void* buf = malloc(size_in_bytes_per_thread);

    if (buf == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    for (int i = 1; i < arg_thread_count; ++i) {
        thr_args_t* args = (thr_args_t*)malloc(sizeof(thr_args_t));

        args->id = i;
        args->bytes = size_in_bytes_per_thread;
        args->data_type = in_data_type;

        if (pthread_create(&threads[i], NULL, thread_func, args) != EXIT_SUCCESS) {
            fprintf(stderr, "Error creating thread %d\n", i);
            free(args);
            free(buf);
            return EXIT_FAILURE;
        }
    }

    double gbps = 0.0;

    switch (in_data_type) { 
        case INT: {
            gbps = int_read(buf, size_in_bytes_per_thread);
            break;
        }
        case FLOAT: {
            gbps = float_read(buf, size_in_bytes_per_thread);
            break;
        }
        case DOUBLE: {
            gbps = double_read(buf, size_in_bytes_per_thread);
            break;
        }
    }
    
    fprintf(stdout, "Bandwidth for first: %.2f GB/s\n", gbps);

    double all_gbps = gbps;

    for (int i = 1; i < arg_thread_count; ++i) {
        void* ret_res;
        pthread_join(threads[i], &ret_res);
        
        if (ret_res != NULL) {
            double thread_gbps = *(double*)ret_res;
            all_gbps += thread_gbps;
            free(ret_res);
        }
    }

    fprintf(stdout, "Total Bandwidth: %.2f GB/s\n", all_gbps);

    free(buf);

    FILE* file = fopen("bandwidth.csv", "a");

    if (file == NULL) {
        fprintf(stderr, "Failed to open file for writing\n");
        return EXIT_FAILURE;
    }

    size_t len = strlen(argv[0]);
    size_t need_pos = (strstr(argv[0], "_") - argv[0]) + 1;
    char* file_end = (char*)malloc(len - need_pos + 1);
    strncpy(file_end, argv[0] + need_pos, len - need_pos);
    file_end[len - need_pos] = '\0';

    fprintf(file, "read;vect;%d;%d;%d;1;%s;%.2f;\n", in_data_type, arg_parts_count/2, arg_thread_count, file_end, all_gbps);
    fclose(file);
    free(file_end);

    fprintf(stdout, "Data written to file\n");

    return EXIT_SUCCESS;
}
