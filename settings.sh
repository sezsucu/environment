#!/usr/bin/env bash

# The default, in case we can't figure out the real local time zone
if [[ -z "${TZ}" ]]; then
    LOCAL_TIME_ZONE="Etc/UTC"
elif [[ -z "${LOCAL_TIME_ZONE}" ]]; then
    LOCAL_TIME_ZONE=$TZ
fi
if [ -f /etc/timezone ]; then
  LOCAL_TIME_ZONE=`cat /etc/timezone`
elif [ -h /etc/localtime ]; then
    LOCAL_TIME_ZONE=`readlink /etc/localtime`
    if [[ $LOCAL_TIME_ZONE =~ ^\/var\/db ]]; then
        LOCAL_TIME_ZONE=`readlink /etc/localtime | sed "s/\/var\/db\/timezone\/zoneinfo\///"`
    else
        LOCAL_TIME_ZONE=`readlink /etc/localtime | sed "s/\/usr\/share\/zoneinfo\///"`
    fi
fi

