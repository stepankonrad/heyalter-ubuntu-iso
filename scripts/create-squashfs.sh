#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

log "create squashfs"
chmod +w "$ISO_EXTRACTED_DIR/casper/filesystem.manifest"
fakechroot chroot "$SQUASHFS_EXTRACTED_DIR" dpkg-query -W --showformat='${Package} ${Version}\n' > "$ISO_EXTRACTED_DIR/casper/filesystem.manifest"
cp "$ISO_EXTRACTED_DIR/casper/filesystem.manifest" "$ISO_EXTRACTED_DIR/casper/filesystem.manifest-desktop"
sed -i '/ubiquity/d' "$ISO_EXTRACTED_DIR/casper/filesystem.manifest-desktop"
sed -i '/casper/d' "$ISO_EXTRACTED_DIR/casper/filesystem.manifest-desktop"
sed -i '/gparted/d' "$ISO_EXTRACTED_DIR/casper/filesystem.manifest-remove"
rm -f "$ISO_EXTRACTED_DIR/casper/filesystem.squashfs"
mksquashfs "$SQUASHFS_EXTRACTED_DIR" "$ISO_EXTRACTED_DIR/casper/filesystem.squashfs"
printf $(du -sx --block-size=1 ${SQUASHFS_EXTRACTED_DIR} | cut -f1) > "$ISO_EXTRACTED_DIR/casper/filesystem.size"
