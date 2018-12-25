#!/usr/bin/env bash

path=${1:?"Provide path please"}

declare -A stats
filesStr=$(find "$path" -type f)
files=
file=
i=
IFS=$'\n' read -rd '' -a files <<<"$filesStr"
for (( i=0 ; i < ${#files[@]} ; i++ )); do
    file=${files[$i]}
    type=`file -b "$file" | cut -d, -f1`
    let stats["$type"]++;
done

for type in "${!stats[@]}"; do
    echo $type : ${stats["$type"]}
done
