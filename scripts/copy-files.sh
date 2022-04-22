#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh


log "Add our own Grub configuration"
cp files/grubdefault "$SQUASHFS_EXTRACTED_DIR/etc/default/grub"

log "Copying our files to the ISO"
cp files/preseed/* "$ISO_EXTRACTED_DIR/preseed/"
rm -f "$ISO_EXTRACTED_DIR/boot/grub/grub.cfg"
cp files/grub.cfg "$ISO_EXTRACTED_DIR/boot/grub/grub.cfg"

log "Homedir"
rm -R -f "$SQUASHFS_EXTRACTED_DIR/home/schule"
cp -R files/homeschule "$SQUASHFS_EXTRACTED_DIR/home/schule"
chown -R 1000:1000 "$SQUASHFS_EXTRACTED_DIR/home/schule"
chmod -R 755 "$SQUASHFS_EXTRACTED_DIR/home/schule/.config/"

log "Dconf configuration"
cp files/dconfprofileuser "$SQUASHFS_EXTRACTED_DIR/etc/dconf/profile/user"
rm -R -f "$SQUASHFS_EXTRACTED_DIR/etc/dconf/db/local.d"
cp -R files/local.d "$SQUASHFS_EXTRACTED_DIR/etc/dconf/db/local.d"
fakechroot chroot "$SQUASHFS_EXTRACTED_DIR" dconf update

log "Hey Alter release information"
cp "$ARTIFACTS_DIR/$IMAGE_META_NAME" "$SQUASHFS_EXTRACTED_DIR/etc/heyalter-release"

log "Setup scripts"
cp -R setup "$ISO_EXTRACTED_DIR/"
./tools/bashwrapper/convert.sh "$ISO_EXTRACTED_DIR/setup/setuproot.sh"
./tools/bashwrapper/convert.sh "$ISO_EXTRACTED_DIR/setup/cleanuproot.sh"
./tools/bashwrapper/convert.sh "$ISO_EXTRACTED_DIR/setup/54KernelDebs/changeTo54KernelOffline.sh"
git clone https://gitli.stratum0.org/heyalter/desktop-mainline-kernel.git "$ISO_EXTRACTED_DIR/setup/desktop-mainline-kernel"
rm -fR "$ISO_EXTRACTED_DIR/setup/desktop-mainline-kernel/.git"

log "Persistent HA directory"
cp -R heyalter "$ISO_EXTRACTED_DIR/"

log "After Install Script"
cp -R files/homeschule "$ISO_EXTRACTED_DIR/"

cp usb_after_install/* "$ISO_EXTRACTED_DIR"
chown 1000:1000 "$ISO_EXTRACTED_DIR/setup_lokal.sh"
