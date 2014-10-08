
# PJSIP

PJSIP is a free and open source multimedia communication library written in C language implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE.

PJSIP is both compact and feature rich. It supports audio, video, presence, and instant messaging, and has extensive documentation. PJSIP is very portable. On mobile devices, it abstracts system dependent features and in many cases is able to utilize the native multimedia capabilities of the device.

PJSIP has been developed by a small team working exclusively for the project since 2005, with participation of hundreds of developers from around the world, and is routinely tested at SIP Interoperability Event (SIPit ) since 2007.

## Features

- Supported architectures: armv7, armv7s, arm64, i386, x86_64
- OpenSSL support provided by https://github.com/x2on/OpenSSL-for-iPhone

## Installation

Add the following line to your `Podfile` and run `pod install` command.

```
pod 'pjsip'
```

## Example

See `example` folder for integration example

## Build manually

1. Download and run [build.sh](https://github.com/chebur/pjsip/blob/master/build.sh) script.
2. Drag generated libraries and headers files into your xcode project.


