#!/bin/sh

set -e

export BASHSCRIPT="$(realpath "$1")"

# Go to the directory of the script
cd "$(dirname "$(readlink -f "$0")")"

cargo build --release
mv target/release/bashwrapper "$BASHSCRIPT"
