#!/bin/sh

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
	OPENSSL_VERSION="1.1.1b"
	MACOS_MIN_SDK_VERSION="10.12"
	IOS_MIN_SDK_VERSION="9.0"

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

# openh264
#OPENH264_DIR="${BUILD_DIR}/openh264"
#OPENH264_ENABLED=
#function openh264() {
#    if [ ! -f "${OPENH264_DIR}/lib/libopenh264.a" ] || [ ! -d "${OPENH264_DIR}/include/wels/" ]; then
#        "${__DIR__}/openh264.sh" "${OPENH264_DIR}"
#    else
#        echo "Using OpenH264..."
#    fi
#
#    OPENH264_ENABLED=1
#}

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

PJSIP_DIR="${BUILD_DIR}/pjproject"
function pjsip() {
#"${__DIR__}/pjsip.sh" "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-openh264 "${OPENH264_DIR}" --with-opus "${OPUS_DIR}/dependencies"
	"${__DIR__}/pjsip.sh" "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-opus "${OPUS_DIR}/dependencies"
}

openssl
#openh264
opus
pjsip
