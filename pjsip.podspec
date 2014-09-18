Pod::Spec.new do |s|
  s.name         = "pjsip"
  s.version      = "2.3"
  s.summary      = "Open Source SIP, Media and NAT Traversal Library."
  s.homepage     = "http://www.pjsip.org"
  s.author       = 'www.pjsip.org'
  s.source       = { :git => "https://github.com/chebur/pjsip.git", :tag => "#{s.version}" }
  s.platform     = :ios, '6.0'
  s.description  = <<-DESC
PJSIP is a free and open source multimedia communication library written in C language implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE. It combines signaling protocol (SIP) with rich multimedia framework and NAT traversal functionality into high level API that is portable and suitable for almost any type of systems ranging from desktops, embedded systems, to mobile handsets.

PJSIP is both compact and feature rich. It supports audio, video, presence, and instant messaging, and has extensive documentation. PJSIP is very portable. On mobile devices, it abstracts system dependent features and in many cases is able to utilize the native multimedia capabilities of the device.

PJSIP has been developed by a small team working exclusively for the project since 2005, with participation of hundreds of developers from around the world, and is routinely tested at SIP Interoperability Event (SIPit ) since 2007.
                    DESC
  s.license      = {
     :type => 'Dual-License',
     :text => <<-LICENSE
PJSIP source code ("The Software") is licensed under both General Public License (GPL) version 2 or later and a proprietary license that can be arranged with us. In practical sense, this means:

if you are developing Open Source Software (OSS) based on PJSIP, chances are you will be able to use PJSIP freely under GPL. But please double check here  for OSS license compatibility with GPL.
Alternatively, if you are unable to release your application as Open Source Software, you may arrange alternative licensing with us. Just send your inquiry to licensing@teluu.com to discuss this option.
PJSIP may include third party software in its source code distribution. Third Party Software does not comprise part of "The Software". Please make sure that you comply with the licensing term of each software.
LICENSE
   }

  s.subspec 'pjsip' do |sub|
    sub.public_header_files = 'build/pjproject-2.3/pjsip/include/**'
    sub.preserve_paths      = 'build/pjproject-2.3/pjsip/include/**/*.h', 'build/pjproject-2.3/pjsip/lib/*.a'
    sub.libraries           = 'pjsua-arm-apple-darwin9', 'pjsip-arm-apple-darwin9', 'pjsip-simple-arm-apple-darwin9', 'pjsip-ua-arm-apple-darwin9'
    sub.xcconfig            = {
      'HEADER_SEARCH_PATHS'  => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjsip/include',
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjsip/lib'
    }
  end

  s.subspec 'pjlib' do |sub|
    sub.public_header_files = 'build/pjproject-2.3/pjlib/include/**'
    sub.preserve_paths      = 'build/pjproject-2.3/pjlib/include/**/*.h', 'build/pjproject-2.3/pjlib/lib/*.a'
    sub.frameworks = 'CFNetwork'
    sub.libraries           = 'pj-arm-apple-darwin9'
    sub.xcconfig            = {
      'HEADER_SEARCH_PATHS'  => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjlib/include',
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjlib/lib'
    }
  end

  s.subspec 'pjlib_util' do |sub|
    sub.public_header_files = 'build/pjproject-2.3/pjlib-util/include/**'
    sub.preserve_paths      = 'build/pjproject-2.3/pjlib-util/include/**/*.h', 'build/pjproject-2.3/pjlib-util/lib/*.a'
    sub.libraries           = 'pjlib-util-arm-apple-darwin9'
    sub.xcconfig            = {
      'HEADER_SEARCH_PATHS'  => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjlib-util/include',
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjlib-util/lib'
    }
  end

  s.subspec 'pjnath' do |sub|
    sub.public_header_files = 'build/pjproject-2.3/pjnath/include/**'
    sub.preserve_paths      = 'build/pjproject-2.3/pjnath/include/**/*.h', 'build/pjproject-2.3/pjnath/lib/*.a'
    sub.libraries           = 'pjnath-arm-apple-darwin9'
    sub.xcconfig            = {
      'HEADER_SEARCH_PATHS'  => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjnath/include',
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjnath/lib'
    }
  end

  s.subspec 'pjmedia' do |sub|
    sub.public_header_files = 'build/pjproject-2.3/pjmedia/include/**'
    sub.preserve_paths      = 'build/pjproject-2.3/pjmedia/include/**/*.h', 'build/pjproject-2.3/pjmedia/lib/*.a'
    sub.libraries           = 'pjmedia-arm-apple-darwin9', 'pjmedia-audiodev-arm-apple-darwin9', 'pjmedia-codec-arm-apple-darwin9', 'pjmedia-videodev-arm-apple-darwin9', 'pjsdp-arm-apple-darwin9'
    sub.frameworks          = 'AudioToolbox', 'AVFoundation'
    sub.xcconfig            = {
      'HEADER_SEARCH_PATHS'  => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjmedia/include',
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/pjmedia/lib'
    }
  end

  s.subspec 'third_party' do |sub|
    sub.preserve_paths      = 'build/pjproject-2.3/third_party/lib/*.a'
    sub.libraries           = 'g7221codec-arm-apple-darwin9', 'ilbccodec-arm-apple-darwin9', 'speex-arm-apple-darwin9', 'srtp-arm-apple-darwin9', 'gsmcodec-arm-apple-darwin9', 'resample-arm-apple-darwin9'
    sub.xcconfig            = {
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/pjsip/build/pjproject-2.3/third_party/lib'
    }
  end

  s.header_mappings_dir = 'pjproject-2.3'

  s.xcconfig = {'GCC_PREPROCESSOR_DEFINITIONS' => 'PJ_AUTOCONF=1' }

end
