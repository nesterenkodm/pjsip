#!/bin/sh

# see http://stackoverflow.com/a/3915420/318790
function realpath { echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }

BUILD_DIR=$(realpath "build")
if [ ! -d ${BUILD_DIR} ]; then
    mkdir ${BUILD_DIR}
fi

# download
function download() {
    `realpath "download.sh"` "$1" "$2" #--no-cache
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
    if [ ! -f "${OPENH264_DIR}/lib/libopenh264.a" ]; then
        `realpath "openh264.sh"` "${OPENH264_DIR}"
    else
        echo "Using OpenH264..."
    fi

    OPENH264_ENABLED=1
}

# libyuv
LIBYUV_DIR="${BUILD_DIR}/libyuv"
LIBYUV_ENABLED=
function libyuv() {
    if [ ! -f "${LIBYUV_DIR}/lib/libyuv.a" ]; then
        `realpath "libyuv.sh"` "${LIBYUV_DIR}"
    else
        echo "Using libyuv..."
    fi

    LIBYUV_ENABLED=1
}


PJSIP_DIR="${BUILD_DIR}/pjproject"
function pjsip() {
    if [[ ${LIBYUV_ENABLED} ]]; then
        `realpath "pjsip.sh"` "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-openh264 "${OPENH264_DIR}" --with-libyuv "${LIBYUV_DIR}"
    else
        `realpath "pjsip.sh"` "${PJSIP_DIR}" --with-openssl "${OPENSSL_DIR}" --with-openh264 "${OPENH264_DIR}"
    fi
}

openssl
openh264
#libyuv
pjsip
