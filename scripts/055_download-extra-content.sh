#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

log "Download HEY-HILFE-Support-Handbuch.pdf"
curl https://heyalter.com/wp-content/uploads/2021/02/HEY-HILFE-Support-Handbuch.pdf --output "$ISO_EXTRACTED_DIR/setup/HEY-HILFE-Support-Handbuch.pdf" --fail --location --max-time 60 & 

log "Download Snaps"

for snap2install in core18 core24 chromium teams-for-linux skype discord telegram-desktop
do
    echo download $snap2install
    snap download $snap2install --target-directory "$ISO_EXTRACTED_DIR/setup/snaps"/
    mv "$ISO_EXTRACTED_DIR/setup/snaps"/${snap2install}_*.snap "$ISO_EXTRACTED_DIR/setup/snaps"/${snap2install}.snap
    mv "$ISO_EXTRACTED_DIR/setup/snaps"/${snap2install}_*.assert "$ISO_EXTRACTED_DIR/setup/snaps"/${snap2install}.assert
done

log "Download ata-secure-erase.sh"
SECURE_ERASE_PATH=$ISO_EXTRACTED_DIR/ata-secure-erase.sh
curl https://github.com/TigerOnVaseline/ata-secure-erase/raw/master/ata-secure-erase.sh --output "$SECURE_ERASE_PATH" --fail --location --max-time 60
chmod +x $SECURE_ERASE_PATH
