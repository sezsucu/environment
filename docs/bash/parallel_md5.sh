#!/usr/bin/env bash

# outputs md5s of files in a given directory
# depending on mode and cpu it could be faster if run on parallel mode
# use the time to see the difference
# in my simple experiment, the parallel was 4 times faster

function showHelp()
{
    echo "parallel_md5.sh [-s] /path/to/dir "
    exit 1
}

parallel=1
while getopts "h?s" opt; do
    case "$opt" in
    h|\?)
        showHelp
        ;;
    s)
        parallel=0
        ;;
    esac
done
shift $(expr $OPTIND - 1 )

if [[ $# == 0 ]]; then
    showHelp
fi
dir="$1"

ENV_PLATFORM="Linux"
unameStr=`uname`
if [[ "$unameStr" = "Darwin" ]]; then
    ENV_PLATFORM="Mac";
fi

filesStr=$(find "$dir" -maxdepth 1 -type f)
files=
file=
i=
IFS=$'\n' read -rd '' -a files <<<"$filesStr"
if [[ $parallel == 1 ]]; then
    pidArray=()
    for (( i=0 ; i < ${#files[@]} ; i++ )); do
        file=${files[$i]}
        if [[ "$file" != "$dir" ]]; then
            if [[ -r "$file" ]]; then
                if [ $ENV_PLATFORM == "Mac" ]; then
                    md5 $file &
                    pidArray+=("$!")
                else
                    md5sum $file &
                    pidArray+=("$!")
                fi
            fi
        fi
    done
    wait ${pidArray[@]}
else
    for (( i=0 ; i < ${#files[@]} ; i++ )); do
        file=${files[$i]}
        if [[ "$file" != "$dir" ]]; then
            if [[ -r "$file" ]]; then
                if [ $ENV_PLATFORM == "Mac" ]; then
                    md5 $file
                else
                    md5sum $file
                fi
            fi
        fi
    done
fi
