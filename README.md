
# PJSIP

PJSIP is a free and open source multimedia communication library written in C language implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE.

PJSIP is both compact and feature rich. It supports audio, video, presence, and instant messaging, and has extensive documentation. PJSIP is very portable. On mobile devices, it abstracts system dependent features and in many cases is able to utilize the native multimedia capabilities of the device.

PJSIP has been developed by a small team working exclusively for the project since 2005, with participation of hundreds of developers from around the world, and is routinely tested at SIP Interoperability Event (SIPit ) since 2007.

## Features

- Supported platforms: iOS6, iOS7, iOS8
- Supported architectures: armv7, armv7s, arm64, i386, x86_64
- OpenSSL support provided by the [OpenSSL-for-iPhone](https://github.com/x2on/OpenSSL-for-iPhone) build script and the [OpenSSL-Universal](https://github.com/krzak/OpenSSL.git) pod

## Installation

Add the following line to your `Podfile` and run `pod install` command.

```
pod 'pjsip'
```

## Example

See [example](example/ipjsystest) folder for integration example

## Build manually

1. Download and run [build.sh](build.sh) script.
2. Drag generated libraries and headers files into your xcode project.


