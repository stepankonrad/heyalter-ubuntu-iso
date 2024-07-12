#!/bin/bash
#
# Checke, ob es ein Script für das Modell gibt
# Wenn ja, führe es aus 
#

if [ -x "$BINDIR/steps/$MODELLSCRIPT" ]; then

   gnome-terminal --wait -- "$BINDIR/steps/$MODELLSCRIPT" "$LOGFILE"

fi

