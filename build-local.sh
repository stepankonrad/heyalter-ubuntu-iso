#!/bin/bash
#
# remember dir if called from somewhere
#

export bindir=$(dirname "$0")
if [ "$bindir" == "." ]; then
   bindir="$PWD"
fi
#
# make sure it is run by root
#
if [ $UID -ne 0 ]; then
   sudo "$bindir/$0" 
   exit
fi 

#
# install git only if necessary
#
if [ ! -e /usr/bin/git ]; then
   apt update && apt install git -y
fi

#
# define git - related variables here to avoid problems 
# from wrong directory ... 
#
git config --global --add safe.directory $bindir

if [[ ! -v CI_COMMIT_SHORT_SHA ]]; then
   export CI_COMMIT_SHORT_SHA="$(git rev-parse --short HEAD)"
fi
if [[ ! -v CI_COMMIT_REF_NAME ]]; then
   export CI_COMMIT_REF_NAME="$(git branch --show-current)"
fi
if [[ ! -v CI_PIPELINE_IID ]]; then
   export CI_PIPELINE_IID=localbuild
fi
#
# we need these defintions here to be able to cleanup before starting anew
# 
#
export BUILD_DIR="$bindir/build"
export ARTIFACTS_DIR="$bindir/artifacts"
#
# clear all before starting new
#
if [ -d $BUILD_DIR ]; then
   rm -rf $BUILD_DIR
fi

if [ -d "$ARTIFACTS_DIR" ]; then
   rm -rf "$ARTIFACTS_DIR"
fi

mkdir -p $BUILD_DIR

#
# finally call the build script
#

$bindir/build.sh

#
# Addon für meine Testumgebung (Peter)
#

if [ -d /mnt/hgfs/HeyAlter ]; then
   cp "$ARTIFACTS_DIR"/*.iso  /mnt/hgfs/HeyAlter/
fi
 
