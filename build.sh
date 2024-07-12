#!/bin/bash
set -euo pipefail

# Go to the project dir, no matter from which current location the script is called from
cd $(dirname "$0")

scripts=$(ls -1 ./scripts/[0-9][0-9][0-9]*.sh)

for script in $scripts
do
    echo "Starte $script"
    $script
    echo "Ende $script"
done
