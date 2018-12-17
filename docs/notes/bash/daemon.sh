#!/usr/bin/env bash

# BEGIN configurable stuff
pidDir="." # where to store the pid file
logDir="." # where to store the logs
logMaxSize=1048576   # 1 MB
runInterval=30       # number of seconds to wait after each run

function doWork()
{
    # to be completed by you
    log "Doing Work"
    return 0
}

function clean()
{
    # to be completed by you
    return 0
}
# END configurable stuff

if [[ $# != 1 ]]; then
    echo "Usage: daemon.sh [start|stop|status|restart]"
    exit 1
fi

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
    log "$daemonName stopped"
    echo "Removing $pidFile"
    \rm $pidFile
    clean
    exit 1
}

function log()
{
    echo `date +"%Y-%m-%dT%H:%M:%S"`": $*" >> $logFile
}

function bigLoop()
{
    while [[ 1 ]]; do
        local begin=`date +%s`
        doWork
        local end=`date +%s`

        if [[ ! $((begin - end + runInterval + 1)) < $runInterval ]]; then
            log "Sleeping " $((begin - end + runInterval))
            sleep $((begin - end + runInterval))

            # check if the log file needs to be moved
            if [[ -f "$logFile" ]]; then
                lsOutput=$(ls -ld "$logFile")
                declare -a fileInfo
                fileInfo=($lsOutput)
                if [[ $logMaxSize < ${fileInfo[4]} ]]; then
                    log "Moving log file"
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

    trap "cleanOut" TERM
    log "Starting daemon $daemonName : $myPid"
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
        kill -TERM `cat "$pidFile"` &> /dev/null
        sleep 1
    else
        break
    fi

    printf "$daemonName stopping..."
    local i=0
    while [[ -f $pidFile ]]; do
        if (( i > runInterval )); then
            echo "Couldn't stop $daemonName"
            exit 1
        fi
        ((i+=2))
        sleep 2
        printf "."
    done
    printf "stopped"
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
        if ! check ; then
            echo "$daemonName is already running"
            exit 1
        fi
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


