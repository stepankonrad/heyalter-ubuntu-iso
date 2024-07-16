#!/bin/bash
set -euo pipefail

if [ "$EUID" -ne 0 ]
   then echo "Please run as root"
   exit
fi
#
# Version variables to avoid changes in several locations
MAJOR="24"
MINOR="04"
NAME="noble"
VERSION="$MAJOR.$MINOR"
#
DOWNLOAD_URL="https://releases.ubuntu.com/$NAME/ubuntu-$VERSION-desktop-amd64.iso"
ISO_EXTRACTED_DIR="$BUILD_DIR/extracted-iso"
ISO_MOUNT_DIR="$BUILD_DIR/extracted-iso"
SQUASHFS_EXTRACTED_DIR="$BUILD_DIR/squashfs"
TODAY="$(date +'%Y%m%d')"
ISO_FILENAME="/var/tmp/ubuntu-$VERSION.iso"
ISO_VOLUME_ID="heyalter-$TODAY-$CI_PIPELINE_IID"
IMAGE_NAME="heyalter-$CI_COMMIT_REF_NAME-$TODAY-b$CI_PIPELINE_IID-$CI_COMMIT_SHORT_SHA.iso"
IMAGE_META_NAME="${IMAGE_NAME/\.iso/.release.txt}"
BUILDINFO_LOG="$ARTIFACTS_DIR/buildinfo.log"

export DEBIAN_FRONTEND="noninteractive"
export TZ="Europe/Berlin"

log () {
  delimiter="##############################################"
  printf "\n\n${delimiter}\n $1 \n${delimiter}\n"
}

