
PJSIP
=====

PJSIP is open source SIP, Media and NAT traversal library (www.pjsip.org)

This is a prebuild pjsip library included universal libraries for armv7, armv7s, arm64, iPhoneSimulator

This *fork supports SSL*.

How to install?
---------------

The best way is using cocoapods.

Check the `Podfile` configuration:
```
platform :ios, '5.1.1'

pod 'pjsip', :path => '~/path/to/this/checkout'
```
and run `pod install`

Building
--------

```
git submodule init
git submodule update # for ios-openssl
./build.sh           # (starts fresh)
```
