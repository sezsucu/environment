#!/usr/bin/env bash

# this is a process which is difficult to kill because of the trap

echo "Do Ctrl-Z and then jobs and then kill -USR2 pid"
function trapSignal()
{
    if [ "$1" = "USR2" ]; then
        echo "You killed me! Bye!"
        exit 0
    else
        echo "Not that easy to kill with $1 signal"
    fi
}

trap "trapSignal ABRT" ABRT
trap "trapSignal EXIT" EXIT
trap "trapSignal HUP"  HUP
trap "trapSignal INT"  INT
trap "trapSignal TERM" TERM
trap "trapSignal USR1" USR1
trap "trapSignal USR2" USR2

while (( 1 )); do
    :
done
