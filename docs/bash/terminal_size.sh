#!/usr/bin/env bash

# a cool demo of tputs

BG_BLUE="$(tput setab 4)"
FG_WHITE="$(tput setaf 7)"

function redraw()
{
    local cols=$(tput cols)
    local rows=$(tput lines)
    echo -n ${BG_BLUE}${FG_WHITE}
    local str="Columns = $cols Rows = $rows"
    local strLen=${#str}
    clear
    tput cup $((rows/2)) $(( (cols/2) - (strLen/2) ))
    echo $str
}

function cleanUp()
{
    stty echo # echo back the keyboard entries
    tput rmcup # restore the screen
}

trap redraw WINCH
trap cleanUp EXIT
trap cleanUp TERM

tput smcup # save the screen
clear
stty -echo # do not echo back the keyboard entries
redraw
while [[ 1 ]]; do
    tput civis # make cursor invisible
    read -rsn1 input
    if [ "$input" = "q" ]; then
        exit 1
    fi
done

