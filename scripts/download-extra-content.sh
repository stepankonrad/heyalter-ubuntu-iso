#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh


log "Download Snaps"
./_download_snaps.sh "$ISO_EXTRACTED_DIR/setup/snaps"

log "Download HEY-HILFE-Support-Handbuch.pdf"
curl https://heyalter.com/wp-content/uploads/2021/02/HEY-HILFE-Support-Handbuch.pdf --output "$ISO_EXTRACTED_DIR/setup/HEY-HILFE-Support-Handbuch.pdf" --fail --location --max-time 60

log "Download ata-secure-erase.sh"
curl https://github.com/TigerOnVaseline/ata-secure-erase/raw/master/ata-secure-erase.sh --output "$ISO_EXTRACTED_DIR/setup/ata-secure-erase.sh" --fail --location --max-time 60