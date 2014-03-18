# build/os-auto.mak.  Generated from os-auto.mak.in by configure.

export OS_CFLAGS   := $(CC_DEF)PJ_AUTOCONF=1 -I/tank/proger/dev/sip/pjs/pjsip/pjproject-2.2.1/../OpenSSL/ios/include -O2 -m32 -miphoneos-version-min=5.0 -DPJ_SDK_NAME="\"iPhoneSimulator7.1.sdk\"" -arch i386 -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator7.1.sdk -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1 -I/tank/proger/dev/sip/pjs/pjsip/pjproject-2.2.1/../OpenSSL/ios/include

export OS_CXXFLAGS := $(CC_DEF)PJ_AUTOCONF=1 -I/tank/proger/dev/sip/pjs/pjsip/pjproject-2.2.1/../OpenSSL/ios/include -O2 -m32 -miphoneos-version-min=5.0 -DPJ_SDK_NAME="\"iPhoneSimulator7.1.sdk\"" -arch i386 -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator7.1.sdk 

export OS_LDFLAGS  := -O2 -m32 -miphoneos-version-min=5.0 -arch i386 -isysroot /Applications/XCode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer//SDKs/iPhoneSimulator7.1.sdk -framework AudioToolbox -framework Foundation -L/tank/proger/dev/sip/pjs/pjsip/pjproject-2.2.1/../OpenSSL/ios/lib -lm -lpthread  -framework CoreAudio -framework CoreFoundation -framework AudioToolbox -framework CFNetwork -framework UIKit -framework UIKit -framework AVFoundation -framework CoreGraphics -framework QuartzCore -framework CoreVideo -framework CoreMedia -lcrypto -lssl

export OS_SOURCES  := 


