# build/os-auto.mak.  Generated from os-auto.mak.in by configure.

export OS_CFLAGS   := $(CC_DEF)PJ_AUTOCONF=1 -O2 -m32 -miphoneos-version-min=5.0 -DPJ_SDK_NAME="\"iPhoneSimulator6.1.sdk\""  -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator6.1.sdk -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1

export OS_CXXFLAGS := $(CC_DEF)PJ_AUTOCONF=1 -O2 -m32 -miphoneos-version-min=5.0 -DPJ_SDK_NAME="\"iPhoneSimulator6.1.sdk\""  -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator6.1.sdk 

export OS_LDFLAGS  := -O2 -m32  -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator6.1.sdk -framework AudioToolbox -framework Foundation -lm -lpthread  -framework CoreAudio -framework CoreFoundation -framework AudioToolbox -framework CFNetwork -framework UIKit -framework UIKit -framework AVFoundation -framework CoreGraphics -framework QuartzCore -framework CoreVideo -framework CoreMedia

export OS_SOURCES  := 


