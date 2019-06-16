#!/bin/sh

# environment variables
export OPENSSL_VERSION="1.1.1c" # specify the openssl version to use
export PJSIP_VERSION="2.9"
export OPUS_VERSION="1.3.1"
export MACOS_MIN_SDK_VERSION="10.12"
export IOS_MIN_SDK_VERSION="9.0"

# see http://stackoverflow.com/a/3915420/318790
function realpath { echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }
__FILE__=`realpath "$0"`
__DIR__=`dirname "${__FILE__}"`

BUILD_DIR="${__DIR__}/build"
if [ ! -d ${BUILD_DIR} ]; then
    mkdir ${BUILD_DIR}
fi

# download
function download() {
    "${__DIR__}/download.sh" "$1" "$2" #--no-cache
}

# openssl
OPENSSL_DIR="${BUILD_DIR}/openssl"
OPENSSL_ENABLED=
function openssl() {
    if [ ! -d "${OPENSSL_DIR}/lib/iOS" ] || [ ! -d "${OPENSSL_DIR}/lib/macOS" ]; then
        if [ ! -d "${OPENSSL_DIR}" ]; then
            mkdir -p "${OPENSSL_DIR}"
        fi
        "${__DIR__}/openssl/openssl.sh" "--version=${OPENSSL_VERSION}" "--reporoot=${OPENSSL_DIR}" "--macos-min-sdk=${MACOS_MIN_SDK_VERSION}" "--ios-min-sdk=${IOS_MIN_SDK_VERSION}"
    else
        echo "Using OpenSSL..."
    fi
    
    OPENSSL_ENABLED=1
}

# opus
OPUS_DIR="${BUILD_DIR}/opus"
OPUS_ENABLED=
function opus() {
    if [ ! -f "${OPUS_DIR}/dependencies/lib/libopus.a" ] || [ ! -d "${OPUS_DIR}/dependencies/include/opus/" ]; then
        "${__DIR__}/opus.sh" "${OPUS_DIR}"
    else
        echo "Using OPUS..."
    fi
    
    OPUS_ENABLED=1
}

# pjsip
PJSIP_DIR="${BUILD_DIR}/pjproject"
function pjsip() {
    "${__DIR__}/pjsip.sh" "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-opus "${OPUS_DIR}/dependencies"
}

openssl
opus
pjsip
