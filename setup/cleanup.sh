#!/bin/bash

if [ ! -f /opt/setup/setup_done ]
then
zenity --warning --text "Erst setup.sh ausführen!" --width 512
exit 2
fi

rm ~/.config/autostart/trust.desktop

rm ~/Schreibtisch/*.desktop
find /home -lname '/opt/setup/*' -delete
cp /opt/setup/heyalterhelp.desktop ~/Schreibtisch
gio set ~/Schreibtisch/heyalterhelp.desktop "metadata::trusted" true
# HEY-HILFE-Support-Handbuch.pdf is downloaded to /setup in build.sh
cp /opt/setup/HEY-HILFE-Support-Handbuch.pdf ~/Schreibtisch

# Screensaver und Lock-Screen reaktivieren
gsettings set org.gnome.desktop.screensaver lock-enabled 'true'
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'false'
gsettings set org.gnome.desktop.session idle-delay 300

/opt/setup/cleanuproot.sh
