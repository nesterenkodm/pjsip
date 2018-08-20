# PJSIP

PJSIP is a free and open source multimedia communication library written in C language implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE.          

## Features

- Supported platforms: iOS8+
- Supported architectures: armv7, armv7s, arm64, i386, x86_64
- IPv6 support
- OpenSSL support provided by the [OpenSSL-for-iPhone](https://github.com/x2on/OpenSSL-for-iPhone) build script and the [OpenSSL-Universal](https://github.com/krzyzanowskim/OpenSSL) pod
- Video support provided by the [OpenH264](https://github.com/cisco/openh264)
- OPUS now supported - this pod provides libopus

## Installation

Add the following line to your `Podfile` and run `pod install` command.

```
pod 'pjsip'
```

## Example

See [example](example/ipjsystest) folder for integration example

## Build manually

1. Run `brew install nasm` to build openh264.
1. Run [build.sh](build.sh).
2. Drag generated libraries and headers files into your xcode project.

## Call for Pull Requests

It turns out that building pjsip library for iOS is not a trivial task. Since pjsip binaries has to be rebuild from time to time to automate this work I've decided to create bash scripts and share my work with a community. 

It's just my private initiative and I want to state this as clear as possible that this is not an official repository. 

I've finished developing my pjsip application, thats why I'm no longer interested in supporting this repository. But I know there are some people which relies on it. They may have buildtime and runtime issues which I'm not able to debug and investigate. 

If you are a kind of a person that have time and will to fix and update this build scripts, and experienced enough to debug issues, please send me your pull requests — you will be more than welcome.  
