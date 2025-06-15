#define _GNU_SOURCE

#include <limits.h>
#include <float.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <math.h>

#define BITER 1000000
#define AITER 50
#define TRY_COUNT 5

int main(void) {
    struct timespec start, end;
    double k = DBL_MAX;
    double time = 0.0;
    double mintime = 1000.0;

    int nop_count = 1;

    for (int try = 0; try < TRY_COUNT; ++try) {
        for (int j  = 0; j < BITER; ++j) {
            clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    
            for (int i = 0; i < AITER; ++i) {
                k = sqrt(k);
                
                asm("nop");
            }
    
            clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    
            time += (end.tv_sec-start.tv_sec)+(end.tv_nsec-start.tv_nsec)/1e9;
        }

        mintime = (mintime < time) ? mintime : time;
        time = 0.0;
    }
    
    FILE* fptr = fopen("results1.csv", "a");

    if (fptr == NULL) {
        fprintf(stderr, "Error: can not write result");
        return -1;
    } 

    fprintf(fptr, "%d;%f;\n", nop_count, mintime);

    fclose(fptr);

    printf("Prog finish");

    return 0;
}