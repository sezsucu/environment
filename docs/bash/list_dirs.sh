#!/usr/bin/env bash

# lists all direct directories in a given directory path

dir=${1:?"You must provide a directory path"}
if [[ ! -d $dir ]]; then
    echo "No such directory: $dir"
    exit 1
fi

filesStr=$(find "$dir" -maxdepth 1 -type d)
files=
file=
i=
IFS=$'\n' read -rd '' -a files <<<"$filesStr"
echo ${#files[@]} directories in $dir
for (( i=0 ; i < ${#files[@]} ; i++ )); do
    file=${files[$i]}
    if [[ "$file" != "$dir" ]]; then
        printf "%s \n" "$(basename "$file")"
    fi
done

