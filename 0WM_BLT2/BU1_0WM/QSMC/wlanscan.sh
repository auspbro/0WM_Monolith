#!/bin/bash
# Program:
#   Tester can test the hardware functions of KUD SMT board.
# History:
#   v1: 2017/06/22
#	v2: 2017/11/22
# Author:
#   Sakia Lien 

# normal
NORM="\033[0m"

## Colors:
BLACK="\033[0;30m"
GRAY="\033[1;30m" # dark gray
RED="\033[0;31m"
LRED="\033[1;31m" # light red
GREEN="\033[0;32m"
LGREEN="\033[1;32m" # light green
YELLOW="\033[0;33m"
LYELLOW="\033[1;33m" # light yellow
BLUE="\033[0;34m"
LBLUE="\033[1;34m" # light blue
PURPLE="\033[0;35m"
PINK="\033[1;35m" # light purple
CYAN="\033[0;36m"
LCYAN="\033[1;36m" # light cyan
LGRAY="\033[0;37m" # light gray
WHITE="\033[1;37m"
## Backgrounds
BLACKB="\033[0;40m"
REDB="\033[0;41m"
GREENB="\033[0;42m"
YELLOWB="\033[0;43m"
BLUEB="\033[0;44m"
PURPLEB="\033[0;45m"
CYANB="\033[0;46m"
GREYB="\033[0;47m"

## Attributes:
UNDERLINE="\033[4m"
BOLD="\033[1m"
INVERT="\033[7m"

## Cursor movements
CUR_UP="\033[1A"
CUR_DN="\033[1B"
CUR_LEFT="\033[1D"
CUR_RIGHT="\033[1C"

## Start of display (top left)
SOD="\033[1;1f"

## Default Variable
EXIT_SUCCESS=0
EXIT_FAIL=1

title() { echo -e "${LYELLOW}${BOLD}$@${NORM}" ;}
print_fail() { echo -e "${REDB}${BOLD}$@${NORM}" ;}
print_success() { echo -e "${BLUEB}${BOLD}$@${NORM}" ;}

title "Wireless Inforamtion ...... "
ifconfig mlan0

title "Wireless Scan ...... "
ifconfig mlan0 up
ifconfig mlan0 up

rm /tmp/wifi.log
iw dev mlan0 scan | egrep "signal|SSID|freq" | tee /tmp/wifi.log

echo -e "${NORM}"

CKWIFI=$(cat /tmp/wifi.log | grep SSID | wc -l)
if [ "$CKWIFI" == "0" ]
then
    print_fail "FAIL"
else
    print_success "PASS"
fi

echo -e "${NORM}"