#!/usr/bin/env bash

# use of set -x and set + x for debugging purposes

set -x
echo "This will be echoed due to debug mode"
i=0
((i++))
printf "%5d\n" $i

set +x

((i++))
echo "No more echoing lines"

