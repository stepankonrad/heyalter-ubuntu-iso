#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

# download iso
if [ ! -f "$ISO_FILENAME" ]
then
  log "Downloading ISO from $DOWNLOAD_URL"
  wget --quiet "$DOWNLOAD_URL" -O "$ISO_FILENAME"
fi
