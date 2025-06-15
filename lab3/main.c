#define _GNU_SOURCE

#include <pthread.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sched.h>
#include <time.h>

#define TRY_COUNT 7
#define MSIDE 500
#define seconds 2.0

union ticks {
    unsigned long long t64;
    struct s32 { long th, tl; } t32;
} startT, endT;

int k = 2;

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

void print_matrix(int *matrix) {
    for (int i = 0; i < MSIDE; ++i) {
        for (int j = 0; j < MSIDE; ++j) {
            printf("%d ", matrix[i*MSIDE + j]);
        }

        printf("\n");
    }
}

int main(void) {
    set_cpu(4);

    int *matrix1, *matrix2, *matrix3, counter = 0;
    unsigned long long tacts = ULLONG_MAX;
    unsigned long long diff;
    int a = 0;

    matrix1 = (int*)malloc(MSIDE * MSIDE * sizeof(int));
    matrix2 = (int*)malloc(MSIDE * MSIDE * sizeof(int));
    matrix3 = (int*)malloc(MSIDE * MSIDE * sizeof(int));

    for (int i = 0; i < MSIDE; ++i) {
        for (int j = i; j < MSIDE; ++j) {
            matrix1[i*MSIDE + j] = (i + j) % 10;
            matrix1[j*MSIDE + i] = (i + j) % 10;
        }
    }

    memcpy(matrix2, matrix1, MSIDE * MSIDE * sizeof(int));

    clock_t start, end;
    double cpu_time_used = 0.0;

    start = clock();

    while (cpu_time_used < seconds) {
        for (int i = 0; i < MSIDE; ++i) {
            for (int j = 0; j < MSIDE; ++j) {
                matrix3[i*MSIDE + j] = 0;

                for (int q = 0; q < MSIDE; ++q) {
                    matrix3[i*MSIDE + j] += matrix1[i*MSIDE + q] * matrix2[q*MSIDE + j];
                }
            }
        }

        counter++;
        end = clock();
        cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    }

    printf("End of warming up\nTime: %f\nIter count: %d\n\n", cpu_time_used, counter);

    if (matrix3[0] == 1234) {
        print_matrix(matrix3);
    }

    free(matrix1);
    free(matrix2);
    free(matrix3);

    for (int j = 0; j < TRY_COUNT; ++j) {
        asm("rdtscp\n":"=a"(startT.t32.th),"=d"(startT.t32.tl));
    
        for (int i = 0; i < 10e7; ++i) {
            if (i % k == 0) {
                a = 1;
            } 

            
            if (i < 0) {
                a = 10;
            }

            if (i < 0) {
                a = 10;
            }
	    
            if (i < 0) {
                a = 10;
            }
	    
            if (i < 0) {
                a = 10;
            }
	    
            if (i < 0) {
                a = 10;
            }
	    
            if (i < 0) {
                a = 10;
            }
	    
            if (i < 0) {
                a = 10;
            }
	    
            if (i < 0) {
                a = 10;
            }
            
        }
    
        asm("rdtscp\n":"=a"(endT.t32.th),"=d"(endT.t32.tl));
    
        diff = endT.t64-startT.t64;
        tacts = (tacts < diff) ? tacts : diff;
    }

    double res = tacts / 10e7;

    printf("%d", a);

    FILE *file = fopen("result.csv", "a");

    if (file == NULL) {
        fprintf(stderr, "Error opening file!\n");
        return EXIT_FAILURE;
    }

    fprintf(file, "%f;", res);
    printf("End |%f| for k = %d\n", res, k);

    return EXIT_SUCCESS;
}
