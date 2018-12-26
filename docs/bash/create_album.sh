#!/usr/bin/env bash

# images downloaded from http://publicicons.org/

path=${1:?"Please provide path to images"}

function generate()
{
    img=$1
    baseName=$(basename $img)
    name=${baseName%.*}
    #cat <<EOF > ${name}.html
    cat <<EOF
$name
EOF
}

for img in $path/*.png; do
    generate $img
done
