#!/bin/bash

# 対象となるディレクトリ
root_dir="examples"

# ディレクトリ内の全ての.llファイルに対して処理を行う
find $root_dir -name "*.ll" -type f | while read file
do
    base=$(basename "$file" .ll)
    dir=$(dirname "$file")
    # optコマンドを実行
    opt -S -O2 "$file" > "${dir}/${base}_opt.ll" 2> "${dir}/${base}.log"
done