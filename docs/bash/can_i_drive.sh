#!/usr/bin/env bash

# make a crude decision on whether you can drive or not

echo "Hold are you? "
read age
echo "Do you have a driver license? [Y/N] "
read answer

if [[ $age > 18 && ( $answer == 'Y' || $answer == 'y' ) ]]; then
    echo "Yes you can drive"
elif [[ $age > 15 && ( $answer == 'Y' || $answer == 'y' ) ]]; then
    echo "Do you have an adult driver with you? [Y/N] "
    read answer
    if [[ ( $answer == 'Y' || $answer == 'y' ) ]]; then
        echo "Yes you can drive"
    else
        echo "No you can't drive"
    fi
else
    echo "No you can't drive"
fi
