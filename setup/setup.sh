#!/bin/bash

# FirstBoot Script zum Aufruf der setup.sh wieder löschen
rm /home/schule/.config/autostart/firstboot.desktop

# Screensaver und Lock-Screen deaktivieren
gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
gsettings set org.gnome.desktop.session idle-delay 0

# anzeigen der systemparameter
zenity --info --text "$(lshw -C memory)\n------------------------------------\nAnzahl Kerne: $(nproc)\n------------------------------------\n$(lshw -C cpu)" --width 1024

# Audio testen
zenity --info --text "OK klicken um Audio zu testen"

arecord|aplay &
PID=$!

zenity --info --text "Du solltest ein Echo hören. OK klicken um Audio-Test zu beenden"
kill $PID

# Kamera testen
cheese

# Laufwerk testen
eject

# Script aus setup-Netzwerk ausführen (sofern vorhanden)
if nmcli dev wifi connect 'HeyAlter Setup'; then
  gnome-terminal --wait -- bash -c 'curl set.up | bash'
fi

# Rechte der kopierten Dateien fixen
gnome-terminal --wait -- bash -c "/opt/setup/setuproot.sh"

# zeige nach reboot bei erster verbindung die wilkommen-seite
systemctl enable --user heyalter.service

# optinale Skripte ausführen
find /opt/setup/setup_extensions/ -name "*.sh" | sort -k1 | xargs -I {} bash {}
