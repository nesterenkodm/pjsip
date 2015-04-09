#!/bin/sh

# see http://stackoverflow.com/a/3915420/318790
function realpath { echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }

BASEDIR_PATH="$1"
TARGET_URL="https://github.com/asynnestvedt/libyuv-ios/archive/master.zip"
TARGET_PATH="${BASEDIR_PATH}"

# download
function download() {
    `realpath "download.sh"` "$1" "$2" #--no-cache
}

download ${TARGET_URL} ${TARGET_PATH}