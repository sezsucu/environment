#!/usr/bin/env bash

word=${1:?"Provide the word please"}

if grep "^$word$" ../data/1000.txt; then
    echo "Yes it is a common English word"
else
    echo "Nope, it is not a common word"
fi


