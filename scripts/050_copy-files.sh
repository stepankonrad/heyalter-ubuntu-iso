#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

log "Copying our $bindir/files to the ISO"
cp $bindir/files/heyalter_*.yaml $ISO_EXTRACTED_DIR 
cp $bindir/files/install_heyalter.sh $ISO_EXTRACTED_DIR 
mv "$ISO_EXTRACTED_DIR/boot/grub/grub.cfg" "$ISO_EXTRACTED_DIR/boot/grub/original_grub.cfg"
cp $bindir/files/grub.cfg "$ISO_EXTRACTED_DIR/boot/grub/grub.cfg"

log "Setup scripts"
cp -R $bindir/setup "$ISO_EXTRACTED_DIR/"

log "Hey Alter release information"
cp "$ARTIFACTS_DIR/$IMAGE_META_NAME" "$ISO_EXTRACTED_DIR/setup/add_files/"

log "copy skeleton & usb_after_install"
cp -R $bindir/files/skeleton "$ISO_EXTRACTED_DIR/"

cp $bindir/usb_after_install/* "$ISO_EXTRACTED_DIR/"
chown 1000:1000 "$ISO_EXTRACTED_DIR/setup_lokal.sh"

