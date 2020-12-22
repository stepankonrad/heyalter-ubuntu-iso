#!/bin/bash

OUTPUT_DIR=$1

for snap2install in gnome-3-28-1804 chromium teams zoom-client skype discord telegram-desktop
do
	echo download $directory
	snap download $snap2install --target-directory ${OUTPUT_DIR}/
  mv ${OUTPUT_DIR}/$snap2install*.snap ${OUTPUT_DIR}/$snap2install.snap
  mv ${OUTPUT_DIR}/$snap2install*.assert ${OUTPUT_DIR}/$snap2install.assert
done