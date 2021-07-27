#!/bin/bash

sudo apt install openvpn-systemd-resolved resolvconf openvpn ufw
chmod +x enableKillSwitch.sh
chmod +x disableKillSwitch.sh
chmod +x iptableskillswitch.sh
chmod +x restoreiptables.sh
sudo cp enableKillSwitch.sh /bin/enableKillSwitch 
sudo cp disableKillSwitch.sh /bin/disableKillSwitch 
sudo cp iptableskillswitch.sh /bin/iptableskillswitch
sudo cp restoreiptables.sh /bin/restoreiptables
