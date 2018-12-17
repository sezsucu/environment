#!/usr/bin/env bash

FILE_PATH=${BASH_SOURCE[0]}
ROOT_DIR="$( cd "$( dirname "$FILE_PATH" )" && pwd )"
echo "Installed at $ROOT_DIR, running as $FILE_PATH"

function getAccessString()
{
    local file=$1
    local answer=""
    if [[ -r $file ]]; then
        answer="${answer}r"
    fi
    if [[ -w $file ]]; then
        answer="${answer}w"
    fi
    if [[ -x $file ]]; then
        answer="${answer}x"
    fi

    echo $answer
}

accessStr=$(getAccessString $FILE_PATH)
echo $accessStr

