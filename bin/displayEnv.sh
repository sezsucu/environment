#!/usr/bin/env bash

# A script to gather some overall data about the host machine
# Including
# IP Address of the machine
# Client IP (if connected by ssh)
# Distro (if Linux)
# CPU Count, CPU Model, CPU Speed
# Total Memory, Free Memory and Free Memory Percentage in terms of Total Memory
# CPU Load
# Kernel Version

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_ARCH="64"
ENV_PLATFORM="Linux"
source "$ROOT_DIR/../lib.sh"

setupColors

IP4_UP="";
DNS_UP="";
IP_ADDRESS="";
MY_CLIENT_IP="";
CPU_MODEL="";
CPU_SPEED="";
CPU_COUNT="";
MEM_FREE="";
MEM_TOTAL="";
MEM_FREE_PCNT="";
DISTRO="";
DISTRO_VER="";
KERNEL=`uname -r`

if [ "$ENV_PLATFORM" = "Mac" ]; then
    DISTRO="Mac OS X"
    DISTRO_VER=$(sw_vers | grep ProductVersion | cut -f 2)
    IP_ADDRESS=`ifconfig | grep 'inet ' | grep -v '127.0.0.1' | cut -c 7-17 | head -1`
    CPU_MODEL=`/usr/sbin/system_profiler SPHardwareDataType | grep "Processor Name" | cut -d : -f2`
    CPU_SPEED=`/usr/sbin/system_profiler SPHardwareDataType | grep "Processor Speed" | cut -d : -f2`
    CPU_SPEED=" @ $CPU_SPEED";
    CPU_COUNT=`sysctl -n hw.ncpu`

    MEM_FREE=`\top -l 1 | grep PhysMem | awk '{printf $6}'`
    length=${#MEM_FREE}
    ((length--))
    if [[ $MEM_FREE=~/\d+M/ ]]; then
        MEM_FREE=${MEM_FREE:0:length}
        MEM_FREE=$((MEM_FREE*1024*1024))
    elif [[ $MEM_FREE=~/\d+G/ ]]; then
        MEM_FREE=${MEM_FREE:0:length}
        MEM_FREE=$((MEM_FREE*1024*1024*1024))
    fi
    MEM_TOTAL=`sysctl hw.memsize | awk '{printf $2}'`
    MEM_FREE_PCNT=$((100*$MEM_FREE/$MEM_TOTAL))
    MEM_TOTAL=`bytesToDisplay $MEM_TOTAL`
    MEM_FREE=`bytesToDisplay $MEM_FREE`
    LOAD=`w | grep up | awk '{print $12" "$11" "$12}'`
    LOAD15=$(echo $LOAD | cut -f 3 -d ' ');
elif [[ "$ENV_PLATFORM" = "Linux" || "$ENV_PLATFORM" == "WSL" ]]; then
    if [ "`command -v ip`" ]; then
        interface=`ip route get 8.8.8.8 | grep -Po '(?<=(dev )).*(?= src| proto)' | cut -f1 -d ' '`
        IP_ADDRESS=`ip addr show $interface | grep 'inet ' | cut -d t -f2 | cut -d : -f2 | cut -d ' ' -f2 | head -1 | cut -d '/' -f1`
    elif [ "`command -v /sbin/ifconfig`" ]; then
        IP_ADDRESS=`/sbin/ifconfig eth0 | grep 'inet ' | cut -d t -f2 | cut -d : -f2 | cut -d ' ' -f2 | head -1`
    else
        IP_ADDRESS="Couldn't detect it"
    fi
    CPU_SPEED=`grep "cpu MHz" /proc/cpuinfo | cut -d : -f2 | head -1`;
    CPU_MODEL=`grep "model name" /proc/cpuinfo | cut -d : -f2 | head -1`;
    CPU_COUNT=`grep "processor" /proc/cpuinfo | cut -d : -f2 | tail -1`;
    CPU_COUNT=$(echo "$[$CPU_COUNT+1]" );

    MEM_FREE=`cat /proc/meminfo | grep MemFree | cut -d: -f2 | cut -dk -f1`;
    MEM_TOTAL=`cat /proc/meminfo | grep MemTotal | cut -d: -f2 | cut -dk -f1`;
    MEM_TOTAL=$(echo "$[$MEM_TOTAL*1024]");
    MEM_FREE=$(echo "$[$MEM_FREE*1024]" );
    MEM_FREE_PCNT=$(echo "$[100*$MEM_FREE/$MEM_TOTAL]" );
    MEM_TOTAL=`bytesToDisplay $MEM_TOTAL`
    MEM_FREE=`bytesToDisplay $MEM_FREE`

    DISTRO="Unknown Distro"
    DISTRO_VER="Unknown Distro"
    if [ -f "/etc/os-release" ]; then
        . "/etc/os-release"
        DISTRO_VER=$VERSION
        DISTRO=$NAME
    else
        test -r "/etc/slackware-version" && DISTRO_VER=`cat /etc/slackware-version` && DISTRO="Slackware"
        test -r "/etc/debian_version" && DISTRO_VER=`cat /etc/debian_version` && DISTRO="Debian"
        test -r "/etc/redhat-release" && DISTRO_VER=`cat /etc/redhat-release` && DISTRO="Redhat"
        test -r "/etc/SuSE-release" && DISTRO_VER=`cat /etc/SuSE-release` && DISTRO="SuSe"
        test -r "/etc/gentoo-release" && DISTRO_VER=`cat /etc/gentoo-release` && DISTRO="Gentoo"
        test -r "/etc/turbolinux-release" && DISTRO_VER=`cat /etc/turbolinux-release` && DISTRO="TurboLinux"
    fi
    LOAD=`w | grep up | awk '{print $10" "$11" "$12}'`
    LOAD15=$(echo $LOAD | cut -f 3 -d ',');
elif [ "$ENV_PLATFORM" = "Cygwin" ]; then
    IP_ADDRESS=`ipconfig.exe  | grep -i "IPv4 address" | head -n 1 | cut -d ':' -f2 | cut -d ' ' -f2`
    CPU_SPEED=`grep "cpu MHz" /proc/cpuinfo | cut -d : -f2 | head -1`;
    CPU_MODEL=`grep "model name" /proc/cpuinfo | cut -d : -f2 | head -1`;
    CPU_COUNT=`grep "processor" /proc/cpuinfo | cut -d : -f2 | tail -1`;
    CPU_COUNT=$(echo "$[$CPU_COUNT+1]" );

    MEM_FREE=`cat /proc/meminfo | grep MemFree | cut -d: -f2 | cut -dk -f1`;
    MEM_TOTAL=`cat /proc/meminfo | grep MemTotal | cut -d: -f2 | cut -dk -f1`;
    MEM_TOTAL=$(echo "$[$MEM_TOTAL*1024]");
    MEM_FREE=$(echo "$[$MEM_FREE*1024]" );
    MEM_FREE_PCNT=$(echo "$[100*$MEM_FREE/$MEM_TOTAL]" );
    MEM_TOTAL=`bytesToDisplay $MEM_TOTAL`
    MEM_FREE=`bytesToDisplay $MEM_FREE`

    DISTRO="Cygwin"
    DISTRO_VER=`uname -r`
    LOAD=`wmic cpu get loadpercentage | grep -v Load | head -1`
    length=${#LOAD}
    if [[ $length > 1 ]]; then
        LOAD=${LOAD:0:2}
    fi
    LOAD15=$LOAD
    if [[ $LOAD15 > 95 ]]; then
        LOAD15=$CPU_COUNT
    else
        LOAD15=0
    fi

    LOAD="$LOAD %%"
fi

if [ `command -v curl` ]; then
    case "$(curl -s --max-time 2 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
      [23]) HTTP_OK="true"
        ;;
      *) HTTP_OK="false"
        ;;
    esac
