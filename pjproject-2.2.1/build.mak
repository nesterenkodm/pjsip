export PJDIR := /Users/chebur/Documents/Projects/ObjC/pjsip/pjproject-2.2.1
include $(PJDIR)/version.mak
export PJ_DIR := $(PJDIR)

# build.mak.  Generated from build.mak.in by configure.
export MACHINE_NAME := auto
export OS_NAME := auto
export HOST_NAME := unix
export CC_NAME := gcc
export TARGET_NAME := arm-apple-darwin9
export CROSS_COMPILE := arm-apple-darwin9-
export LINUX_POLL := select 
export SHLIB_SUFFIX := dylib

export prefix := /usr/local
export exec_prefix := ${prefix}
export includedir := ${prefix}/include
export libdir := ${exec_prefix}/lib

LIB_SUFFIX = $(TARGET_NAME).a

ifeq (,1)
export PJ_SHARED_LIBRARIES := 1
endif

# Determine which party libraries to use
export APP_THIRD_PARTY_EXT :=
export APP_THIRD_PARTY_LIBS :=
export APP_THIRD_PARTY_LIB_FILES :=

ifeq (0,1)
# External SRTP library
APP_THIRD_PARTY_EXT += -lsrtp
else
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libsrtp-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
APP_THIRD_PARTY_LIBS += -lsrtp-$(TARGET_NAME)
else
APP_THIRD_PARTY_LIBS += -lsrtp
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libsrtp.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libsrtp.$(SHLIB_SUFFIX)
endif
endif

ifeq (libresample,libresample)
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libresample-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
ifeq (,1)
export PJ_RESAMPLE_DLL := 1
APP_THIRD_PARTY_LIBS += -lresample
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libresample.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libresample.$(SHLIB_SUFFIX)
else
APP_THIRD_PARTY_LIBS += -lresample-$(TARGET_NAME)
endif
else
APP_THIRD_PARTY_LIBS += -lresample
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libresample.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libresample.$(SHLIB_SUFFIX)
endif
endif

ifneq (,1)
ifeq (0,1)
# External GSM library
APP_THIRD_PARTY_EXT += -lgsm
else
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libgsmcodec-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
APP_THIRD_PARTY_LIBS += -lgsmcodec-$(TARGET_NAME)
else
APP_THIRD_PARTY_LIBS += -lgsmcodec
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libgsmcodec.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libgsmcodec.$(SHLIB_SUFFIX)
endif
endif
endif

ifneq (,1)
ifeq (0,1)
APP_THIRD_PARTY_EXT += -lspeex -lspeexdsp
else
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libspeex-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
APP_THIRD_PARTY_LIBS += -lspeex-$(TARGET_NAME)
else
APP_THIRD_PARTY_LIBS += -lspeex
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libspeex.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libspeex.$(SHLIB_SUFFIX)
endif
endif
endif

ifneq (,1)
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libilbccodec-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
APP_THIRD_PARTY_LIBS += -lilbccodec-$(TARGET_NAME)
else
APP_THIRD_PARTY_LIBS += -lilbccodec
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libilbccodec.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libilbccodec.$(SHLIB_SUFFIX)
endif
endif

ifneq (,1)
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libg7221codec-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
APP_THIRD_PARTY_LIBS += -lg7221codec-$(TARGET_NAME)
else
APP_THIRD_PARTY_LIBS += -lg7221codec
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libg7221codec.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libg7221codec.$(SHLIB_SUFFIX)
endif
endif

ifneq ($(findstring pa,),)
ifeq (0,1)
# External PA
APP_THIRD_PARTY_EXT += -lportaudio
else
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libportaudio-$(LIB_SUFFIX)
ifeq ($(PJ_SHARED_LIBRARIES),)
APP_THIRD_PARTY_LIBS += -lportaudio-$(TARGET_NAME)
else
APP_THIRD_PARTY_LIBS += -lportaudio
APP_THIRD_PARTY_LIB_FILES += $(PJ_DIR)/third_party/lib/libportaudio.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/third_party/lib/libportaudio.$(SHLIB_SUFFIX)
endif
endif
endif

# Additional flags


#
# Video
# Note: there are duplicated macros in pjmedia/os-auto.mak.in (and that's not
#       good!

# SDL flags
SDL_CFLAGS = 
SDL_LDFLAGS = 

# FFMPEG dlags
FFMPEG_CFLAGS =  
FFMPEG_LDFLAGS =  

# Video4Linux2
V4L2_CFLAGS = 
V4L2_LDFLAGS = 

