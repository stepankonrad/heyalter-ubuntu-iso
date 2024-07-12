#!/bin/bash
#
# Field Separator auf NEWLINE setzen 
#

IFS='\n'
BINDIR="$(dirname $0)"
LOGFILE=/var/tmp/setup_$$_$(date +%y%m%d_%H%M%S).log

#
# Abfrage Systemtyp; die Zeile die mit " " beginnt enthält die Information
#

MODELL="$(sudo lshw -class system -short -quiet | grep '^ ' | sed -e 's,^[ ]*system[ ]*,,' | cut -f1-2 -d' ')"
MODELLSCRIPT=$(echo "$MODELL" | tr " " "_" )

export BINDIR MODELL MODELLSCRIPT LOGFILE

touch "$LOGFILE"
chmod 666 $LOGFILE
#
# Die auszuführenden Steps fangen mit 3 Ziffern an und enden mit .sh 
#
steps=$(ls -1 "$BINDIR"/steps/[0-9][0-9][0-9]*.sh) 

#
# Anzeige des Fortschritts mit zenity
#
echo "$steps" | while read step
do
#
# Script im Logfile festhalten
#
   echo -e "\n ------------------------------ \n $step \n ------------------------------ \n" | tee -a $LOGFILE
#
# Anzeige Fortschritt; die ersten drei Ziffern geben Fortschritt in %
#
   stepname=$(basename "$step")
   echo "${stepname:0:3}"
   echo "# $step"
#
#  Ausführen ohne Log, da sonst im Hintergrund gestartete Tasks hängenbleiben; 
#  das Log wird im Script selbst geschrieben
#
   "$step"
#
# Anzeige des aktuellen Skriptes; 2 s Pause dafür
#
   sleep 2

done | zenity --progress --title="Running setup.sh" --width=650 --text="starting..." --percentage=0  --auto-close
