#!/bin/bash

# prepare env vars for image name
apt update && apt install git -y
export CI_COMMIT_SHORT_SHA="$(git rev-parse --short HEAD)"
export CI_COMMIT_REF_NAME="$(git branch --show-current)"
export CI_PIPELINE_IID="localbuild"

# we need to put `build` in the container filesystem as unsquashfs throws errors, if it has to work across filesystems
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
