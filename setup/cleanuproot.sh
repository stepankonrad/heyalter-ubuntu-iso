#!/bin/bash

if [ ! -f /opt/setup/setup_done ]
then
# Should've been warned...
exit 2
fi

rm -r /opt/setup

# WLAN Einstelllungen entfernen
rm -f /etc/NetworkManager/system-connections/*

# AutoLogin wieder deaktivieren
sed -i 's/AutomaticLogin/#AutomaticLogin/g' /etc/gdm3/custom.conf
