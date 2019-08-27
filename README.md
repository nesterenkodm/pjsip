[![Actions Status](https://github.com/chebur/pjsip/workflows/CI/badge.svg)](https://github.com/chebur/pjsip/actions) 
[![PJSIP Version](https://img.shields.io/badge/pjsip-2.9-informational)](https://www.pjsip.org)
[![OpenSSL Version](https://img.shields.io/badge/openssl-LTS_1.1.1c-informational)](https://www.openssl.org)
[![Opus Version](https://img.shields.io/badge/opus-1.3.1-informational)](http://opus-codec.org)
[![ZRTP Support](https://img.shields.io/badge/zrtp-integrated-informational)](https://github.com/wernerd/ZRTP4PJ)

# PJSIP for Apple

This repository delivers PJSIP built for Apple devices (iOS, macOS etc.).

Note that this is not the official repository for PJSIP wich you can find here: https://www.pjsip.org.

This project attempts to make PJSIP available for iOS and macOS by automating the build process and adding some other nice features (also see below).

PJSIP is a free and open source multimedia communication library written in C language implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE.

## Features

- Supported platforms: iOS9+, macOS 10.12+
- Supported architectures: (iOS) armv7, armv7s, arm64, i386, x86_64; (macOS) x86_64
- pjsip 2.9
- IPv6 support
- [ZRTP](https://github.com/wernerd/ZRTP4PJ) included
- OpenSSL supported (LTS 1.1.1c)
- Video support now provided by native frameworks ([VideoToolbox](https://developer.apple.com/documentation/videotoolbox?language=objc))
- OPUS now supported - this pod provides libopus (1.3.1)
- [Available on CocoaPods](https://cocoapods.org/pods/pjsip) (see below, installation)

## Installation

Add the following line to your `Podfile` and run `pod install` command.

```sh
pod 'pjsip'
```

## Example

See [example](https://github.com/chebur/pjsip/example/ipjsystest) folder for integration example

## Build manually

1. Run [build.sh](build.sh).
2. Drag the generated libraries and headers files into your Xcode project.

See also [Getting Started: Building for Apple iPhone, iPad and iPod Touch](https://trac.pjsip.org/repos/wiki/Getting-Started/iPhone)

## Call for Pull Requests

It turns out that building pjsip library for iOS is not a trivial task. Since pjsip binaries has to be rebuild from time to time to automate this work I've decided to create bash scripts and share my work with a community.

It's just my private initiative and I want to state this as clear as possible that this is not an official repository.

I've finished developing my pjsip application, thats why I'm no longer interested in supporting this repository. But I know there are some people which relies on it. They may have buildtime and runtime issues which I'm not able to debug and investigate.

If you are a kind of a person that have time and will to fix and update this build scripts, and experienced enough to debug issues, please send me your pull requests — you will be more than welcome.
