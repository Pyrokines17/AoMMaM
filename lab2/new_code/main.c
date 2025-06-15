#define _GNU_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define LONG_COUNT 100000
#define ELEMENTS_COUNT 1024*1024*30
#define TRY_COUNT 5

int nop_count = 1;

size_t* getArray(void) {
    size_t* arr = (size_t*)malloc(sizeof(size_t)*ELEMENTS_COUNT);
    size_t j, temp;

    for (size_t i = 0; i < ELEMENTS_COUNT; ++i) {
        arr[i] = i;
    }

    srand(time(NULL));

    for (size_t i = ELEMENTS_COUNT - 1; i > 0; --i) {
        j = rand() % i;

        temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }

    return arr;
}

int main(void) {
    struct timespec start, end;
    size_t* arr = getArray();
    size_t k = 0;
    double time;
    double mintime = 1000.0;

    for (int j = 0; j < TRY_COUNT; ++j) {
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    
        for (size_t i = 0; i < ELEMENTS_COUNT; ++i) {
            k = arr[k];
            
            asm("nop");
        }
    
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
        
        time = (end.tv_sec-start.tv_sec)+(end.tv_nsec-start.tv_nsec)/1e9;

        mintime = (mintime < time) ? mintime : time;
    }

    printf("%ld", k);

    FILE* fptr = fopen("results.csv", "a");
    
    if (fptr == NULL) {
        fprintf(stderr, "Error: can not write result");
        return -1;
    } 
    
    fprintf(fptr, "%d;%f;\n", nop_count, mintime);
    printf("%d;%f;\n", nop_count, mintime);
    
    fclose(fptr);
    free(arr);

    return 0;
}