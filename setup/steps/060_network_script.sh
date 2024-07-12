#!/bin/bash

# Testen auf eine WLAN-Karte
if ! nmcli d wifi rescan; then
   zenity --warning --icon=network-wireless --width=650 \
	  --text "Keine funktionierende WLAN-Karte gefunden! Bitte noch eine einbauen, den Treiber installieren oder einen WLAN-Stick beilegen."
fi

#
#  Wenn HeyAlter Setup WLAN vorhanden, dann die Daten sammeln & schicken
#

if nmcli dev wifi connect 'HeyAlter Setup'; then

   REPLY=$(zenity --title="Rechnernummer eingeben" --entry --text="Rechnernummer ohne BS- eingeben (bsp. 1234 für den Rechner BS-1234 eingeben)")

   sudo /opt/setup/setup_steps/sammle_information $REPLY 2>&1 | tee -a $LOGFILE

else
   zenity --warning --icon=network-error --width=650 \
      --text="Verbindung zu HeyAlter Setup nicht aufgebaut; bitte checken, ggf. eigene Verbindung?"
fi

