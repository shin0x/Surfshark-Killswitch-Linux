#!/bin/bash

#check if root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#
#IPv4
#

#create backup of old iptables rules


DIR="$HOME/.iptables_backup/" #directory to save iptables backup in

if [ ! -d "$DIR" ]; then
  mkdir $DIR
fi

iptables-save > "$DIR/old.iptables.rules"
ip6tables-save > "$DIR/old.iptables6.rules"


#remove old rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t mangle -F
iptables -t raw -F
iptables -t raw -X

#deny everything by default
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

#allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#allow loopback device
iptables -A INPUT -j ACCEPT -i lo
iptables -A OUTPUT -o lo -j ACCEPT

#allow dhcp server
iptables -A OUTPUT -d 255.255.255.255 -j  ACCEPT 
iptables -A INPUT -s 255.255.255.255 -j ACCEPT

#allow the vpn
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A OUTPUT -o tun+ -j ACCEPT
iptables -t nat -A POSTROUTING -o tun+ -j MASQUERADE

#allow OpenVPN
iptables -A OUTPUT -p udp -m udp --dport 1194 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1194 -j ACCEPT

#
#IPv6
#

#remove old rules
ip6tables -F
ip6tables -X
ip6tables -t nat -F
ip6tables -t mangle -F
ip6tables -t raw -F
ip6tables -t raw -X

#deny everything by default
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT ACCEPT

#allow loopback device
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT

echo 'ACTIVATED KILLSWITCH'
