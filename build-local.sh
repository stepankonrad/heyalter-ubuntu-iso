#!/bin/bash

# prepare env vars for image name
apt update && apt install git -y

# we need to put `build` in the container filesystem as unsquashfs throws errors, if it has to work across filesystems
cd /heyalter
mkdir /tmp/build

if [ ! -L /heyalter/build ]
then
	ln -s /tmp/build /heyalter/build
fi

# call the build script
./preset.sh
./build.sh
