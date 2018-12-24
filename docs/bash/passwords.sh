#!/usr/bin/env bash

# gets the user name and processes ../data/passwd to find the line
# which belongs to that user name

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

