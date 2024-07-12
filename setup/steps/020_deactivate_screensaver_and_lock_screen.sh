#!/bin/bash
#
# Screensaver und Lock-Screen deaktivieren
#
gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
gsettings set org.gnome.desktop.session idle-delay 0
#
# Repariere /etc/gdm3/custom.conf
#
sudo sed -i -e 's,Auto,# Auto,' /etc/gdm3/custom.conf

