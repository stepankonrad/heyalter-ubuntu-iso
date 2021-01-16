#!/bin/bash
set -euo pipefail

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# define variables

OUTPUT_FILENAME="output.iso"
#DOWNLOAD_URL="https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-desktop-amd64.iso"
DOWNLOAD_URL="https://cdimage.ubuntu.com/focal/daily-live/20210116/focal-desktop-amd64.iso" #Daily build with 5.8 kernel
BUILD_DIR="build"
ISO_EXTRACTED_DIR="${BUILD_DIR}/extracted-iso"
ISO_MOUNT_DIR="${BUILD_DIR}/extracted-iso"
SQUASHFS_EXTRACTED_DIR="${BUILD_DIR}/squashfs"
ISO_FILENAME="cached/20210116_focal-desktop-amd64.iso"
IMAGE_NAME="ubuntu-20.04.1-${CI_COMMIT_SHORT_SHA}.iso"
ARTIFACTS_DIR="$(pwd)/artifacts"

export DEBIAN_FRONTEND="noninteractive"
export TZ="Europe/Berlin"




# prepare env

for directory in $BUILD_DIR $ISO_EXTRACTED_DIR $ISO_MOUNT_DIR cached/ artifacts/
do
	if [ ! -e "$directory" ]
	then
		echo creating $directory
		mkdir $directory
	fi
done
## install needed software
echo "installing software requirements"
apt update -y && apt-get install -yq snapd debootstrap gparted squashfs-tools genisoimage p7zip-full wget fakeroot fakechroot syslinux-utils
## download iso
if [ ! -f "${ISO_FILENAME}" ]
then
	echo "Downloading ISO from $DOWNLOAD_URL"
	wget --quiet $DOWNLOAD_URL -O ${ISO_FILENAME}
fi


## extract iso
echo "Extract iso to $ISO_EXTRACTED_DIR"
7z x -o$ISO_EXTRACTED_DIR ${ISO_FILENAME}


echo "unsquash squashfs"
fakeroot unsquashfs -d ${SQUASHFS_EXTRACTED_DIR} ${ISO_EXTRACTED_DIR}/casper/filesystem.squashfs
#
# rm -rf ${SQUASHFS_EXTRACTED_DIR}/{run,dev,proc,sys}
#
# echo "prepare bind mounts for chroot env"
# ln -s /run/ ${SQUASHFS_EXTRACTED_DIR}/
# ln -s /dev/ ${SQUASHFS_EXTRACTED_DIR}/
#
# ln -s /proc ${SQUASHFS_EXTRACTED_DIR}/
# ln -s /sys ${SQUASHFS_EXTRACTED_DIR}/
# #ln -s /dev/pts ${SQUASHFS_EXTRACTED_DIR}/dev/
#
echo "installing software inside chroot"
fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} add-apt-repository -y universe
fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} add-apt-repository -y multiverse
fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} apt update -y
fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} apt install -y gimp vlc mumble enigmail keepass2 # geogebra inkscape krita geogebra obs-studio  audacity  geany openscad pwgen sl gawk mawk
fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} apt clean
#
#
#
# echo "cleanup needed before creating the squashfs"
# fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} apt clean
# rm -rf ${SQUASHFS_EXTRACTED_DIR}/tmp/* ${SQUASHFS_EXTRACTED_DIR}/root/.bash_history
# rm -rf ${SQUASHFS_EXTRACTED_DIR}/{run,dev,proc,sys}
# mkdir ${SQUASHFS_EXTRACTED_DIR}/{run,dev,proc,sys}


