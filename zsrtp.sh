#!/bin/bash

# Downloads ZRTP4PJ from the specified source.
# Originally, ZRTP4PJ was developed by Phil Zimmermann.
# Copyright 2019 welljsjs https://github.com/welljsjs. All rights reserved.
#
# Unless required by applicable law or agreed to in writing, this
# software is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

# Choose your ZRTP4PJ and ZRTP source for pulling:

ZRTP4PJ_SRC=${ZRTP4PJ_SOURCE:-"https://github.com/welljsjs/ZRTP4PJ"}
ZRTP_SRC=${ZRTP_SOURCE:-"https://github.com/welljsjs/ZRTPCPP"}



# Do not change anything below this line.

#####################################################################################
ZRTP4PJ_DIR="$(pwd)/build/zrtp4pj"
ZSRTP_DIR="$(pwd)/build/zrtp4pj/zsrtp"
PJ_THIRD_PRTY_DIR="$(pwd)/build/pjproject/src/third_party"

# 1.
# Create a directory for ZRTP4PJ next to opus and openssl if it does not exist.
if [ ! -d "${ZRTP4PJ_DIR}" ]; then
	mkdir -p ${ZRTP4PJ_DIR} && cd ${ZRTP4PJ_DIR}
	echo "Cloning ZRTP4PJ into $(pwd) from ${ZRTP4PJ_SRC}..."
	git clone ${ZRTP4PJ_SRC} .
else
	# Change directory to existing folder ZRTP4PJ.
	cd ${ZRTP4PJ_DIR}
	if [ ! -d ".git" ]; then
		echo "Error: ${ZRTP4PJ_DIR} source directory inconsistent."
		echo "Remove ${ZRTP4PJ_DIR} directory and call this script again."
		exit 1
	fi
	echo "ZRTP4PJ directory already exists, not cloning."
	echo "Pulling from ${ZRTP4PJ_SRC}..."
	git pull
fi
echo "" # new line

# 2.
# Download zrtp (originally, this was done by a similar script 'ZRTP4PJ/zsrtp/getzrtp.sh' within
# the ZRTP4PJ directory, however, we want to be able to control the source for future updates.
if [ ! -d "${ZSRTP_DIR}" ]; then
	echo "Error: The file structure of ZRTP4PJ seems to have changed. This scripts needs to be updated to match the new file structure."
	exit 1
fi

cd "${ZSRTP_DIR}"

if [ ! -d "${ZSRTP_DIR}/zrtp" ]; then
	echo "Cloning ZRTP into $(pwd)/zrtp from ${ZRTP_SRC}..."
	git clone ${ZRTP_SRC} zrtp
else
	cd "${ZSRTP_DIR}/zrtp"
	if [ ! -d ".git" ]; then
		echo "Error: ${ZSRTP_DIR}/zrtp source directory inconsistent."
		echo "Remove ${ZSRTP_DIR}/zrtp directory and call this script again."
		exit 1
	fi
	echo "zrtp directory already exists, not cloning."
	echo "Pulling from ${ZRTP_SRC}..."
	git pull
fi
echo "" # new line


# 3.
# Move or copy the zrtp files to pjproject.

# a) Copy the content of the build directory (zsrtp) to third_party/build/.
# That's how pjsip knows what third-party libraries it needs to build.
# Before, remove the directory if it already exists.
echo "Removing ${PJ_THIRD_PRTY_DIR}/build/zsrtp..."
rm -Rf "${PJ_THIRD_PRTY_DIR}/build/zsrtp"
if [ ! -d "${ZRTP4PJ_DIR}/build/" ]; then
	echo "Error: Cannot find ${ZRTP4PJ_DIR}/build/."
	echo "Error: The file structure of ZRTP4PJ seems to have changed. This script needs to be updated to match the new file structure."
	exit 1
fi
echo "Copying content from ${ZRTP4PJ_DIR}/build/ to ${PJ_THIRD_PRTY_DIR}/build/..."
cp -r "${ZRTP4PJ_DIR}/build/" "${PJ_THIRD_PRTY_DIR}/build/"

# b) Copy the zsrtp directory to third_party/. That's where the sources for the
# build are located.
# If present, remove the directory.
echo "Removing ${PJ_THIRD_PRTY_DIR}/zsrtp..."
rm -Rf "${PJ_THIRD_PRTY_DIR}/zsrtp"

echo "Creating directory ${PJ_THIRD_PRTY_DIR}/zsrtp..."
mkdir -p "${PJ_THIRD_PRTY_DIR}/zsrtp"

echo "Copying content from ${ZRTP4PJ_DIR}/zsrtp/ to ${PJ_THIRD_PRTY_DIR}/zsrtp/..."
cp -r "${ZRTP4PJ_DIR}/zsrtp/." "${PJ_THIRD_PRTY_DIR}/zsrtp/"

echo "" # new line
echo "Finished downloading and copying zrtp files successfully."
