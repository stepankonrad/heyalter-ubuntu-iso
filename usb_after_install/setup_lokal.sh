#!/bin/bash

# einstellen der favoriten
# xmessage -center Hallo

# anzeigen der systemparameter

zenity --info --text "$(lshw -C memory)\n------------------------------------\nAnzahl Kerne: $(nproc)\n------------------------------------\n$(lshw -C cpu)" --width 1024

mkdir -p ${HOME}/.config/systemd/user
cp -R ./.config/systemd/user/* ${HOME}/.config/systemd/user

mkdir ${HOME}/Bilder
cp ./Bilder/los_gehts.png ${HOME}/Bilder/los_gehts.png

# Install Chrome
gnome-terminal --wait -- bash -c "sudo ./_install_all_snaps.sh;"

#mkdir -p ${HOME}/.config/systemd/user;
# cp -R ./.config/systemd/user ${HOME}/.config/systemd/user
# mkdir -p ${HOME}/Bilder;
# cp ./Bilder/los_gehts.png ${HOME}/Bilder/los_gehts.png;

dconf write /org/gnome/shell/favorite-apps "['chromium_chromium.desktop', 'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'org.gnome.Software.desktop']"


# zeige nach reboot bei erster verbindung die wilkommen-seite
systemctl enable --user heyalter.service

# richte das hintergrundbild ein
gsettings set org.gnome.desktop.background picture-uri "file://${HOME}/Bilder/los_gehts.png"

cheese

chromium

