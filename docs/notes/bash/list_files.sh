#!/usr/bin/env bash

# lists all direct files and their sizes in a given directory path

if [[ $# != 1 ]]; then
    echo "Provide a directory path"
    exit 1
fi

dir=$1
if [[ ! -d $dir ]]; then
    echo "No such directory: $dir"
    exit 1
fi

filesStr=$(find "$dir" -maxdepth 1 -type f)
files=
file=
i=
IFS=$'\n' read -rd '' -a files <<<"$filesStr"
for (( i=0 ; i < ${#files[@]} ; i++ )); do
    file=${files[$i]}
    if [[ "$file" != "$dir" ]]; then
        if [[ -r "$file" ]]; then
            lsOutput=$(ls -ld "$file")
            declare -a fileInfo
            fileInfo=($lsOutput)
            printf "%s: %s \n" "$(basename "$file")" ${fileInfo[4]}
        fi
    fi
done


