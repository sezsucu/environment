#!/usr/bin/env bash

file=${1:?"You must provide a file path"}

if [[ ! -f $file ]]; then
    echo "No such file: $file"
    exit
fi

cat $file | (
    i=0
    while read; do
        printf "%4d %s\n" $i "$REPLY"
        ((i++))
    done
)
echo "----------------------------------------"
i=0
while read; do
    printf "%4d %s\n" $i "$REPLY"
    ((i++))
done < $file
