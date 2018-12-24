#!/usr/bin/env bash

# analyzes and manipulates string

str=${1:?"You must provide a string value"}

printf "%20s: %d\n" "Length" ${#str}
if [[ ${#str} > 5 ]]; then
    printf "%20s: %s\n" "Substr(5)" ${str:0:5}
fi
printf "%20s: %s\n" "Without last char" ${str:0:(${#str}-1)}
printf "%20s: %s\n" "Without first char" ${str:1:${#str}}
if [[ ${#str} > 5 ]]; then
    printf "%20s: %s\n" "Concatenated" "${str:1:${#str}}${str:0:(${#str}-1)}"
fi
items=("apple" "banana" "peach" "strawberry")
list=""
for item in "${items[@]}"; do
    list="${list}${list:+, }$item"
done
echo $list
