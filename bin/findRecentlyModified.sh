#!/usr/bin/env bash

# Find files with a given pattern $2 in name which is younger than $1 minutes (default) or days
# ex: findRecentlyModified 180
# ex: findRecentlyModified 180m # 180 minutes, same as without m
# ex: findRecentlyModified 10d # 10 days
# ex: findRecentlyModified 180 "*.cc"

if [ $# -eq 0 ]; then
    echo 'Usage: findRecentlyModified 180 OR findRecentlyModified 180 "*.cc"'
    echo 'Find files with a given pattern $2 (defaults to all files) in name which is younger than $1 minutes'
fi

time=$1
length=${#time}
if [[ $time =~ ^[0-9]+[dD]$ ]]; then
    ((length--))
    time=${time:0:length}
    ((time*=1440))
elif [[ $time =~ ^[0-9]+[hH]$ ]]; then
    ((length--))
    time=${time:0:length}
    ((time*=60))
elif [[ $time =~ ^[0-9]+[mM]$ ]]; then
    ((length--))
    time=${time:0:length}
fi

(>&2 echo "Ignoring directories .git, idea")
eval find . \\\( -name ".git" -o -name ".idea" \\\) -prune -o -type f -name \"${2:-*}\" -mmin -$time -print;

