#!/bin/bash

# Go to the scripts dir, no matter from which current location the script is called from
cd $(dirname "$0")
. env.sh

mkdir -p "$ARTIFACTS_DIR"

# write heyalter-release file
tee "$ARTIFACTS_DIR/$IMAGE_META_NAME" << EOF
BUILD_DATE=$TODAY
BASE_IMAGE_URL=$DOWNLOAD_URL
IMAGE_NAME=$IMAGE_NAME
EOF
env | grep -e CI_PIPELINE_IID \
           -e CI_COMMIT_REF_NAME \
           -e CI_COMMIT_SHORT_SHA \
           -e CI_JOB_URL \
           | tee -a "$ARTIFACTS_DIR/$IMAGE_META_NAME"
