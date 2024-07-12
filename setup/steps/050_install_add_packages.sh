#!/bin/bash
#
# Installation der zus. Softwarepakete wie gimp etc.
#
# ------------------------------------------------------------------------------------
#

logfile="/tmp/install_add_packages_$$.log"

gnome-terminal --wait -- sudo bash -c /opt/APT/install.sh 2>&1 > $logfile 

cat $logfile >> $LOGFILE
