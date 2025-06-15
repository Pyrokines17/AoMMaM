#!/bin/bash

OLD_FILES=(
    "multi_thread/copy/common.c"
    "multi_thread/copy/lib_func.c"
    "multi_thread/copy/non_temp.c"
    "multi_thread/copy/vect.c"
    "multi_thread/copy/promotion/common.c"
    "multi_thread/copy/promotion/non_temp.c"
    "multi_thread/copy/promotion/vect.c"
    "multi_thread/read/common.c"
    "multi_thread/read/lib_func.c"
    "multi_thread/read/non_temp.c"
    "multi_thread/read/vect.c"
    "multi_thread/read/promotion/common.c"
    "multi_thread/read/promotion/non_temp.c"
    "multi_thread/read/promotion/vect.c"
    "multi_thread/write/common.c"
    "multi_thread/write/lib_func.c"
    "multi_thread/write/non_temp.c"
    "multi_thread/write/vect.c"
    "multi_thread/write/promotion/common.c"
    "multi_thread/write/promotion/non_temp.c"
    "multi_thread/write/promotion/vect.c"
)

FILES=(
    "multi_thread/copy/non_temp.c"
    "multi_thread/copy/promotion/non_temp.c"
    "multi_thread/read/non_temp.c"
    "multi_thread/read/promotion/non_temp.c"
    "multi_thread/write/non_temp.c"
    "multi_thread/write/promotion/non_temp.c"
    "multi_thread/write/lib_func.c"
)

declare -A SPECIFIC_FILES=(
    ["multi_thread/copy/non_temp.c"]=""
    ["multi_thread/copy/promotion/non_temp.c"]=""
    ["multi_thread/read/non_temp.c"]=""
    ["multi_thread/read/promotion/non_temp.c"]=""
    ["multi_thread/write/non_temp.c"]=""
    ["multi_thread/write/promotion/non_temp.c"]=""
    ["multi_thread/write/lib_func.c"]=""
)

OPTIMIZATIONS=(
    "-O0"
    "-O1"
    "-O2"
    "-O3"
    "-Ofast"
)

PARTS=(
    2
    4
    6
    8
)

TYPES=(
    0
    1
    2
    3
)

THREADS=(
    1
    2
    4
    8
)

mkdir -p bin

intel-init

for file in "${FILES[@]}"; do
    for opt in "${OPTIMIZATIONS[@]}"; do
        output="bin/prog_${opt//-}"
        echo "Компилирую $file с $opt -> $output"
        icx "$file" "$opt" -o "$output" -Wall -march=tigerlake
    done
    
    for opt in "${OPTIMIZATIONS[@]}"; do
        prog="bin/prog_${opt//-}"

        # if [[ -n "${SPECIFIC_FILES[$file]}" ]]; then
        #     for part in "${PARTS[@]}"; do
        #         for thread in "${THREADS[@]}"; do
        #             echo "Запускаю $prog с $opt, part=$part, thread=$thread"
        #             ./"$prog" "$part" "$thread"
        #         done
        #     done
        # else
            for part in "${PARTS[@]}"; do
                #for type in "${TYPES[@]}"; do
                    for thread in "${THREADS[@]}"; do
                        #echo "Запускаю $prog с $opt, part=$part, type=$type, thread=$thread"
                        #./"$prog" "$part" "$type" "$thread"
                        echo "Запускаю $prog с $opt, part=$part, thread=$thread"
                        ./"$prog" "$part" "$thread"
                    done
                #done
            done  
        #fi
    done
done