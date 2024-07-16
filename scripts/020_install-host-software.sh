#!/bin/bash
#

. scripts/env.sh

## install needed software
log "installing software requirements"
sudo apt-get update -y
sudo apt-get install -yq apt-rdepends git curl snapd debootstrap gparted squashfs-tools genisoimage p7zip-full wget fakechroot syslinux-utils xorriso fdisk
log "end install"
