#!/usr/bin/env bash

# data is downloaded from https://data.worldbank.org/indicator/SP.POP.TOTL
# but had to clean out it to make it easier to process for bash
# this is just an example so it is ok

file=${1:?"Provide the path to the data please"}
line=`head -1 $file`
char=","
fieldCount=`awk -F"${char}" '{print NF-1}' <<< "${line}"`
IFS=','
declare -a fieldName
fieldNames=($line)
i=0
printf "%32s %12d %12d %10s\n" ${fieldNames[0]} ${fieldNames[1]} ${fieldNames[$fieldCount]} "Increase"
while read -a data; do
    if [[ $i > 0 ]]; then # just to skip the first line
        country=${data[0]}
        first=${data[18]}
        last=${data[$fieldCount]}
        pct=$((last / first))
        printf "%32s %12d %12d %10s\n" "$country" $first $last $pct
    fi
    # just to skip the first line which is a header in the csv file
    ((i++))
done < $file