fi

if [ `command -v ping` ]; then
    if [[ `which ping` = "/cygdrive/c/Windows/system32/ping" ]]; then
        if ping -n 1 -w 1000 8.8.8.8 >/dev/null 2>&1; then
            IP4_UP="true"
        else
            IP4_UP="false"
        fi

        if ping -n 1 -w 1000 google.com >/dev/null 2>&1; then
            DNS_UP="true"
        else
            DNS_UP="false"
        fi
    else
        if ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
            IP4_UP="true"
        else
            IP4_UP="false"
        fi

        if ping -q -c 1 -W 1 google.com >/dev/null 2>&1; then
            DNS_UP="true"
        else
            DNS_UP="false"
        fi
    fi
fi


if [ ! -z "${SSH_CONNECTION+x}" ]; then
    MY_CLIENT_IP=`echo $SSH_CONNECTION | awk '{print $1}'`;
fi


if [ ! -t 1 ]; then
    NC=""
    Red=""
    Blue=""
fi

printf "%14s: $ENV_PLATFORM ($ENV_ARCH bit)\n" "System"
if [[ ! -z "$ENV_HOME_DIR" ]]; then
    printf "%14s: $ENV_HOME_DIR \n" "Home Directory"
    printf "%14s: $ENV_DATA_DIR \n" "Data Directory"
