# Surfshark-Killswitch-Linux
A simple script to create a killswitch under debian 

In case you want the killswitch to be resettet after the computer restarted or you simply don't want to use ufw for any reason there are now the iptableskillswitch.sh and the restoreiptables.sh. With these scripts you can basically do the same thing as with the old killswitch just that now the connection doesn't stay killed after a device restart. 

In case the restore of the old iptables does not work and you don't have any internet connection you can simply reboot the system or use the disableKillSwitch command.