cp files/preseed/* ${ISO_EXTRACTED_DIR}/preseed/
cp files/isolinux.cfg ${ISO_EXTRACTED_DIR}/isolinux/isolinux.cfg

mkdir -p ${SQUASHFS_EXTRACTED_DIR}/home/schule/.config/systemd/user/
cp -R files/homeschule/* ${SQUASHFS_EXTRACTED_DIR}/home/schule/
cp files/homeschule/.config/gnome-initial-setup-done ${SQUASHFS_EXTRACTED_DIR}/home/schule/.config/gnome-initial-setup-done
cp files/homeschule/.config/systemd/user/heyalter.service ${SQUASHFS_EXTRACTED_DIR}/home/schule/.config/systemd/user/heyalter.service
mkdir -p ${SQUASHFS_EXTRACTED_DIR}/home/schule/snaps/
cp files/homeschule/snaps/_install_all_snaps.sh ${SQUASHFS_EXTRACTED_DIR}/home/schule/snaps/_install_all_snaps.sh


ls -la ${SQUASHFS_EXTRACTED_DIR}/home/schule/
ls -la ${SQUASHFS_EXTRACTED_DIR}/home/schule/.config/systemd/
ls -la ${SQUASHFS_EXTRACTED_DIR}/home/schule/.config/systemd/user/
chmod +x ${SQUASHFS_EXTRACTED_DIR}/home/schule/Schreibtisch/setup.sh
chmod +x ${SQUASHFS_EXTRACTED_DIR}/home/schule/Schreibtisch/cleanup.sh
chmod +x ${SQUASHFS_EXTRACTED_DIR}/home/schule/snaps/_install_all_snaps.sh
chmod -R 755 ${SQUASHFS_EXTRACTED_DIR}/home/schule/.config/

#After Install Script
mkdir -p ${ISO_EXTRACTED_DIR}/homeschule/.config/systemd/user/
cp files/homeschule/.config/systemd/user/heyalter.service ${ISO_EXTRACTED_DIR}/homeschule/.config/systemd/user/heyalter.service

mkdir -p ${ISO_EXTRACTED_DIR}/homeschule/Bilder/
cp -R files/homeschule/Bilder/* ${ISO_EXTRACTED_DIR}/homeschule/Bilder/

cp usb_after_install/* ${ISO_EXTRACTED_DIR}
chmod +x ${ISO_EXTRACTED_DIR}/setup_lokal.sh
chown -R 1000:1000 ${ISO_EXTRACTED_DIR}/setup_lokal.sh

# Download Snaps
mkdir -p ${ISO_EXTRACTED_DIR}/snaps
./_download_snaps.sh ${ISO_EXTRACTED_DIR}/snaps
cp -R ${ISO_EXTRACTED_DIR}/snaps/* ${SQUASHFS_EXTRACTED_DIR}/home/schule/snaps/
cp files/homeschule/snaps/_install_all_snaps.sh ${ISO_EXTRACTED_DIR}/snaps/_install_all_snaps.sh

chown -R 1000:1000 ${SQUASHFS_EXTRACTED_DIR}/home/schule/

chmod +w ${ISO_EXTRACTED_DIR}/casper/filesystem.manifest
fakeroot fakechroot chroot ${SQUASHFS_EXTRACTED_DIR} dpkg-query -W --showformat='${Package} ${Version}\n' > ${ISO_EXTRACTED_DIR}/casper/filesystem.manifest
cp ${ISO_EXTRACTED_DIR}/casper/filesystem.manifest ${ISO_EXTRACTED_DIR}/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' ${ISO_EXTRACTED_DIR}/casper/filesystem.manifest-desktop
sed -i '/casper/d' ${ISO_EXTRACTED_DIR}/casper/filesystem.manifest-desktop
rm ${ISO_EXTRACTED_DIR}/casper/filesystem.squashfs
mksquashfs ${SQUASHFS_EXTRACTED_DIR} ${ISO_EXTRACTED_DIR}/casper/filesystem.squashfs
printf $(du -sx --block-size=1 ${SQUASHFS_EXTRACTED_DIR} | cut -f1) > ${ISO_EXTRACTED_DIR}/casper/filesystem.size

pushd ${ISO_EXTRACTED_DIR}
rm -rf md5sum.txt
find -type f -print0 | xargs -0 md5sum | grep -v isolinux/boot.cat | tee md5sum.txt

fakeroot mkisofs -D -r -V "${IMAGE_NAME}" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ${ARTIFACTS_DIR}/${IMAGE_NAME} .

isohybrid ${ARTIFACTS_DIR}/${IMAGE_NAME}
