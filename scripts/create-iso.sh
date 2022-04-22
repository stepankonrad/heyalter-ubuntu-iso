#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh


# source: https://askubuntu.com/questions/1289400/remaster-installation-image-for-ubuntu-20-10/1289505#1289505
log "prepare mbr/gpt"
dd if="$BUILD_DIR/$ISO_FILENAME" bs=1 count=446 of="$BUILD_DIR/mbr.bin"
skip=$(/sbin/fdisk -l "$BUILD_DIR/$ISO_FILENAME" | fgrep '.iso2 ' | awk '{print $2}')
size=$(/sbin/fdisk -l "$BUILD_DIR/$ISO_FILENAME" | fgrep '.iso2 ' | awk '{print $4}')
dd if="$BUILD_DIR/$ISO_FILENAME" bs=512 skip="$skip" count="$size" of="$BUILD_DIR/efi.bin"

log "prepare checksums"
pushd "$ISO_EXTRACTED_DIR"

rm -rf md5sum.txt
find -type f -print0 | xargs -0 md5sum | tee md5sum.txt

log "mkisofs"
chmod -R a+rx,a-w .
find . -type l -delete
xorriso -as mkisofs -r -V "HeyAlter-$CI_COMMIT_SHORT_SHA" -J -l -joliet-long -iso-level 3 -partition_offset 16 --grub2-mbr "../mbr.bin" --mbr-force-bootable -append_partition 2 0xEF "../efi.bin" -appended_part_as_gpt -c /boot.catalog -b /boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info -eltorito-alt-boot -e '--interval:appended_partition_2:all::' -no-emul-boot -o "$ARTIFACTS_DIR/$IMAGE_NAME" .

popd
