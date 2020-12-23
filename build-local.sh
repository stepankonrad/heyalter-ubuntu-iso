#!/bin/bash

# prepare commit sha env var
apt update && apt install git -y
export CI_COMMIT_SHORT_SHA="$(git rev-parse --short HEAD)"

# we need to put `build` in the container flesystem  as unsquashfs throws errors, if it has to work across filesystems
cd /heyalter
mkdir /tmp/build

if [ ! -L /heyalter/build ]
then
	ln -s /tmp/build /heyalter/build
fi

# call the build script
./build.sh

#cleanup
rm -r /tmp/build