# QT
AC_PJMEDIA_VIDEO_HAS_QT = 
QT_CFLAGS = 

# iOS
IOS_CFLAGS = -DPJMEDIA_VIDEO_DEV_HAS_IOS=1

# PJMEDIA features exclusion
PJ_VIDEO_CFLAGS += $(SDL_CFLAGS) $(FFMPEG_CFLAGS) $(V4L2_CFLAGS) $(QT_CFLAGS) \
		   $(IOS_CFLAGS)
PJ_VIDEO_LDFLAGS += $(SDL_LDFLAGS) $(FFMPEG_LDFLAGS) $(V4L2_LDFLAGS)


# CFLAGS, LDFLAGS, and LIBS to be used by applications
export APP_CC := /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//../../../Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export APP_CXX := /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//../../../Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export APP_CFLAGS := -DPJ_AUTOCONF=1\
	-O2 -m32 -miphoneos-version-min=5.0 -DPJ_SDK_NAME="\"iPhoneSimulator7.1.sdk\"" -arch i386 -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator7.1.sdk -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1\
	$(PJ_VIDEO_CFLAGS) \
	-I$(PJDIR)/pjlib/include\
	-I$(PJDIR)/pjlib-util/include\
	-I$(PJDIR)/pjnath/include\
	-I$(PJDIR)/pjmedia/include\
	-I$(PJDIR)/pjsip/include
export APP_CXXFLAGS := $(APP_CFLAGS)
export APP_LDFLAGS := -L$(PJDIR)/pjlib/lib\
	-L$(PJDIR)/pjlib-util/lib\
	-L$(PJDIR)/pjnath/lib\
	-L$(PJDIR)/pjmedia/lib\
	-L$(PJDIR)/pjsip/lib\
	-L$(PJDIR)/third_party/lib\
	$(PJ_VIDEO_LDFLAGS) \
	-O2 -m32 -miphoneos-version-min=5.0 -arch i386 -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator7.1.sdk -framework AudioToolbox -framework Foundation
export APP_LDXXFLAGS := $(APP_LDFLAGS)

export APP_LIB_FILES = \
	$(PJ_DIR)/pjsip/lib/libpjsua-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjsip/lib/libpjsip-ua-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjsip/lib/libpjsip-simple-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjsip/lib/libpjsip-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-codec-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-videodev-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-audiodev-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjnath/lib/libpjnath-$(LIB_SUFFIX) \
	$(PJ_DIR)/pjlib-util/lib/libpjlib-util-$(LIB_SUFFIX) \
	$(APP_THIRD_PARTY_LIB_FILES) \
	$(PJ_DIR)/pjlib/lib/libpj-$(LIB_SUFFIX)
export APP_LIBXX_FILES = \
	$(PJ_DIR)/pjsip/lib/libpjsua2-$(LIB_SUFFIX) \
	$(APP_LIB_FILES)

ifeq ($(PJ_SHARED_LIBRARIES),)
export PJLIB_LDLIB := -lpj-$(TARGET_NAME)
export PJLIB_UTIL_LDLIB := -lpjlib-util-$(TARGET_NAME)
export PJNATH_LDLIB := -lpjnath-$(TARGET_NAME)
export PJMEDIA_AUDIODEV_LDLIB := -lpjmedia-audiodev-$(TARGET_NAME)
export PJMEDIA_VIDEODEV_LDLIB := -lpjmedia-videodev-$(TARGET_NAME)
export PJMEDIA_LDLIB := -lpjmedia-$(TARGET_NAME)
export PJMEDIA_CODEC_LDLIB := -lpjmedia-codec-$(TARGET_NAME)
export PJSIP_LDLIB := -lpjsip-$(TARGET_NAME)
export PJSIP_SIMPLE_LDLIB := -lpjsip-simple-$(TARGET_NAME)
export PJSIP_UA_LDLIB := -lpjsip-ua-$(TARGET_NAME)
export PJSUA_LIB_LDLIB := -lpjsua-$(TARGET_NAME)
export PJSUA2_LIB_LDLIB := -lpjsua2-$(TARGET_NAME)
else
export PJLIB_LDLIB := -lpj
export PJLIB_UTIL_LDLIB := -lpjlib-util
export PJNATH_LDLIB := -lpjnath
export PJMEDIA_AUDIODEV_LDLIB := -lpjmedia-audiodev
export PJMEDIA_VIDEODEV_LDLIB := -lpjmedia-videodev
export PJMEDIA_LDLIB := -lpjmedia
export PJMEDIA_CODEC_LDLIB := -lpjmedia-codec
export PJSIP_LDLIB := -lpjsip
export PJSIP_SIMPLE_LDLIB := -lpjsip-simple
export PJSIP_UA_LDLIB := -lpjsip-ua
export PJSUA_LIB_LDLIB := -lpjsua
export PJSUA2_LIB_LDLIB := -lpjsua2

