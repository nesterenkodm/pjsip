#!/bin/sh

# see http://stackoverflow.com/a/3915420/318790
function realpath { echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }
__FILE__=`realpath "$0"`
__DIR__=`dirname "${__FILE__}"`

BASEDIR_PATH="$1"
TARGET_URL="https://github.com/cisco/openh264/archive/v1.7.0.zip"
TARGET_PATH="${BASEDIR_PATH}/src"

# download
function download() {
    "${__DIR__}/download.sh" "$1" "$2" #--no-cache
}

# fix for https://github.com/chebur/pjsip/issues/19
HEADERS_DIR="${BASEDIR_PATH}/include/wels"
if [ -d "${HEADERS_DIR}" ]; then
    rm -rf "${HEADERS_DIR}"
fi
mkdir -p "${HEADERS_DIR}"

# build
function build() {
    ARCH="$1"
    MAKEFILE="${TARGET_PATH}/Makefile"
    MAKEFILE_BAK="${TARGET_PATH}/Makefile.bak"
    PREFIX="${BASEDIR_PATH}/build/${ARCH}"
    LOG="${PREFIX}/build.log"

    pushd . > /dev/null
    cd "${TARGET_PATH}"

    if [ -d "${PREFIX}" ]; then
        rm -rf ${PREFIX}
    fi
    mkdir -p ${PREFIX}

    echo "Builing for ${ARCH}..."

    cp "${MAKEFILE}" "${MAKEFILE_BAK}"

    SED_SRC="^PREFIX=.*"
    SED_DST="PREFIX=${PREFIX}"
    SED_DST="${SED_DST//\//\\/}"
    sed -i.deleteme "s/${SED_SRC}/${SED_DST}/" "${MAKEFILE}"
    rm ${MAKEFILE}.deleteme

    make OS=ios ARCH=${ARCH} SDK_MIN=8.0 V=No >> "${LOG}"
    make OS=ios ARCH=${ARCH} SDK_MIN=8.0 V=No install >> "${LOG}"
    make OS=ios ARCH=${ARCH} SDK_MIN=8.0 V=No clean >> "${LOG}"

    popd > /dev/null

    mv "${MAKEFILE_BAK}" "${MAKEFILE}"
}

# lipo
function lipo() {
    echo "Lipo libs to ${BASEDIR_PATH}/lib..."

    ARGS=""
    while [ $# -gt 0 ]; do
        ARCH=$1
        ARGS="${ARGS} -arch ${ARCH} ${BASEDIR_PATH}/build/${ARCH}/lib/libopenh264.a"
        shift
    done

    if [ ! -d "${BASEDIR_PATH}/lib" ]; then
        mkdir -p "${BASEDIR_PATH}/lib"
    fi

    xcrun -sdk iphoneos lipo ${ARGS} -create -output "${BASEDIR_PATH}/lib/libopenh264.a"
}

function headers() {
    ARCH=$1
    echo "Copying headers to ${BASEDIR_PATH}/include..."

    cp -R "${BASEDIR_PATH}/build/${ARCH}/include/" "${BASEDIR_PATH}/include/"
}

download ${TARGET_URL} ${TARGET_PATH}
build armv7 && build armv7s && build arm64 && build i386 && build x86_64
lipo armv7 armv7s arm64 i386 x86_64
headers arm64
