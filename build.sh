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
    OPENSSL_URL="https://raw.githubusercontent.com/x2on/OpenSSL-for-iPhone/master/build-libssl.sh"
    OPENSSL_SH="${OPENSSL_DIR}/build-libssl.sh"

    download ${OPENSSL_URL} ${OPENSSL_SH}

    if [ ! -f "${OPENSSL_DIR}/lib/libssl.a" ]; then
        pushd . > /dev/null
        cd ${OPENSSL_DIR}
        /bin/sh ${OPENSSL_SH}
        popd > /dev/null
    else
        echo "Using OpenSSL..."
    fi

    OPENSSL_ENABLED=1
}

# openh264
OPENH264_DIR="${BUILD_DIR}/openh264"
OPENH264_ENABLED=
function openh264() {
    if [ ! -f "${OPENH264_DIR}/lib/libopenh264.a" ] || [ ! -d "${OPENH264_DIR}/include/wels/" ]; then
        "${__DIR__}/openh264.sh" "${OPENH264_DIR}"
    else
        echo "Using OpenH264..."
    fi

    OPENH264_ENABLED=1
}

PJSIP_DIR="${BUILD_DIR}/pjproject"
function pjsip() {
    "${__DIR__}/pjsip.sh" "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-openh264 "${OPENH264_DIR}"
}

openssl
openh264
pjsip
