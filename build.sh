#!/bin/bash
set -euo pipefail

# Go to the project dir, no matter from which current location the script is called from
cd $(dirname "$0")

./scripts/create-releasefile.sh
./scripts/install-host-software.sh
./scripts/download-iso.sh
./scripts/extract-iso.sh
./scripts/extract-squashfs.sh
./scripts/install-software.sh
./scripts/copy-files.sh
./scripts/download-extra-content.sh
./scripts/create-squashfs.sh
./scripts/create-iso.sh
