#!/bin/bash
#
# Update usw. soll in Terminal laufen mit root-Rechten
#

logfile="/tmp/install_snaps_$$.log"

gnome-terminal --wait -- sudo $BINDIR/steps/install_snaps "$BINDIR" "$logfile"

cat "$logfile" >> "$LOGFILE"
