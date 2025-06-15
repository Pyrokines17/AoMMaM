#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <string.h>
#include <immintrin.h>

#define HALF_GB 512*1024*1024ULL
#define GB 1024*1024*1024ULL

#define TRY_COUNT 3

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

double int_copy(void* buf, void* buf2, size_t size_in_bytes) {
    int* int_buf = (int*)buf;
    int* int_buf2 = (int*)buf2;

    double elapsed_time, min_time = 1000.0;

    struct timespec start, end;

    size_t int_el_count = size_in_bytes / sizeof(int);
    
    buf_init_int(int_buf, int_el_count);

    for (size_t try = 0; try < TRY_COUNT; ++try) {    
        clock_gettime(CLOCK_MONOTONIC, &start);
        
        for (size_t i = 0; i < int_el_count; i += 4) {
            __m128 data = _mm_stream_load_si128(&int_buf[i]);
            _mm_stream_si128(&int_buf2[i], data);
        }
        
        clock_gettime(CLOCK_MONOTONIC, &end);

        elapsed_time = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
        min_time = elapsed_time < min_time ? elapsed_time : min_time;
    }

    fprintf(stdout, "Buffer have values in idex 0, 10, 20: %d, %d, %d\n", int_buf2[0], int_buf2[10], int_buf2[20]);
    fprintf(stdout, "Buffer initialized with %zu elements\n", int_el_count);

    double bps = (double)size_in_bytes / min_time;
    double gbps = bps / (GB);

    fprintf(stdout, "Time taken for summation: %.6f seconds\n", min_time);

    return gbps;
}

void* thread_func(void* args) {
    thr_args_t* thr_args = (thr_args_t*)args;
    
    int id = thr_args->id;
    size_t size_in_bytes = thr_args->bytes;

    void* buf = _mm_malloc(size_in_bytes, 16);

    if (buf == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return NULL;
    }

    void* buf2 = _mm_malloc(size_in_bytes, 16);

    if (buf2 == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        _mm_free(buf);
        return NULL;
    }

    set_cpu(id);
    double gbps = 0.0;

    gbps = int_copy(buf, buf2, size_in_bytes);

    fprintf(stdout, "Thread %d Bandwidth: %.2f GB/s\n", id, gbps);

    _mm_free(buf);
    _mm_free(buf2);
    free(thr_args);
    
    double* ret_res = (double*)malloc(sizeof(double));
    
    *ret_res = gbps;
    
    return ret_res;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <count_halfs_of_gb> <thread_count>\n", argv[0]);
        return EXIT_FAILURE;
    }

    set_cpu(0);

    int arg_parts_count = atoi(argv[1]);
    int arg_thread_count = atoi(argv[2]);

    pthread_t threads[arg_thread_count];

    size_t size_in_bytes = arg_parts_count * HALF_GB;
    size_t size_in_bytes_per_thread = size_in_bytes / arg_thread_count;

    void* buf = _mm_malloc(size_in_bytes_per_thread, 16);

    if (buf == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    void* buf2 = _mm_malloc(size_in_bytes_per_thread, 16);

    if (buf2 == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        _mm_free(buf);
        return EXIT_FAILURE;
    }

    for (int i = 1; i < arg_thread_count; ++i) {
        thr_args_t* args = (thr_args_t*)malloc(sizeof(thr_args_t));

        args->id = i;
        args->bytes = size_in_bytes_per_thread;

        if (pthread_create(&threads[i], NULL, thread_func, args) != EXIT_SUCCESS) {
            fprintf(stderr, "Error creating thread %d\n", i);
            free(args);
            _mm_free(buf);
            _mm_free(buf2);
            return EXIT_FAILURE;
        }
    }

    double gbps = 0.0;

    gbps = int_copy(buf, buf2, size_in_bytes_per_thread);
    
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

    _mm_free(buf);
    _mm_free(buf2);

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

    fprintf(file, "copy;non_temp;1;%d;%d;1;%s;%.2f;\n", arg_parts_count/2, arg_thread_count, file_end, all_gbps);
    fclose(file);
    free(file_end);

    fprintf(stdout, "Data written to file\n");

    return EXIT_SUCCESS;
}
