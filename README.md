
PJSIP
=====

PJSIP is open source SIP, Media and NAT traversal library (www.pjsip.org)

This is a prebuilt pjsip library for armv7, armv7s, arm64, i386 and x86_64 architectures.

Compiled with the latest OpenSSL support (by the build script https://github.com/x2on/OpenSSL-for-iPhone)

How to install?
---------------

The best way is to use cocoapods.

Check the `Podfile` configuration:
```
platform :ios, '5.0'

pod 'pjsip'
```
and run `pod install`
