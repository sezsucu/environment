#!/usr/bin/env bash

function showHelp()
{
    echo "guess_my_number.sh [-n NUMBER]"
    echo "Default is from 1 to 10"
    echo "If NUMBER is provided, it would be from 1 to that NUMBER"
    exit 0
}

limit=10
while getopts "h?n:" opt; do
    case "$opt" in
    h|\?)
        showHelp
        ;;
    n)
        limit=$OPTARG
        ;;
    esac
done


guess=${RANDOM}
guess=$((guess % limit + 1))
answer=""
#echo $guess
while [[ $answer != $guess ]]; do
    echo "Guess my number please from 1 to $limit"
    read -t 3 answer
    if [[ $answer =~ ^[[:digit:]]+$ ]]; then
        if [[ $answer < $guess ]]; then
            echo "Go Up"
         elif [[ $answer > $guess ]]; then
            echo "Go Down"
         else
            echo "You got it"
         fi
    fi
done

