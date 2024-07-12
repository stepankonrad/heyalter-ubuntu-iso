#!/bin/bash
#
# Update usw. soll in Terminal laufen mit root-Rechten
#

# ------------------------------------------------------------------------------------
#
# cleanup alternatives
#

for l in $(ls /etc/alternatives | grep -v ".gz" )
do
    sudo update-alternatives --auto $l 2>&1 | tee -a $LOGFILE
done

