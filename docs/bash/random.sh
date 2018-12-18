#!/usr/bin/env bash

# generates random characters for a given length (by default 60 characters)

limit=${1:-60}
rand=`cat /dev/urandom | base64 | head -c $limit`
echo $rand | fold -w60

uuid=`uuidgen`
echo "Bonus : $uuid"
