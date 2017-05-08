#!/bin/sh

# see http://stackoverflow.com/a/3915420/318790
function realpath { echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); }
__FILE__=`realpath "$0"`
__DIR__=`dirname "${__FILE__}"`

# download
function download() {
    "${__DIR__}/download.sh" "$1" "$2" #--no-cache
}

BASE_DIR="$1"
PJSIP_URL="http://www.pjsip.org/release/2.6/pjproject-2.6.tar.bz2"
PJSIP_DIR="$1/src"
LIB_PATHS=("pjlib/lib" \
           "pjlib-util/lib" \
           "pjmedia/lib" \
           "pjnath/lib" \
           "pjsip/lib" \
           "third_party/lib")

OPENSSL_PREFIX=
OPENH264_PREFIX=
OPUS_PREFIX=
while [ "$#" -gt 0 ]; do
    case $1 in
        --with-openssl)
            if [ "$#" -gt 1 ]; then
                OPENSSL_PREFIX=$(python -c "import os,sys; print os.path.realpath(sys.argv[1])" "$2")
                shift 2
                continue
            else
                echo 'ERROR: Must specify a non-empty "--with-openssl PREFIX" argument.' >&2
                exit 1
            fi
            ;;
        --with-openh264)
            if [ "$#" -gt 1 ]; then
                OPENH264_PREFIX=$(python -c "import os,sys; print os.path.realpath(sys.argv[1])" "$2")
                shift 2
                continue
            else
                echo 'ERROR: Must specify a non-empty "--with-openh264 PREFIX" argument.' >&2
                exit 1
            fi
            ;;
        --with-opus)
            if [ "$#" -gt 1 ]; then
                OPUS_PREFIX=$(python -c "import os,sys; print os.path.realpath(sys.argv[1])" "$2")
                shift 2
                continue
            else
                echo 'ERROR: Must specify a non-empty "--with-opus PREFIX" argument.' >&2
                exit 1
            fi
            ;;
    esac

    shift
done

function config_site() {
    SOURCE_DIR=$1
    PJSIP_CONFIG_PATH="${SOURCE_DIR}/pjlib/include/pj/config_site.h"
    HAS_VIDEO=

    echo "Creating config_site.h ..."

    if [ -f "${PJSIP_CONFIG_PATH}" ]; then
        rm "${PJSIP_CONFIG_PATH}"
    fi

    echo "#define PJ_CONFIG_IPHONE 1" >> "${PJSIP_CONFIG_PATH}"
    echo "#define PJ_HAS_IPV6 1" >> "${PJSIP_CONFIG_PATH}" # Enable IPV6
    if [[ ${OPENH264_PREFIX} ]]; then
        echo "#define PJMEDIA_HAS_OPENH264_CODEC 1" >> "${PJSIP_CONFIG_PATH}"
        HAS_VIDEO=1
    fi
    if [[ ${HAS_VIDEO} ]]; then
        echo "#define PJMEDIA_HAS_VIDEO 1" >> "${PJSIP_CONFIG_PATH}"
        echo "#define PJMEDIA_VIDEO_DEV_HAS_OPENGL 1" >> "${PJSIP_CONFIG_PATH}"
        echo "#define PJMEDIA_VIDEO_DEV_HAS_OPENGL_ES 1" >> "${PJSIP_CONFIG_PATH}"
        echo "#define PJMEDIA_VIDEO_DEV_HAS_IOS_OPENGL 1" >> "${PJSIP_CONFIG_PATH}"
        echo "#include <OpenGLES/ES3/glext.h>" >> "${PJSIP_CONFIG_PATH}"
    fi
    echo "#include <pj/config_site_sample.h>" >> "${PJSIP_CONFIG_PATH}"
}

