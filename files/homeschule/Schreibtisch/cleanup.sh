#!/bin/bash

if [ ! -f /home/schule/setup_done ]
then
zenity --warning --text "Erst setup.sh ausführen!" --width 512
exit 2
fi

rm /home/schule/setup_done
rm /home/schule/*.snap
rm /home/schule/*.assert
rm /home/schule/_install_all_snaps.sh

rm /home/schule/Schreibtisch/setup.sh
rm /home/schule/Schreibtisch/cleanup.sh
