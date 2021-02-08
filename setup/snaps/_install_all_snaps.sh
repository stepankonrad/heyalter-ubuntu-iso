#!/bin/bash

IFS=$'\n'
SNAP_ASSERTS_ARR=($(find . -name "*.assert"))
SNAPS_ARR=($(find . -name "*.snap"))
unset IFS

SNAP_ASSERTS=$(printf "%s " "${SNAP_ASSERTS_ARR[@]}")
SNAPS=$(printf "%s " "${SNAPS_ARR[@]}")

snap ack core.assert
snap install core.snap

snap ack core20.assert
snap install core20.snap

snap ack gnome-3-28-1804.assert
snap install gnome-3-28-1804.snap

for snap2install in $SNAP_ASSERTS
do
	echo snap ack $snap2install
	snap ack $snap2install
done

for snap2install in $SNAPS
do
  if [ $snap2install != "./skype.snap" ]; then
    echo snap install $snap2install
    snap install $snap2install
  fi
done

snap install --classic ./skype.snap
