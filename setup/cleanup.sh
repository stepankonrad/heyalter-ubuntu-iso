#!/bin/bash
#
# das große Aufräumen; nur wenn setup_done gesetzt ist.
#

#
# Trennstrich aus Geviertstrichen
#
STRICH="———————————————————————————————————"

if [ ! -f /opt/setup/setup_done ]
then
  zenity --warning --text "<b><big>Erst setup.sh ausführen!</big></b>\n${STRICH}\nNotfalls mit <b>/opt/setup/steps/100_setup_done.sh</b>\nFertigmeldung nachholen" --width 512
  exit 2
fi
#
# Lösche die alten Desktop Einträge 
#
rm ~/Schreibtisch/setup.desktop
rm ~/Schreibtisch/cleanup.desktop
rm ~/Schreibtisch/update.desktop

sudo rm /etc/skel/Schreibtisch/setup.desktop /etc/skel/Schreibtisch/cleanup.desktop /etc/skel/Schreibtisch/update.desktop

#
# Screensaver und Lock-Screen reaktivieren
#
gsettings set org.gnome.desktop.screensaver lock-enabled 'true'
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'false'
gsettings set org.gnome.desktop.session idle-delay 300

#
# zeige nach reboot bei erster verbindung die wilkommen-seite
#
systemctl enable --user heyalter.service

#
# Lösche Setup Verzeichnis
#
sudo rm -r /opt/setup

#
# WLAN Einstelllungen entfernen
#
sudo rm -f /etc/NetworkManager/system-connections/*

#
# AutoLogin wieder deaktivieren
#
sudo sed -i 's/AutomaticLogin/#AutomaticLogin/g' /etc/gdm3/custom.conf
