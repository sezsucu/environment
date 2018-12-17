#!/usr/bin/env bash

# nohup sh daemon.sh start > /dev/null 2>&1 &

source "$ENV_HOME_DIR/lib.sh"

if [[ $# != 1 ]]; then
    echo "Usage: daemon.sh [start|stop|status|restart]"
    exit 1
fi

function doWork()
{
    # to be completed by you
    openResource "http://www.apple.com"
    echo "Doing Work"
    return 0
}

function clean()
{
    # to be completed by you
    return 0
}

pidDir="."
logDir="."
logMaxSize=1048576  # 1 MB
runInterval=30      # number of seconds to wait after each run

daemonScript="${BASH_SOURCE[0]}"
daemonName=$(basename "${BASH_SOURCE[0]}")
pidFile="$pidDir/$daemonName.pid"
logFile="$logDir/$daemonName.log"
myPid=`echo $$`

if [ -f "$pidFile" ]; then
    oldPid=`cat "$pidFile"`
fi

function cleanOut()
{
    echo "Removing $pidFile"
    \rm $pidFile
    clean
    exit 1
}

trap "cleanOut" USR1

function log()
{
    echo '*** '`date +"%Y-%m-%d"`": $*" >> $logFile
}

function bigLoop()
{
    while [[ 1 ]]; do
        local now=`date +%s`
        doWork
        local last=`date +%s`

        if [[ ! $((now-last+runInterval+1)) < $((runInterval)) ]]; then
            log "Sleeping " $((now-last+runInterval))
            sleep $((now-last+runInterval))

            # check if the log file needs to be truncated
            if [[ -f "$logFile" ]]; then
                lsOutput=$(ls -ld "$logFile")
                declare -a fileInfo
                fileInfo=($lsOutput)
                if [[ $logMaxSize > ${fileInfo[4]} ]]; then
                    \mv $logFile "$logFile.old"
                    touch $logFile
                fi
            fi
        fi
    done
}

function check()
{
    if [[ -z "$oldPid" ]]; then
        return 0
    elif [[ `ps aux | grep " $oldPid " | grep -v grep` ]]; then
        if [[ -f "$pidFile" ]]; then
            if [[ `cat "$pidFile"` == $oldPid ]]; then
                return 1
            else
                return 0
            fi
        fi
    else
        return 0
    fi
    return 1
}

function start()
{
    if ! check ; then
        echo "$daemonName is already running"
        exit 1
    fi

    echo "Starting daemon $daemonName : $myPid"
    echo "$myPid" > $pidFile

    bigLoop
}

function stop()
{
    if check; then
        echo "$daemonName is NOT running"
        exit 1
    fi

    if [[ ! -z `cat $pidFile` ]]; then
        kill -USR1 `cat "$pidFile"` &> /dev/null
        sleep 1
    else
        break
    fi

    log "$daemonName stopped"
    echo "$daemonName stopped"
}

function restart()
{
    if check; then
        echo "$daemonName is NOT running"
        exit 1
    fi

    stop
    start
}

function status()
{
    if check; then
        echo "$daemonName is NOT running"
    else
        echo "$daemonName is running"
    fi
}

command=$1
case $command in
    _realstart)
        start
        ;;
    start)
        nohup bash "$daemonScript" _realstart > /dev/null 2>&1 &
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        restart
        ;;
    *)
        echo "Usage: daemon.sh [start|stop|status|restart]"
        exit 1
        ;;
esac


