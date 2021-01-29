#!/bin/bash


# offline Kernel 5.4 Installation

LOG="$HOME/.heyalter_switch_to_mainline_kernel.log"

log () {
    DELIMITER='######################'
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}${DELIMITER} ${1} ${DELIMITER}${NC}\n"
    echo "${GREEN}${DELIMITER} ${1} ${DELIMITER}${NC}\n" >> $2
}


log "Mainline Kernel Meta-Paket installieren - offline" $LOG

sudo dpkg -i *.deb

log "HWE kernel Met-Paket Und Kernel entfernen" $LOG
BUGGY_KERNELS=`dpkg -l | grep "^ii" | grep -e linux-image-5.8 -e linux-image-unsigned-5.8 | awk '{print $2}'`
sudo apt remove -y --no-upgrade --fix-missing linux-image-generic-hwe-20.04 $BUGGY_KERNELS 2>&1 | tee -a $LOG

# (DM) in the previous step while unsinstaling the buggy kernels an additional
# unsigned 5.8 kernel get installed. I have no idea how to avoid this...
log "Unsigned Kernel Pakete entfernen" $LOG
BUGGY_KERNELS=`dpkg -l | grep "^ii" | grep -e linux-image-5.8 -e linux-image-unsigned-5.8 | awk '{print $2}'`
sudo apt remove -y --no-upgrade --fix-missing $BUGGY_KERNELS 2>&1 | tee -a $LOG

log "Nicht mehr benötigte Pakete entfernen" $LOG
sudo apt autoremove -y 2>&1 | tee -a $LOG

sudo reboot now
