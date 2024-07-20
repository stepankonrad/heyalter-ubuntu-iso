#!/bin/bash
#
# Testen auf eine WLAN-Karte
#
if ! nmcli d wifi rescan; then
   zenity --warning --icon=network-wireless --width=650 \
	  --text "Keine funktionierende WLAN-Karte gefunden! Bitte noch eine einbauen, den Treiber installieren oder einen WLAN-Stick beilegen."
fi
#
# Wenn schon Netzwerk vorhanden ist weiter nichts zu tun 
# Diese Logik geht implizit davon aus, dass das HeyAlter Setup Netzwerk zu diesem Zeitpunkt NICHT schon aktiv ist 
#
if [ $(nmcli n connectivity check) == "full" ]; then
   echo "Netzwerk ist oben"
   exit 0
fi

#
#  Wenn HeyAlter Setup WLAN vorhanden, dann verbinden und die Daten sammeln & schicken
#

if nmcli dev wifi connect 'HeyAlter Setup'; then

   REPLY=$(zenity --title="Rechnernummer eingeben" --entry --text="Rechnernummer ohne BS- eingeben (bsp. 1234 für den Rechner BS-1234 eingeben)")

   sudo $BINDIR/steps/sammle_information $REPLY 2>&1 | tee -a $LOGFILE
#
# Aufruf Update Software nur lokal in BS 
#
   sudo $BINDIR/steps/_update_software.sh
   return $?

fi
#
# Kein Netzwerk vorhanden!
#
zenity --warning --icon=network-error --width=650 \
      --text="Es ist keine Netzwerkverbindung aktiv" 

