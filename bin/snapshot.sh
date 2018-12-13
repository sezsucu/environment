#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$ROOT_DIR/../lib.sh"

function showHelp ()
{
    echo "snapshot.sh [sourceDir]"
    echo "snapshot.sh sourceDir targetDir"
    echo "-n: do not compress"
    echo "snapshot.sh -s [sourceDir | sourceDir targetDir]: delete previous snapshots, make a single snapshot"
    echo "snapshot.sh -d [sourceDir | sourceDir targetDir]: delete all snapshots"
    echo "snapshot.sh -l [sourceDir | sourceDir targetDir]: list all snapshots"
    exit 0
}

function deleteSnapshots ()
{
    local source=$1
    local target=$2
    local listOnly=$3
    local sourceName=$(basename $source)

    if [[ ! -d $target ]]; then
        echo "No such directory: $target"
        exit 1
    fi

    local filesStr=$(find "$target" -maxdepth 1)
    local files
    local file
    local i
    IFS=$'\n' read -rd '' -a files <<<"$filesStr"
    for (( i=0 ; i < ${#files[@]} ; i++ )); do
        file=${files[$i]}
        if [[ "$file" =~ ${sourceName}\_S.* ]]; then
            if [[ $listOnly == 1 ]]; then
                echo $file
            else
                echo "Deleted $file"
                if [[ -d $file ]]; then
                    rm -r $file
                else
                    rm $file
                fi
            fi
        fi
    done
}

function snapshot ()
{
    local source=$1
    local target=$2
    local timestamp=$3
    local compress=$4
    local sourceName=$(basename $source)
    local sourceParent=$(dirname $source)

    if [[ ! -d $target ]]; then
        echo "No such directory: $target";
        exit 1
    fi

    if [[ $compress == 1 ]]; then
        cd $sourceParent
        pack ${sourceName}_S${timestamp}.tar.gz $sourceName;
        if [[ ! -e $target/${sourceName}_S${timestamp}.tar.gz ]]; then
            \mv ${sourceName}_S${timestamp}.tar.gz $target
        fi
    fi
}

action=""
compress=1
while getopts "h?dlsn" opt; do
    case "$opt" in
    h|\?)
        showHelp
        ;;
    d)
        action="delete"
        ;;
    l)
        action="list"
        ;;
    s)
        action="single"
        ;;
    n)
        compress=0
        ;;
    esac
done
shift $(expr $OPTIND - 1 )

timestamp=`date -u +"%Y_%m_%dT%H%M%S"`
if [[ $# == 0 ]]; then
    sourceDir=`pwd`
    targetDir=$(dirname "$sourceDir")
elif [[ $# == 1 ]]; then
    sourceDir=$(getRealPath $1)
    targetDir=$(dirname "$sourceDir")
elif [[ $# == 2 ]]; then
    sourceDir=$(getRealPath $1)
    targetDir=$(getRealPath $2)
fi

if [[ "$targetDir" == "$sourceDir" ]]; then
    echo "Target and source can not be same: $targetDir vs $sourceDir"
    exit 1
fi

case "$action" in
    delete)
        echo "Deleting all snapshots of $sourceDir at $targetDir"
        deleteSnapshots "$sourceDir" "$targetDir" 0
        ;;
    single)
        echo "Snapshotting a single snapshot of $sourceDir at $targetDir with $timestamp"
        deleteSnapshots "$sourceDir" "$targetDir"
        snapshot "$sourceDir" "$targetDir" $timestamp $compress
        ;;
    list)
        echo "Listing all snapshots of $sourceDir at $targetDir"
        deleteSnapshots "$sourceDir" "$targetDir" 1
        ;;
    *)
        echo "Snapshotting $sourceDir to $targetDir with $timestamp"
        snapshot "$sourceDir" "$targetDir" $timestamp $compress
        ;;
esac
