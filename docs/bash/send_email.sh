#!/usr/bin/env bash

function showHelp()
{
    echo "send_email.sh -s 'Subject' -t 'someone@test.com' < body.txt"
    exit 0
}

subject=""
to=""
while getopts ":h?s:t:" opt; do
    case "$opt" in
    h|\?)
        showHelp
        ;;
    \:)
        echo "Missing argument for $OPTARG"
        exit 2
        ;;
    s)
        subject="$OPTARG"
        ;;
    t)
        to="$OPTARG"
        ;;
    esac
done

if [[ ! -n $to ]]; then
    echo "You must provide to email using -t"
    showHelp
fi
echo "Now type the body of the email"

declare -a arr
while IFS= read -r line; do
    arr+=("$line");
done
echo ""
echo "To: $to"
echo "Subject: $subject"
for (( i=0 ; i < ${#arr[@]} ; i++ )); do
    echo ${arr[$i]}
done
