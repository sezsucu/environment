#!/usr/bin/env bash

# gets a file name and then tells what kind of a file it is

if [[ $# != 1 ]]; then
    echo "Provide a made-up file name like tree.jpg, letter.txt etc..."
    exit 1
fi

function processArg()
{
    local fileName="$1"
    case "$fileName" in
        (*.jpg|*.jpeg)
            echo "It is a jpeg image file"
            ;;
        *.txt)
            echo "It is a text file"
            ;;
        *.doc)
            echo "It is a Word document file"
            ;;
        *.gif)
            echo "It is a gif image file"
            ;;
        *.sh)
            echo "It is a bash shell script"
            ;;
        *)
            echo "No idea what it is"
            ;;
    esac
}

function processArg2()
{
    local fileName="$1"
    if [[ ("$fileName" == *.jpg || "$fileName" == *.jpeg ) ]]; then
            echo "It is a jpeg image file"
    elif [[ "$fileName" == *.txt ]]; then
        echo "It is a text file"
    elif [[ "$fileName" == *.doc ]]; then
        echo "It is a Word document file"
    elif [[ "$fileName" == *.gif ]]; then
        echo "It is a gif image file"
    elif [[ "$fileName" == *.gif ]]; then
        echo "It is a bash shell script"
    else
        echo "No idea what it is"
    fi
}

processArg "$1"
processArg2 "$1"
