#!/bin/bash

# prepare env vars for image name
apt update && apt install git -y

# we need to put `build` in the container filesystem as unsquashfs throws errors, if it has to work across filesystems
 sudo mkdir -p /heyalter
sudo  cd /heyalter
sudo mkdir /tmp/build

if [ ! -L /heyalter/build ]
then
	sudo  ln -s /tmp/build /heyalter/build
fi

# call the build script
sudo  ./preset.sh
sudo ./build.sh
