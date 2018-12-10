#!/usr/bin/env bash

# find all files that are over the given size
# ex: findOverSize 10M
# ex: findOverSize 10M "*.log"
# ex: findOverSize 10k

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_PLATFORM="Linux"
source "$ROOT_DIR/../lib.sh"

if [ $# -eq 0 ]; then
    echo 'Usage: findOverSize 10M or findOverSize 10k "*.cc"'
    echo 'Find all files that are over the given size'
fi

# make k,M,G case insensitive, so K, m, g also work
sizeStr=$1
length=${#sizeStr}
((length--))
if [ "${sizeStr:length:1}" = "K" ]; then
    sizeStr=${sizeStr:0:length}"k"
elif [ "${sizeStr:length:1}" = "m" ]; then
    sizeStr=${sizeStr:0:length}"M"
elif [ "${sizeStr:length:1}" = "g" ]; then
    sizeStr=${sizeStr:0:length}"G"
elif [[ "${sizeStr:length:1}" =~ [[:digit:]] ]]; then
    echo "Using ${sizeStr}k"
    sizeStr=${sizeStr}"k"
elif [[ ! "${sizeStr:length:1}" =~ [kmg] ]]; then
    echo "Incorrect argument: $sizeStr"
    exit 1
fi
if [ "$ENV_PLATFORM" = "Mac" ]; then
    eval find -L . \\\( -name ".git" -o -name ".idea" \\\) -prune -o -type f -name \"${2:-*}\" -size +$sizeStr -print0 | xargs -n1 -0 ls -lhG;
else
    eval find -L . \\\( -name ".git" -o -name ".idea" \\\) -prune -o -type f -name \"${2:-*}\" -size +$sizeStr -print0 | xargs --no-run-if-empty -n1 -0 ls -lh --color;
fi
