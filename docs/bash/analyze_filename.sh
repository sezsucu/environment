#!/usr/bin/env bash

# try it with file.tar.gz to see the diff between % and %%

file=${1:?"Provide the file name please"}

name=${file%.*}
name2=${file%%.*}
extension=${file#*.}
extension2=${file##*.}
echo "Name: $name"
echo "Name2: $name2"
echo "Extension: $extension"
echo "Extension2: $extension2"
