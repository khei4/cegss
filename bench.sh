#!/bin/bash

# Get current time in milliseconds
current_time=$(date +%d_%H_%M_%S)

# Set output files for time and perf
time_output="time_output_$current_time.txt"
perf_output="perf_output_$current_time.txt"
LLVM_BIN_PATH="$HOME/git/llvm-project/buildcegss/bin"
CLANG="$LLVM_BIN_PATH/clang"
OPT="$LLVM_BIN_PATH/opt"
LOAD_CEGSS="passes=cegss -load-pass-plugin /home/khei4/git/cegss/build/libcegss.so"

# Change to the gmpbench-0.2 directory
cd gmpbench-0.2

# Loop over all .c files
for file in *.c; do
    echo "Processing $file..."

    # Create the .ll file
    $CLANG -S -emit-llvm $file -o "${file%.c}.ll"

    # Run opt1 and time it
    echo "Running opt1 on ${file%.c}.ll..." >> "$time_output"
    (/usr/bin/time -f "Real time for normal opt: %e" $OPT "${file%.c}.ll" -S -o  "${file%.c}_opt1.ll") 2>> "$time_output"
    perf stat -e instructions,cycles normal opt "${file%.c}.ll" -o "${file%.c}_opt1.ll" >> "$perf_output" 2>&1

    # Run opt2 and time it
    echo "Running opt2 on ${file%.c}.ll..." >> "$time_output"
    (/usr/bin/time -f "Real time for cegss opt: %e" $OPT "${file%.c}.ll" -S -o  "${file%.c}_opt2.ll") 2>> "$time_output"
    perf stat -e instructions,cycles cegss opt "${file%.c}.ll" -o "${file%.c}_opt2.ll" >> "$perf_output" 2>&1

    echo "Done with $file."
done
