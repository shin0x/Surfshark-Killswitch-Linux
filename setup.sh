#!/bin/bash

sudo apt install openvpn-systemd-resolved resolvconf openvpn ufw
chmod +x enableKillSwitch.sh
chmod +x disableKillSwitch.sh
sudo cp enableKillSwitch.sh /bin/enableKillSwitch 
sudo cp disableKillSwitch.sh /bin/disableKillSwitch 