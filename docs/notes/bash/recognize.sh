#!/usr/bin/env bash

# gets a string and then checks wheter it is an email, phone number or date

if [[ $# != 1 ]]; then
    echo "Provide a string"
    exit 1
fi

word="$1"

if [[ $word =~ ^[[:alnum:]]+@[[:alpha:]]+?\.[[:alpha:]]{2,3}$ ]]; then
    echo "email"
elif [[ $word =~ ^[[:digit:]]{3}-[[:digit:]]{3}-[[:digit:]]{4}$ ]]; then
    echo "phone"
elif [[ $word =~ ^[[:digit:]]{2}(-|/|\\)[[:digit:]]{2}(-|/|\\)[[:digit:]]{4}$ ]]; then
    echo "date"
else
    echo "No idea what it is"
fi

