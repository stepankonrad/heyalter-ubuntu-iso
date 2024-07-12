#!/bin/bash
# 
# Setze das Heyalter Hintergrundbild
#
# Räume die Hintergrundbilder auf, bevor sie aktiviert werden
#
if [ "$MODELL" == "Surface Laptop" ]; then
   mv /home/schule/Bilder/surface_los_gehts.svg /home/schule/Bilder/los_gehts.svg
else
   rm /home/schule/Bilder/surface_los_gehts.svg
fi
#
# und setze den Hintergrund auch für das dunkle Thema
#
gsettings set  org.gnome.desktop.background picture-uri      file:///home/schule/Bilder/los_gehts.svg
gsettings set  org.gnome.desktop.background picture-uri-dark file:///home/schule/Bilder/los_gehts.svg

