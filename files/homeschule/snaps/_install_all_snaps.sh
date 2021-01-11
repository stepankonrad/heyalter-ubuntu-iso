#!/bin/bash

IFS=$'\n'
SNAP_ASSERTS_ARR=($(find . -name "*.assert"))
SNAPS_ARR=($(find . -name "*.snap"))
unset IFS

SNAP_ASSERTS=$(printf "%s " "${SNAP_ASSERTS_ARR[@]}")
SNAPS=$(printf "%s " "${SNAPS_ARR[@]}")

sudo snap ack core.assert
sudo snap install core.snap

sudo snap ack core20.assert
sudo snap install core20.snap

sudo snap ack gnome-3-28-1804.assert
sudo snap install gnome-3-28-1804.snap

for snap2install in $SNAP_ASSERTS
do
	echo snap ack $snap2install
	sudo snap ack $snap2install
done

for snap2install in $SNAPS
do
	echo snap install $snap2install
	sudo snap install $snap2install
done

sudo snap install --classic ./skype.snap
