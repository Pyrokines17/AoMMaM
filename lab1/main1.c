#define _GNU_SOURCE

#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <sched.h>
#include <stdio.h>
#include <time.h>

#define MSIDE 2000
#define seconds 15.1
#define MAXITERS 1000000

union ticks {
    unsigned long long t64;
    struct s32 { long th, tl; } t32;
};

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
    set_cpu(2);

    int *matrix1, *matrix2, *matrix3, counter = 0;

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
                for (int k = 0; k < MSIDE; ++k) {
                    matrix3[i*MSIDE + j] += matrix1[i*MSIDE + k] * matrix2[k*MSIDE + j];
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

    double temp = 0.00000001, temp1 = 0.00000002, temp2 = 0.00000003, temp3 = 0.00000004, 
        temp4 = 0.00000005, temp5 = 0.00000006, temp6 = 0.00000007;
    union ticks startT, endT;

    asm("rdtscp\n":"=a"(startT.t32.th),"=d"(startT.t32.tl));
    
    for (int i = 0; i < MAXITERS; ++i) {
        temp *= 1.00000001;
        temp1 *= 1.00000001;
        temp2 *= 1.00000001;
        temp3 *= 1.00000001;
        temp4 *= 1.00000001;
        temp5 *= 1.00000001;
        temp6 *= 1.00000001;
    }

    asm("rdtscp\n":"=a"(endT.t32.th),"=d"(endT.t32.tl));

    unsigned long long diff = endT.t64-startT.t64;

    printf("End of lab\nTicks taken: %lld\nThroughput: %f\nResult: %f\n", diff, (double)diff/MAXITERS/7, temp);
    printf("Result1: %f\nResult2: %f\nResult3: %f\nResult4: %f\nResult5: %f\nResult6: %f\n", temp1, temp2, temp3, temp4, temp5, temp6);

    return 0;
}