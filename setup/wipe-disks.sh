#!/bin/bash

# enumerate all devices
USBDEV_LIST="$(mktemp)"
list-devices usb-partition | sed "s/\(.*\)./\1/" > "$USBDEV_LIST"
NUM_DISKS="$(list-devices disk | grep -vf "$USBDEV_LIST" | wc -l)"

. /usr/share/debconf/confmodule
if [ $NUM_DISKS -ne 1 ]; then

  cat > /tmp/numdisks.template <<'!EOF!'
Template: wipe-disks/numdisks
Type: error
Description: Fehler: Anzahl der installierten Disks = $NUM_DISKS
 Es muss genau eine Disk verfügbar sein. Installierte Disks:
 $(list-devices disk)
!EOF!

  debconf-loadtemplate wipe-disks /tmp/numdisks.template

  while [ 1 ]; do
    db_input critical wipe-disks/numdisks || true
    db_go
    db_get wipe-disks/numdisks
  done
fi

BOOTDEV="$(list-devices disk | grep -vf "$USBDEV_LIST" | head -n 1)"
case "$BOOTDEV" in 
  *nvme*)
    # wipe NVMe devices
    nvme format --ses=1 --force $BOOTDEV;;
  *)
    # wipe ATA devices
    /*/*/ata-secure-erase.sh -f $BOOTDEV;;
esac
if [ $? -ne 0 ]; then

  cat > /tmp/fallback.template <<'!EOF!'
Template: wipe-disks/fallback
Type: error
Description: Fehler: Secure Erase nicht durchgeführt!
 Fallback auf nwipe
!EOF!

  debconf-loadtemplate wipe-disks /tmp/fallback.template

  while [ 1 ]; do
    db_input critical wipe-disks/fallback || true
    db_go
    db_get wipe-disks/fallback
  done

  # fallback to nwipe
  nwipe -m zero --nogui --autonuke $BOOTDEV
fi

# finally ensure every disk was wiped
nwipe -m verify --nogui --autonuke $BOOTDEV

debconf-set partman-auto/disk "$BOOTDEV";
debconf-set grub-installer/bootdev "$BOOTDEV";