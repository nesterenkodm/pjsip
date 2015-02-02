#!/bin/sh
#
# Downloads file form the URL passed as $1 and saves it to path as $2.
# Extracts the archive if needed.
# Pass --no-cache option to force script to download a file.
#

DOWNLOAD_URL="${1}"
DOWNLOAD_PATH="${2}.download"
FINAL_PATH="${2}"
CACHE=1

while [ "$#" -gt 0 ]; do
    case $1 in
        --no-cache)
            CACHE=0
            ;;
    esac
    shift
done

# download
if [ ! -f "${DOWNLOAD_PATH}" ]; then
    if [ ! -d `dirname "${DOWNLOAD_PATH}"` ]; then
        mkdir -p `dirname "${DOWNLOAD_PATH}"`
    fi
    echo "Downloading ${DOWNLOAD_URL}..."
    curl -L -# -o ${DOWNLOAD_PATH} "${DOWNLOAD_URL}"
fi

# unarchive
FILE=`file "${DOWNLOAD_PATH}" | awk '{print tolower($0)}'`
if [[ "${FILE}" == *"zip"* ]]; then
    echo "Unarchiving ${DOWNLOAD_PATH}..."

    if [ -d "${FINAL_PATH}" ]; then
        rm -rf "${FINAL_PATH}"
    fi
    mkdir -p "${FINAL_PATH}"

    pushd . > /dev/null

    cd "${FINAL_PATH}"
    tar -xf "${DOWNLOAD_PATH}"

    NUMBER_OF_LINES=`ls -1 | wc -l`
    if (( ${NUMBER_OF_LINES} == 1 )); then
        if [ -d "`ls -1`" ]; then
            mv "${FINAL_PATH}/`ls -1`" "${FINAL_PATH}~"
            rm -rf "${FINAL_PATH}"
            mv "${FINAL_PATH}~" "${FINAL_PATH}"
        fi
    fi

    popd > /dev/null
else
    cp "${DOWNLOAD_PATH}" "${FINAL_PATH}"
fi

if (( ${CACHE} == 0 )); then
    rm ${DOWNLOAD_PATH}
fi
