#!/bin/bash
#
# Update usw. soll in Terminal laufen mit root-Rechten
#

# ------------------------------------------------------------------------------------
#
# Check Netzwerk, sonst Abbruch
#

if [ -z "$(nmcli -g NAME c show --active)" ]; then
   
   zenity --error --icon=network-error --text="Kein Netzwerk vorhanden; breche hier ab"
   exit 2

fi

logfile="/tmp/update_installation_$$.log"

gnome-terminal --wait -- sudo $BINDIR/steps/update_installation  $logfile 

cat $logfile >> $LOGFILE
