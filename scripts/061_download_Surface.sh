#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh


log "Downloading additional Packages"
#
# Erstmal Zielverzeichnis anlegen
#
if [ ! -d "$ISO_EXTRACTED_DIR" ]; then
   echo "Zielverzeichnis <${ISO_EXTRACTED_DIR}> ist nicht vorhanden"
   return 1
fi

mkdir -p "$ISO_EXTRACTED_DIR/APT"

#
# First you need to download the keys and import them 
# but also keep them for the destination system (the Surface Lapto)
#

wget -qO "$ISO_EXTRACTED_DIR/APT/surface.asc" https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc 
gpg --dearmor < "$ISO_EXTRACTED_DIR/APT/surface.asc" | dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg

#
# After this you can add the repository configuration and update APT.
#

echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" > "$ISO_EXTRACTED_DIR/APT/linux-surface.list"
cp "$ISO_EXTRACTED_DIR/APT/linux-surface.list"  /etc/apt/sources.list.d/linux-surface.list
apt update 

SoftwareListe="linux-image-surface linux-headers-surface libwacom-surface iptsd linux-surface-secureboot-mok" 

apt-get install -d -y $SoftwareListe -o Dir::Cache::Archives="$ISO_EXTRACTED_DIR/APT"
