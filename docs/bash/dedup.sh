#!/usr/bin/env bash

# if given a single directory, finds all dupes within that directory
# otherwise finds all dupes within the given two directories
# creates a temporary directory, computed md5 of each file and stores
# the file path in a file named after the md5 of that file
# if an md5 file contains more than one file path, it means there is a duplicate
# in the end, it removes all files

platform="Linux"
unameStr=`uname`
if [[ "$unameStr" = "Darwin" ]]; then
    platform="Mac";
fi

if [[ $# != 2 && $# != 1 ]]; then
    echo "dedup.sh /path/to/dir1 [/path/to/dir2]"
fi

source="$1"
if [[ ! -d $source ]]; then
    echo "Not a directory: $source"
    exit 1
fi
if [[ $# == 2 ]]; then
    target="$2"

    if [[ ! -d $target ]]; then
        echo "Not a directory: $target"
        exit 1
    fi
fi

function getMd5()
{
    if [[ $platform == "Mac" ]]; then
        echo $(md5 $1) | cut -f4 -d ' '
    else
        echo $(md5sum $1) | cut -f1 -d ' '
    fi
}

tmpDir=$(mktemp -d -t dedup.XXXXXXXXX)
echo $tmpDir
function finish()
{
    \rm -rf "$tmpDir"
    echo "Deleted the $tmpDir"
}
trap finish EXIT

k=0
function processDir()
{
    local path=$1
    local filesStr=$(find "$path" -maxdepth 1)
    local files
    local file
    local i
    IFS=$'\n' read -rd '' -a files <<<"$filesStr"
    for (( i=0 ; i < ${#files[@]} ; i++ )); do
        file=${files[$i]}
        if [[ "$file" != "$path" && -r $file ]]; then
            if [[ -d $file ]]; then
                processDir $file
            elif [[ -f $file ]]; then
                if (( k % 20 == 0 )); then
                    echo "processing $k file: $file"
                fi
                md5=$(getMd5 $file)
                echo $file >> "$tmpDir/$md5"
                ((k++))
            fi
        fi
    done
}

processDir "$source"
if [[ ! -z $target ]]; then
    processDir "$target"
fi

filesStr=$(find "$tmpDir" -maxdepth 1)
IFS=$'\n' read -rd '' -a files <<<"$filesStr"
for (( i=0 ; i < ${#files[@]} ; i++ )); do
    file=${files[$i]}
    lineNo=`wc -l $file | cut -d ' ' -f1`
    if [[ $lineNo > 1 ]]; then
        cat $file
    fi
    echo ""
done
