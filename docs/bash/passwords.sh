#!/usr/bin/env bash

echo -n "Enter your user name: "
stty -echo
read userName
stty echo
echo

file="../data/passwd"
while IFS= read -r line; do
    lines+=("$line")
    oldIFS=$IFS
    IFS=':'
    items=($line)
    if [[ ${items[0]} == $userName ]]; then
        echo $line
        break
    fi
    IFS=$oldIFS
done < "$file"

