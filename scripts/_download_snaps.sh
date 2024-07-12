#!/bin/bash

OUTPUT_DIR=$1

for snap2install in core18 core24 chromium teams-for-linux skype discord telegram-desktop
do
    echo download $directory
    snap download $snap2install --target-directory ${OUTPUT_DIR}/
    mv ${OUTPUT_DIR}/${snap2install}_*.snap ${OUTPUT_DIR}/${snap2install}.snap
    mv ${OUTPUT_DIR}/${snap2install}_*.assert ${OUTPUT_DIR}/${snap2install}.assert
done
