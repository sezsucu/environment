#!/usr/bin/env bash

# a simple color table using the brk text

testString='brk'

echo -e "\n             40m     41m     42m     43m     44m     45m     46m     47m";

for FG in 'm' '1m' '30m' '1;30m' '31m' '1;31m' '32m' '1;32m' '33m' \
            '1;33m' '34m' '1;34m' '35m' '1;35m' '36m' '1;36m' '37m' '1;37m'; do
  printf "%5s \033[$FG $testString" $FG
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
    printf " \033[$FG\033[$BG  $testString  \033[0m";
  done
  printf "\n"
done
echo

for a in {a..z}; do
    printf $a
done
echo
