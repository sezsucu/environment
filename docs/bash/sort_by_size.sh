#!/usr/bin/env bash

# sorts files in a given directory by size

if [[ $# != 1 ]]; then
    echo "Usage: sort_by_size.sh /path/to/dir"
    exit 1
fi

path="$1"
declare -a sizes
declare -a names

filesStr=$(find "$path" -maxdepth 1 -type f)
IFS=$'\n' read -rd '' -a files <<<"$filesStr"
for (( i=0 ; i < ${#files[@]} ; i++ )); do
    file=${files[$i]}
    if [[ "$path" != "$file" ]]; then
        lsOutput=$(ls -ld "$file")
        declare -a fileInfo
        fileInfo=($lsOutput)
        fileSize=${fileInfo[4]}
        names+=("$fileSize $file")
    fi
done

echo "${names[*]}"
echo "------"
IFS=$'\n' sorted=($(sort -rn <<<"${names[*]}"))
for name in "${sorted[@]}"; do
    echo $name
done
echo "------"
# due to IFS change above, the below prints with \n
echo "${names[*]}"

