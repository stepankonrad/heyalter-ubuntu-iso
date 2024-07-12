#!/bin/bash
#
# Anzeigen der Systemparameter im Hintergrund, dadurch bleibt die Anzeige
# bis zum explizieten Schließen stehen.  
#
# Setze sicherheitshalber Language auf Deutsch 
#
LANG=de_DE.UTF-8
#
# lscpu ist wesentlich schneller als lshw und genausogut, dafür muss jede Information aufbereitet werden
#
CPU=$(lscpu | grep -E "Modellname" | sed -e "s,^.*:  *,,")
MAXTAKT=$(lscpu | grep -E "Maximal" 2>/dev/null | sed -e "s,^.*:  *,Maximaler Takt ," -e "s/,0000$/ MHz/")
if [ -z "$MAXTAKT" ]; then
   MAXTAKT="Maximaler Takt unbekannt"
fi
CORES="Anzahl Kerne $(nproc)"
THREADS=$(lscpu | grep -E "Thread" | sed -e 's,:  *, ,')
  
#
# lsmem zeigt in der vorletzten Zeile den Spreicher an, geht schneller und ohne root als lshw
#
MEM=$(lsmem | tail -2 | head -1 | sed -e "s,Online-,,")

#
# eine "echte" Disk hat immer eine Anzeige 'GB ...' und noch Text dahinter 
#
DISK="$(sudo lshw -quiet -short -c disk | grep 'GB ..')"

#
# Trennstrich aus Geviertstrichen 
#
STRICH="———————————————————————————————————"

#
# Ausgabe mit Pango Markup aufgebrezelt
# siehe https://basic-converter.proboards.com/thread/314/pango-markup-text-examples
# und   https://eccentric.one/misc/pygtk/pygtk2reference/pango-markup-language.html
#
zenity --info --icon=computer --ok-label "Ende der Anzeige" --text \
  "\n<big>$MODELL</big>\n$STRICH\n<b>$CPU</b>\n$MAXTAKT\n$CORES\n$THREADS\n$STRICH\n$MEM\n$STRICH\n$DISK\n$STRICH\n" &

#
# Starten der "Energie" Anzeige ebenfalls im Hintergrund, 
# um den (Lade-)Zustand der Batterie zu monitoren
#
gnome-power-statistics &

echo ""
