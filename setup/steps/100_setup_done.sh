#!/bin/bash

#
# Setup ist abgeschlossen; Marker setzen
#

TRENNER="———————————————————————————————————"

sudo touch /opt/setup/setup_done

zenity --info --icon=system-reboot --ok-label="done" --width=650 \
       --text="Updates sind abgeschlossen.\n$TRENNER\nBitte Laptop neu starten &amp; Funktionen prüfen\n(Keyboard, Deckel schliessen, Akku aufladen etc. )\nLogfile des Setups ist unter $LOGFILE zu finden."
