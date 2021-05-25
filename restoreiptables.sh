#!/bin/bash

#check if root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

DIR="$HOME/.iptables_backup/" #directory to save iptables backup in

FILEIPFOUR=$DIR/old.iptables.rules
FILEIPSIX=$DIR/old.iptables6.rules

if [ -f "$FILEIPFOUR" ]; then
    #remove current rules
    iptables -F
    #restore old rules
    iptables-restore < $FILEIPFOUR
fi

if [ -f "$FILEIPSIX" ]; then
    #remove current rules
    ip6tables -F
    #restore old rules
    ip6tables-restore < $FILEIPSIX
fi

#check if internet is now available
nc -z 8.8.8.8 53  >/dev/null 2>&1
online=$?
if [ $online -eq 0 ]; then
  echo 'DEACTIVATED KILLSWITCH'
else
  echo 'Something went wrong! The Killswitch is still on. Please refer to the README for a solution'
fi
