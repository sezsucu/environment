#!/usr/bin/env bash

# will strip the quotes
# ./unquote.sh \'Hello World\'
# ./unquote.sh \"Hello World\"

string="$*"
if [[ -n $string ]]; then
    echo $string
    if [[ ${string:0:1} == '"' ]]; then
        temp="${string%\"}"
        temp="${temp#\"}"
    else
        temp="${string%\'}"
        temp="${temp#\'}"
    fi
    echo $temp
fi

