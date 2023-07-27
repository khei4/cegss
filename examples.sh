#!/bin/bash

# 対象となるディレクトリ
root_dir="examples"

LLVM_BIN_PATH="$HOME/git/llvm-project/buildcegss/bin"
OPT="$LLVM_BIN_PATH/opt"
# ディレクトリ内の全ての.llファイルに対して処理を行う
find $root_dir -name "*.ll" -type f | while read file
do
    if [[ $base == *_opt* ]]; then
        continue
    fi

    base=$(basename "$file" .ll)
    dir=$(dirname "$file")
    # optコマンドを実行
    $OPT -S -O2 "$file" > "${dir}/${base}_opt.ll" 2> "${dir}/${base}.log"
done