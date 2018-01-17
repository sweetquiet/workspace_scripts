#!/bin/sh

# define some colors to use with echo -e
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
DGRAY='\033[1;30m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LBLUE='\033[1;34m'
LPURPLE='\033[1;35m'
LCYAN='\033[1;36m'
WHITE='\033[1;37m'
NOCOLOR='\033[0m'

echoc()
{   
    if [ $# -lt 2 ]; then
      echo "echoc usage: echoc <COLOR> <TEXT>"
      return
    fi

    color=${1}
    shift
    echo -e "${color}${@}${NOCOLOR}"
}

echo_error()
{
    echoc $RED "$@"
}

echo_warn()
{
    echoc $YELLOW "$@"
}

echo_debug()
{
    echoc $GREEN "$@"
}

echo_info()
{
    echoc $LGREEN "$@"
}

echo_note()
{
    echoc $LBLUE "$@"
}

apt_install()
{
    while [[ ! -z "$1" ]]; do
        dpkg -s $1 &>/dev/null || sudo apt-get -y install $1
        shift
    done
}

append_to_file()
{
    file=$1
    line=$2

    # check if file exists and create it
    if [ ! -f $file ]; then
         touch $file
    fi

    echo "$line" >> $file
}

append_to_file_if_not_exist()
{
    file=$1
    line=$2

    # check if file exists and create it
    if [ ! -f $file ]; then
         touch $file
    fi

    # check if entry exists and add it
    if ! grep -Fxq "$line" $file; then
      echo "$line" >> $file
    fi
}

remove_from_file()
{
    file=$1
    line=$2

    sed -i "\?${line}?d" $file
}

remove_from_file_exact()
{
    file=$1
    line=$2

    sed -i "\?\<${line}\>?d" $file
}
