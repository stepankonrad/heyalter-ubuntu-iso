#!/bin/bash

set -e

cd /opt/setup/snaps
./_install_all_snaps.sh
touch /opt/setup/setup_done
