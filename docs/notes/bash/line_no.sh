#!/usr/bin/env bash

# gets a file path and then shows line number next to each line

if [[ $# != 1 ]]; then
    echo "Provide a file path"
    exit 1
fi

file=$1
if [[ ! -f $file ]]; then
    echo "No such file: $file"
    exit 1
fi

declare -a lines
while IFS= read -r line; do
    lines+=("$line")
done < "$file"

for (( i=0 ; i < ${#lines[@]} ; i++ )); do
    printf "%4d  %s\n" $i "${lines[$i]}"
done
