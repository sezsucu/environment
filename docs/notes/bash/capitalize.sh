#!/usr/bin/env bash

# gets a string and then capitalizes the first letter

if [[ $# == 0 ]]; then
    echo "Provide a string"
    exit 1
fi

first=$1
shift

first="$(tr '[:lower:]' '[:upper:]' <<< ${first:0:1})${first:1}"
echo $first $*