export ADD_LIB_FILES := $(PJ_DIR)/pjsip/lib/libpjsua.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjsip/lib/libpjsua.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjsip/lib/libpjsip-ua.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjsip/lib/libpjsip-ua.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjsip/lib/libpjsip-simple.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjsip/lib/libpjsip-simple.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjsip/lib/libpjsip.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjsip/lib/libpjsip.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-codec.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjmedia/lib/libpjmedia-codec.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-videodev.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjmedia/lib/libpjmedia-videodev.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjmedia/lib/libpjmedia.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjmedia/lib/libpjmedia-audiodev.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjmedia/lib/libpjmedia-audiodev.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjnath/lib/libpjnath.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjnath/lib/libpjnath.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjlib-util/lib/libpjlib-util.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjlib-util/lib/libpjlib-util.$(SHLIB_SUFFIX) \
	$(PJ_DIR)/pjlib/lib/libpj.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjlib/lib/libpj.$(SHLIB_SUFFIX)

APP_LIB_FILES += $(ADD_LIB_FILES)

APP_LIBXX_FILES += $(PJ_DIR)/pjsip/lib/libpjsua2.$(SHLIB_SUFFIX).$(PJ_VERSION_MAJOR) $(PJ_DIR)/pjsip/lib/libpjsua2.$(SHLIB_SUFFIX) \
	$(ADD_LIB_FILES)
endif

export APP_LDLIBS := $(PJSUA_LIB_LDLIB) \
	$(PJSIP_UA_LDLIB) \
	$(PJSIP_SIMPLE_LDLIB) \
	$(PJSIP_LDLIB) \
	$(PJMEDIA_CODEC_LDLIB) \
	$(PJMEDIA_LDLIB) \
	$(PJMEDIA_VIDEODEV_LDLIB) \
	$(PJMEDIA_AUDIODEV_LDLIB) \
	$(PJMEDIA_LDLIB) \
	$(PJNATH_LDLIB) \
	$(PJLIB_UTIL_LDLIB) \
	$(APP_THIRD_PARTY_LIBS)\
	$(APP_THIRD_PARTY_EXT)\
	$(PJLIB_LDLIB) \
	-lm -lpthread  -framework CoreAudio -framework CoreFoundation -framework AudioToolbox -framework CFNetwork -framework UIKit -framework UIKit -framework AVFoundation -framework CoreGraphics -framework QuartzCore -framework CoreVideo -framework CoreMedia
export APP_LDXXLIBS := $(PJSUA2_LIB_LDLIB) \
	-lstdc++ \
	$(APP_LDLIBS)

# Here are the variabels to use if application is using the library
# from within the source distribution
export PJ_CC := $(APP_CC)
export PJ_CXX := $(APP_CXX)
export PJ_CFLAGS := $(APP_CFLAGS)
export PJ_CXXFLAGS := $(APP_CXXFLAGS)
export PJ_LDFLAGS := $(APP_LDFLAGS)
export PJ_LDXXFLAGS := $(APP_LDXXFLAGS)
export PJ_LDLIBS := $(APP_LDLIBS)
export PJ_LDXXLIBS := $(APP_LDXXLIBS)
export PJ_LIB_FILES := $(APP_LIB_FILES)
export PJ_LIBXX_FILES := $(APP_LIBXX_FILES)

# And here are the variables to use if application is using the
# library from the install location (i.e. --prefix)
export PJ_INSTALL_DIR := /usr/local
export PJ_INSTALL_INC_DIR := ${prefix}/include
export PJ_INSTALL_LIB_DIR := ${exec_prefix}/lib
export PJ_INSTALL_CFLAGS := -I$(PJ_INSTALL_INC_DIR) -DPJ_AUTOCONF=1	-O2 -m32 -miphoneos-version-min=5.0 -DPJ_SDK_NAME="\"iPhoneSimulator7.1.sdk\"" -arch i386 -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator7.1.sdk -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1
export PJ_INSTALL_CXXFLAGS := $(PJ_INSTALL_CFLAGS)
export PJ_INSTALL_LDFLAGS := -L$(PJ_INSTALL_LIB_DIR) $(APP_LDLIBS)
