#!/bin/bash

# Testen auf eine WLAN-Karte
if ! nmcli d wifi rescan; then
  zenity --warning --text "Keine funktionierende WLAN-Karte gefunden! Bitte noch eine einbauen, den Treiber installieren oder einen WLAN-Stick beilegen."
fi

# Script aus setup-Netzwerk ausführen (sofern vorhanden)
if nmcli dev wifi connect 'HeyAlter Setup'; then
  gnome-terminal --wait -- bash -c 'curl set.up | bash'
fi
