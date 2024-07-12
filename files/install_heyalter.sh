#!/bin/bash
#
# Kommandos zum Aufsetzen von Heyalter Umgebung
#
#
# Kopieren nach /opt
cp -r /cdrom/setup /cdrom/APT /target/opt/ 
chmod -R 755 /target/opt/setup 
#
# Kopieren des skeleton Verzeichnis - alle User bekommen dadurch die HeyAlter Standardeinstellung!
#
cp -r /cdrom/skeleton/* /cdrom/skeleton/.config /target/etc/skel
chmod -R 750 /target/etc/skel
#
# Kopiere Service - Skript zum Löschen des Passworts & setze Link 
#
cp /cdrom/setup/add_files/heyalter-prep.service /target/usr/lib/systemd/system
ln -s /usr/lib/systemd/system/heyalter-prep.service /target/etc/systemd/system/multi-user.target.wants/heyalter-prep.service
