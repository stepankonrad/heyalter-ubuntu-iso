#!/bin/bash


# anzeigen der systemparameter

zenity --info --text "$(lshw -C memory)\n------------------------------------\nAnzahl Kerne: $(nproc)\n------------------------------------\n$(lshw -C cpu)" --width 1024

snap install /home/schule/chromium.snap

# Rechte der kopierten Dateien fixen
gnome-terminal --wait -- bash -c "sudo chown -R schule:schule /home/schule/; cd /home/schule/snaps/; sudo ./_install_all_snaps.sh;"

# einstellen der favoriten
dconf write /org/gnome/shell/favorite-apps "['chromium_chromium.desktop', 'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'org.gnome.Software.desktop']"


# zeige nach reboot bei erster verbindung die wilkommen-seite
systemctl enable --user heyalter.service

# richte das hintergrundbild ein
gsettings set org.gnome.desktop.background picture-uri 'file:///home/schule/Bilder/los_gehts.png'

cheese

chromium

touch /home/schule/setup_done
