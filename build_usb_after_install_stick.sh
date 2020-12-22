#!/bin/bash
set -euo pipefail

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# define variables

BUILD_DIR="build/after_install/"
IMAGE_NAME="heyalter_post_install_plain_ubuntu.iso"
VOLUME_NAME="heyalter"
ARTIFACTS_DIR="$(pwd)/artifacts"

export DEBIAN_FRONTEND="noninteractive"
export TZ="Europe/Berlin"


# prepare env

for directory in $BUILD_DIR
do
	if [ ! -e "$directory" ]
	then
		echo creating $directory
		mkdir -p $directory
	fi
done
## install needed software
echo "installing software requirements"
apt update -y && apt-get install -yq snapd snapd debootstrap gparted squashfs-tools genisoimage p7zip-full wget fakeroot fakechroot syslinux-utils

mkdir -p ${BUILD_DIR}/.config/systemd/user/
cp -R files/homeschule/* ${BUILD_DIR}
cp -R usb_after_install/* ${BUILD_DIR}
cp files/homeschule/.config/systemd/user/heyalter.service ${BUILD_DIR}/.config/systemd/user/heyalter.service

chmod +x ${BUILD_DIR}/setup_lokal.sh
chmod +x ${BUILD_DIR}/_install_all_snaps.sh
chown -R 1000:1000 ${BUILD_DIR}/setup_lokal.sh
chmod -R 755 ${BUILD_DIR}/.config/

#snap download chromium --target-directory ${BUILD_DIR}
#mv ${BUILD_DIR}/chromium*.snap ${BUILD_DIR}/chromium.snap
#mv ${BUILD_DIR}/chromium*.assert ${BUILD_DIR}/chromium.assert

# Download Snaps
./_download_snaps.sh ${BUILD_DIR}

chown -R 1000:1000 ${BUILD_DIR}

mkisofs -J -l -R -V "${VOLUME_NAME}" -o ${ARTIFACTS_DIR}/${IMAGE_NAME} ${BUILD_DIR}/