fi
printf "\n"

if [ $IP4_UP = "true" ]; then
    if [ $DNS_UP = "true" ]; then
        if [ $HTTP_OK = "false" ]; then
            printf "%14s: $NC $IP4_UP ($Red NO HTTP $NC) \n" "IP4 is Up";
        else
            printf "%14s: $NC $IP4_UP \n" "IP4 is Up";
        fi
    else
        printf "%14s: $NC $IP4_UP ($Red DNS is DOWN $NC) \n" "IP4 is Up";
    fi
elif [ `command -v ping` ]; then
    printf "%14s: $Red $IP4_UP $NC \n" "IP4 is Up";
else
    printf "%14s: $Red $IP4_UP (no ping) $NC \n" "IP4 is Up";
fi
printf "%14s: $NC $IP_ADDRESS $NC \n" "IP Address";
printf "%14s: $NC ${MY_CLIENT_IP:-local} $NC \n" "SSH Client IP" ;

printf "\n" ;

printf "%14s: $NC $DISTRO $DISTRO_VER $NC \n" "Distro" ;
printf "%14s: $NC $CPU_COUNT x $CPU_MODEL $CPU_SPEED $NC \n" "CPU" ;
printf "%14s: $NC $MEM_TOTAL $NC \n" "Total Memory";
printf "%14s: $NC $MEM_FREE $NC ($MEM_FREE_PCNT %%)\n" "Free Memory";
if [[ "$LOAD15" > "$CPU_COUNT" ]]; then
    printf "%14s: $Red $LOAD $NC\n" "Load";
else
    printf "%14s: $NC $LOAD $NC\n" "Load";
fi
printf "%14s: $NC $KERNEL $NC \n" "Kernel";

printf "\n" ;

if [[ "$ENV_PLATFORM" = "Mac" ]]; then
    FILESYSTEMS=(`df -h | grep -vE "^Filesystem|shm|boot|none|devfs|map|\/snap" | awk '{ print $1, $4, $5, $9 }'`)
else
    FILESYSTEMS=(`df -h | grep -vE "^Filesystem|shm|boot|none|devfs|map|\/snap" | awk '{ print $1, $4, $5, $6 }'`)
fi
for (( i=0; i<${#FILESYSTEMS[@]}; i+=4 )); do
    fileSystemName=${FILESYSTEMS[$i]}
    available=${FILESYSTEMS[$i+1]}
    usePercentage=${FILESYSTEMS[$i+2]}
    mountPoint=${FILESYSTEMS[$i+3]}
    length=${#usePercentage}
    ((length--))
    usePercentage=${usePercentage:0:length}
    if [[ $usePercentage > 74 ]]; then
        printf "%14s: $Red $available $usePercentage%% %14s $NC \n" $mountPoint $fileSystemName;
    else
        printf "%14s: $NC $available $usePercentage%% %14s $NC \n" $mountPoint $fileSystemName;
    fi
done