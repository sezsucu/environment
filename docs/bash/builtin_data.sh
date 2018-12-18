#!/usr/bin/env bash


length=${#USER}
x=$((15-length))
SPACE=''
for (( i=0; i < $x ; i++ )); do
    SPACE="$SPACE "
done
cat <<End-of-Message
                   _________________
           .--H--.|             jgs |
         _//_||  ||  $USER${SPACE}|
        [    -|  |'--;--------------'
        '-()-()----()"()-------()"()'
End-of-Message

declare -a names
declare -a values
while read name value; do
    echo "$name = $value"
    names+=($name)
    values+=($value)
done <<EOF
name1 value1
name2 value2
name3 value3
name4 value4
name5 value5
name6 value6
EOF

echo "${names[*]}"
echo "${values[*]}"

