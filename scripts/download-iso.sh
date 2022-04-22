#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

mkdir -p "$BUILD_DIR"

# download iso
if [ ! -f "$BUILD_DIR/$ISO_FILENAME" ]
then
  log "Downloading ISO from $DOWNLOAD_URL"
  wget --quiet "$DOWNLOAD_URL" -O "$BUILD_DIR/$ISO_FILENAME"
fi
