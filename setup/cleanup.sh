#!/bin/bash

if [ ! -f /opt/setup/setup_done ]
then
zenity --warning --text "Erst setup.sh ausführen!" --width 512
exit 2
fi

/opt/setup/cleanuproot.sh
