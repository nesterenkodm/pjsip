#!/bin/sh

# environment variables
export OPENSSL_VERSION="1.1.1c" # specify the openssl version to use
export PJSIP_VERSION="2.9" # specifiy the pjsip version to use
export OPUS_VERSION="1.3.1" # specify the opus version to use
export MACOS_MIN_SDK_VERSION="10.12"
export IOS_MIN_SDK_VERSION="9.0"
export ZRTP4PJ_SOURCE="https://github.com/welljsjs/ZRTP4PJ" # specify the zrtp4pj source
export ZRTP_SOURCE="/Users/juliusschmidt/Documents/Xcode/ZRTPCPP" # specify the zrtp source

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

# zrtp
ZRTP_DIR="${BUILD_DIR}/zrtp4pj"
ZRTP_ENABLED=
function zrtp() {
	"${__DIR__}/zsrtp.sh" "${ZRTP_DIR}"
	echo "Using ZRTP..."

	ZRTP_ENABLED=1
}

# pjsip
PJSIP_DIR="${BUILD_DIR}/pjproject"
PJSIP_URL="http://www.pjsip.org/release/${PJSIP_VERSION:-2.9}/pjproject-${PJSIP_VERSION:-2.9}.tar.bz2"
function pjsip() {
	"${__DIR__}/pjsip.sh" "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-opus "${OPUS_DIR}/dependencies" --with-zrtp "${ZRTP_DIR}"
}

# First, download (and unpack) pjsip.
# This is a change and useful because following scripts are therefore able to modify
# the content of pjsip, e.g. adding custom third-party libraries.
download "${PJSIP_URL}" "${PJSIP_DIR}/src"

openssl
opus
zrtp
pjsip
