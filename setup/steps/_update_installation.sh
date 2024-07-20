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

bindir="$(dirname $0)"

logfile="/tmp/update_installation_$$.log"

gnome-terminal --wait -- sudo $bindir/update_installation  $logfile 

if [ ! -z "$LOGFILE" ]; then
   cat $logfile >> $LOGFILE
fi
