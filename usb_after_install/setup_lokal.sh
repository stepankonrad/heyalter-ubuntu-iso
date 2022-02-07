#!/bin/bash

# anzeigen der systemparameter

zenity --info --text "$(lshw -C memory)\n------------------------------------\nAnzahl Kerne: $(nproc)\n------------------------------------\n$(lshw -C cpu)" --width 1024

mkdir -p ${HOME}/.config/systemd/user
cp -R ./homeschule/.config/systemd/user/* ${HOME}/.config/systemd/user

mkdir ${HOME}/Bilder
cp ./homeschule/Bilder/los_gehts.png ${HOME}/Bilder/los_gehts.png

sudo cp -R ./heyalter /opt/
cp ./setup/heyalterhelp.desktop ~/Schreibtisch
chmod ug+x ~/Schreibtisch/heyalterhelp.desktop
gio set ~/Schreibtisch/heyalterhelp.desktop "metadata::trusted" true

# Install snaps
gnome-terminal --wait -- bash -c "cd setup/snaps/; sudo ./_install_all_snaps.sh;"

# einstellen der favoriten
dconf write /org/gnome/shell/favorite-apps "['chromium_chromium.desktop', 'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'org.gnome.Software.desktop']"


# zeige nach reboot bei erster verbindung die wilkommen-seite
systemctl enable --user heyalter.service

# richte das hintergrundbild ein
gsettings set org.gnome.desktop.background picture-uri "file://${HOME}/Bilder/los_gehts.png"

cheese

chromium

