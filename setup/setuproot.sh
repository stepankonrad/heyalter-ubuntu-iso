#!/bin/bash

set -e

# Fix update-alternative symlinks which get broken when installing software in chroot
for l in $(ls /etc/alternatives)
do
	update-alternatives --auto $l || true
done

cd /opt/setup/snaps
./_install_all_snaps.sh
touch /opt/setup/setup_done
