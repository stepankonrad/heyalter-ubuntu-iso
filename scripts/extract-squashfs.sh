#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

log "unsquash squashfs"
rm -R -f "$SQUASHFS_EXTRACTED_DIR"
# No mkdir, as unsquashfs fails, if the dir already exists
unsquashfs -d "$SQUASHFS_EXTRACTED_DIR" "$ISO_EXTRACTED_DIR/casper/filesystem.squashfs"
