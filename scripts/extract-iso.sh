#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

# extract iso
rm -R -f "$ISO_EXTRACTED_DIR"
mkdir -p "$ISO_EXTRACTED_DIR"
log "Extract iso to $ISO_EXTRACTED_DIR"
7z x -o"$ISO_EXTRACTED_DIR" "$BUILD_DIR/$ISO_FILENAME"
rm -R -f "$BUILD_DIR/$ISO_FILENAME"
