CI_COMMIT_SHORT_SHA="$(git rev-parse --short HEAD)"
IMAGE_NAME="ubuntu-20.04.1-${CI_COMMIT_SHORT_SHA}.iso"
IMAGE_PATH="$(pwd)/artifacts/${IMAGE_NAME}"

make -C virtualbox boot IMAGE=${IMAGE_PATH}
