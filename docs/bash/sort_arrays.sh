#!/usr/bin/env bash

myArray=()
myArray[0]="One"
myArray[1]="Two"
myArray[2]="Three"
myArray[3]="Four"

IFS=$'\n' sorted=($(sort <<<"${myArray[*]}"))
for name in "${sorted[@]}"; do
    echo $name
done

myArray[0]="One"
myArray[1]="Two"
myArray[2]="Three"
myArray[6]="Four"
echo "${myArray[*]}"


myArray[0]="1"
myArray[1]="2"
myArray[2]="3"
myArray[3]="4"
myArray[4]="5"
myArray[5]="6"
myArray[6]="7"
IFS=$'\n' sorted=($(sort -n <<<"${myArray[*]}"))
for name in "${sorted[@]}"; do
    echo $name
done