function clean_libs () {
    ARCH=${1}
    for SRC_DIR in ${LIB_PATHS[*]}; do
        DIR="${PJSIP_DIR}/${SRC_DIR}"
        if [ -d "${DIR}" ]; then
            rm -rf "${DIR}"/*
        fi

        DIR="${PJSIP_DIR}/${SRC_DIR}-${ARCH}"
        if [ -d "${DIR}" ]; then
            rm -rf "${DIR}"
        fi
    done
}

function copy_libs () {
    ARCH=${1}

    for SRC_DIR in ${LIB_PATHS[*]}; do
        SRC_DIR="${PJSIP_DIR}/${SRC_DIR}"
        DST_DIR="${SRC_DIR}-${ARCH}"
        if [ -d "${DST_DIR}" ]; then
            rm -rf "${DST_DIR}"
        fi
        cp -R "${SRC_DIR}" "${DST_DIR}"
        rm -rf "${SRC_DIR}"/* # delete files because this directory will be used for the final lipo output
    done
}

function _build() {
    pushd . > /dev/null
    cd ${PJSIP_DIR}

    ARCH=$1
    LOG=${BASE_DIR}/${ARCH}.log

    # configure
    CONFIGURE="./configure-iphone"
    if [[ ${OPENSSL_PREFIX} ]]; then
        CONFIGURE="${CONFIGURE} --with-ssl=${OPENSSL_PREFIX}"
    fi
    if [[ ${OPENH264_PREFIX} ]]; then
        CONFIGURE="${CONFIGURE} --with-openh264=${OPENH264_PREFIX}"
    fi
    if [[ ${OPUS_PREFIX} ]]; then
        CONFIGURE="${CONFIGURE} --with-opus=${OPUS_PREFIX}"
    fi

    # flags
    if [[ ! ${CFLAGS} ]]; then
        export CFLAGS=
    fi
    if [[ ! ${LDFLAGS} ]]; then
        export LDFLAGS=
    fi
    if [[ ${OPENSSL_PREFIX} ]]; then
        export CFLAGS="${CFLAGS} -I${OPENSSL_PREFIX}/include"
        export LDFLAGS="${LDFLAGS} -L${OPENSSL_PREFIX}/lib"
    fi
    if [[ ${OPENH264_PREFIX} ]]; then
        export CFLAGS="${CFLAGS} -I${OPENH264_PREFIX}/include"
        export LDFLAGS="${LDFLAGS} -L${OPENH264_PREFIX}/lib"
    fi
    export LDFLAGS="${LDFLAGS} -lstdc++"

    echo "Building for ${ARCH}..."

    clean_libs ${ARCH}

    make distclean > ${LOG} 2>&1
    ARCH="-arch ${ARCH}" ${CONFIGURE} >> ${LOG} 2>&1
    make dep >> ${LOG} 2>&1
    make clean >> ${LOG}
    make lib >> ${LOG} 2>&1

    copy_libs ${ARCH}
}

function armv7() {
    export CFLAGS="-miphoneos-version-min=8.0"
    export LDFLAGS=
    _build "armv7"
}
function armv7s() {
    export CFLAGS="-miphoneos-version-min=8.0"
    export LDFLAGS=
    _build "armv7s"
}
function arm64() {
    export CFLAGS="-miphoneos-version-min=8.0"
    export LDFLAGS=
    _build "arm64"
}
function i386() {
    export DEVPATH="`xcrun -sdk iphonesimulator --show-sdk-platform-path`/Developer"
    export CFLAGS="-O2 -m32 -mios-simulator-version-min=8.0"
    export LDFLAGS="-O2 -m32 -mios-simulator-version-min=8.0"
    _build "i386"
}
function x86_64() {
    export DEVPATH="`xcrun -sdk iphonesimulator --show-sdk-platform-path`/Developer"
    export CFLAGS="-O2 -m32 -mios-simulator-version-min=8.0"
    export LDFLAGS="-O2 -m32 -mios-simulator-version-min=8.0"
    _build "x86_64"
}

function lipo() {
    TMP=`mktemp -t lipo`
    echo "Lipo libs... (${TMP})"

    for LIB_DIR in ${LIB_PATHS[*]}; do # loop over libs
        DST_DIR="${PJSIP_DIR}/${LIB_DIR}"

        # use the first architecture to find all libraries
        PATTERN_DIR="${DST_DIR}-$1"
        for PATTERN_FILE in `ls -l1 "${PATTERN_DIR}"`; do
            OPTIONS=""

            # loop over all architectures and collect the current library
            for ARCH in "$@"; do
                FILE="${DST_DIR}-${ARCH}/${PATTERN_FILE/-$1-/-${ARCH}-}"
                if [ -e "${FILE}" ]; then
                    OPTIONS="$OPTIONS -arch ${ARCH} ${FILE}"
                fi
            done

            if [ "$OPTIONS" != "" ]; then
                OUTPUT_PREFIX=$(dirname "${DST_DIR}")
                OUTPUT="${OUTPUT_PREFIX}/lib/${PATTERN_FILE/-$1-/-}"

                OPTIONS="${OPTIONS} -create -output ${OUTPUT}"
                echo "$OPTIONS" >> "${TMP}"
            fi
        done
    done

    while read LINE; do
        xcrun -sdk iphoneos lipo ${LINE}
    done < "${TMP}"
}

download "${PJSIP_URL}" "${PJSIP_DIR}"
config_site "${PJSIP_DIR}"
armv7 && armv7s && arm64 && i386 && x86_64
lipo armv7 armv7s arm64 i386 x86_64
