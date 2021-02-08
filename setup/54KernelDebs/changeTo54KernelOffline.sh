#!/bin/bash


# offline Kernel 5.4 Installation

LOG="/opt/setup/.heyalter_switch_to_mainline_kernel.log"

log () {
    DELIMITER='######################'
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}${DELIMITER} ${1} ${DELIMITER}${NC}\n"
    echo "${GREEN}${DELIMITER} ${1} ${DELIMITER}${NC}\n" >> $2
}


log "Mainline Kernel Meta-Paket installieren - offline" $LOG

# Go to the directory of the script
cd "$(dirname "$(readlink -f "$0")")"

dpkg -i *.deb 2>&1 | tee -a $LOG

purge() {
	PKG=`dpkg -l $1 | grep -E "^(u|i|h|r|p)(c|H|U|F|W|t|i)" | awk '{print $2}'`
	if [ ! -z "$PKG" ]; then
		dpkg -P "$PKG" 2>&1 | tee -a $LOG
	fi
}

log "HWE kernel Meta-Paket Und Kernel entfernen" $LOG
rm -f /var/lib/dpkg/info/linux-image-{,unsigned-}5.8*.prerm
purge linux-generic-hwe-20.04
purge linux-image-generic-hwe-20.04
purge linux-modules-extra-5.8*
purge linux-image-5.8*
purge linux-image-unsigned-5.8*
purge linux-modules-5.8*
purge linux-headers-generic-hwe-20.04
purge linux-headers-5.8*
purge linux-hwe-5.8-headers**

log "Nicht mehr benötigte Pakete entfernen" $LOG
apt autoremove -y 2>&1 | tee -a $LOG

reboot now
