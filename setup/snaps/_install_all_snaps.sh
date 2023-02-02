#!/bin/bash

snap ack core.assert
snap install core.snap

snap ack core18.assert
snap install core18.snap

snap ack core20.assert
snap install core20.snap

snap ack core22.assert
snap install core22.snap

snap ack gnome-3-28-1804.assert
snap install gnome-3-28-1804.snap

snap ack gnome-3-38-2004.assert
snap install gnome-3-38-2004.snap

snap ack gnome-42-2204.assert
snap install gnome-42-2204.snap

snap ack cups.assert
snap install cups.snap

# set arrays with all available snaps
mapfile -d '' SNAP_ASSERTS_ARR < <(find . -name "*.assert" -print0)
mapfile -d '' SNAPS_ARR < <(find . -name "*.snap" -print0)

for snap2install in "${SNAP_ASSERTS_ARR[@]}"
do
    if ! snap list $( basename $snap2install .assert ) &> /dev/null
    then   
	echo snap ack $snap2install
	snap ack $snap2install
    fi
done

snap install --classic ./skype.snap

for snap2install in "${SNAPS_ARR[@]}"
do
    if ! snap list $( basename $snap2install .snap ) &> /dev/null
    then   
	echo snap install $snap2install
	snap install $snap2install
    fi
done

