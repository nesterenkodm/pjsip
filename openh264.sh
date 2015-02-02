#!/bin/sh

# see http://stackoverflow.com/a/3915420/318790
function realpath { echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }

BUILD_DIR=$(realpath "build")
if [ ! -d ${BUILD_DIR} ]; then
    mkdir ${BUILD_DIR}
fi

BASEDIR_PATH="${BUILD_DIR}/openh264"
TARGET_URL="https://github.com/cisco/openh264/archive/v1.3.1.zip"
TARGET_PATH="${BASEDIR_PATH}/src"

# download
function download() {
    `realpath "download.sh"` "$1" "$2" #--no-cache
}

# build
function build() {
    ARCH="$1"
    MAKEFILE="${TARGET_PATH}/Makefile"
    MAKEFILE_BAK="${TARGET_PATH}/Makefile.bak"
    PREFIX="${BASEDIR_PATH}/build/${ARCH}"

    pushd . > /dev/null
    cd "${TARGET_PATH}"

    if [ -d "${PREFIX}" ]; then
        rm -rf ${PREFIX}
    fi

    echo "Builing for ${ARCH}..."

    cp "${MAKEFILE}" "${MAKEFILE_BAK}"

    SED_SRC="^PREFIX=.*"
    SED_DST="PREFIX=${PREFIX}"
    SED_DST="${SED_DST//\//\\/}"
    sed -i.deleteme "s/${SED_SRC}/${SED_DST}/" "${MAKEFILE}"
    rm ${MAKEFILE}.deleteme

    make clean > /dev/null
    make OS=ios ARCH=${ARCH} SDK_MIN=7.0 V=No > /dev/null
    make OS=ios ARCH=${ARCH} SDK_MIN=7.0 V=No install > /dev/null

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