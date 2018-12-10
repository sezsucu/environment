#!/usr/bin/env bash

if [[ ! -z $ENV_DATA_DIR ]]; then
    echo "env is not installed properly: Undefined ENV_DATA_DIR environment variable"
    exit 1
fi
ENV_DATA_DIR=$ENV_DATA_DIR

function showHelp ()
{
    echo "manageVars.sh [-a varName varValue][-h][-d varName]"
    echo "-a varName: add or update varName with the varValue"
    echo "-d varName: delete the varName"
    echo "-l: lists all the varNames and their values"
    exit 0
}

function addVar ()
{
    local name=$1
    local value=$2
    if [[ -e $ENV_DATA_DIR/bash/bashVars.sh && -n "$(grep ${name}= $ENV_DATA_DIR/bash/bashVars.sh)" ]]; then
        echo "Found $name in $ENV_DATA_DIR/bash/bashVars.sh, updating its value"
        sed -i".bak" "/export $name=/d" $ENV_DATA_DIR/bash/bashVars.sh
    fi
    echo "export $name='$value'" >> $ENV_DATA_DIR/bash/bashVars.sh
}

function removeVar ()
{
    local name=$1
    if [[ -e $ENV_DATA_DIR/bash/bashVars.sh && -n "$(grep ${name}= $ENV_DATA_DIR/bash/bashVars.sh)" ]]; then
        echo "Removed $name in $ENV_DATA_DIR/bash/bashVars.sh"
        sed -i".bak" "/export $name=/d" $ENV_DATA_DIR/bash/bashVars.sh
        #unset local
    else
        echo "No such var: $name"
    fi
}

function listVars ()
{
    if [ -e $ENV_DATA_DIR/bash/bashVars.sh ]; then
        cat $ENV_DATA_DIR/bash/bashVars.sh
    else
        echo "Empty List"
    fi
}

if [[ $# == 0 ]]; then
    showHelp
fi

varName=""
add=0
while getopts "h?a:d:l" opt; do
    case "$opt" in
    h|\?)
        showHelp
        ;;
    a)
        varName=$OPTARG
        add=1
        ;;
    d)
        varName=$OPTARG
        add=0
        ;;
    l)
        listVars
        exit 0
        ;;
    esac
done
shift $(expr $OPTIND - 1 )

if [[ $add == 1 ]]; then
    if [[ $# == 0 ]]; then
        echo "Missing varValue"
        exit 1
    fi
    varValue=$1
    addVar $varName "$varValue"
else
    removeVar $varName
fi


