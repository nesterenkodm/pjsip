Pod::Spec.new do |s|
  s.name         = "pjsip"
  s.version      = "2.2.1"
  s.summary      = "Open Source SIP, Media and NAT Traversal Library."
  s.homepage     = "http://www.pjsip.org"
  s.author       = 'www.pjsip.org'
  #s.source       = { :git => "https://github.com/chebur/pjsip.git", :tag => "#{s.version}" }
  s.platform     = :ios, '5.1.1'
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

  s.dependency 'OpenSSL-Universal', '~> 1.0.1.f'

  s.subspec 'pjsip' do |sub|
    s.public_header_files = 'pjproject-2.2.1/pjsip/include/**/*.{h,hpp}'
    sub.preserve_paths      = 'pjproject-2.2.1/pjsip/include/**/*.h', 'pjproject-2.2.1/pjsip/lib/*.a'
    libs = 'pjsua-arm-apple-darwin9', 'pjsip-arm-apple-darwin9', 'pjsip-simple-arm-apple-darwin9', 'pjsip-ua-arm-apple-darwin9'

    sub.libraries           = libs
    sub.vendored_libraries  = libs.map {|l| 'pjproject-2.2.1/pjsip/lib/lib' + l + '.a'}
  end

  s.subspec 'pjlib' do |sub|
    sub.public_header_files = 'pjproject-2.2.1/pjlib/include/**/*.{h,hpp}'
    sub.preserve_paths      = 'pjproject-2.2.1/pjlib/include/**/*.h', 'pjproject-2.2.1/pjlib/lib/*.a'
    libs = ['pj-arm-apple-darwin9']

    sub.frameworks = 'CFNetwork'
    sub.libraries           = libs
    sub.vendored_libraries  = libs.map {|l| 'pjproject-2.2.1/pjlib/lib/lib' + l + '.a'}
  end

  s.subspec 'pjlib_util' do |sub|
    sub.public_header_files = 'pjproject-2.2.1/pjlib-util/include/**/*.{h,hpp}'
    sub.preserve_paths      = 'pjproject-2.2.1/pjlib-util/include/**/*.h', 'pjproject-2.2.1/pjlib-util/lib/*.a'
    libs = ['pjlib-util-arm-apple-darwin9']

    sub.libraries           = libs
    sub.vendored_libraries  = libs.map {|l| 'pjproject-2.2.1/pjlib-util/lib/lib' + l + '.a'}
  end

  s.subspec 'pjnath' do |sub|
    sub.public_header_files = 'pjproject-2.2.1/pjnath/include/**/*.{h,hpp}'
    sub.preserve_paths      = 'pjproject-2.2.1/pjnath/include/**/*.h', 'pjproject-2.2.1/pjnath/lib/*.a'
    libs = ['pjnath-arm-apple-darwin9']

    sub.libraries           = libs
    sub.vendored_libraries  = libs.map {|l| 'pjproject-2.2.1/pjnath/lib/lib' + l + '.a'}
  end

  s.subspec 'pjmedia' do |sub|
    sub.public_header_files = 'pjproject-2.2.1/pjmedia/include/**/*.{h,hpp}'
    sub.preserve_paths      = 'pjproject-2.2.1/pjmedia/include/**/*.h', 'pjproject-2.2.1/pjmedia/lib/*.a'
    libs = 'pjmedia-arm-apple-darwin9', 'pjmedia-audiodev-arm-apple-darwin9', 'pjmedia-codec-arm-apple-darwin9', 'pjmedia-videodev-arm-apple-darwin9', 'pjsdp-arm-apple-darwin9'
    sub.libraries           = libs
    sub.vendored_libraries  = libs.map {|l| 'pjproject-2.2.1/pjmedia/lib/lib' + l + '.a'}
    sub.frameworks          = 'AudioToolbox', 'AVFoundation'
  end

  s.subspec 'third_party' do |sub|
    libs = 'g7221codec-arm-apple-darwin9', 'ilbccodec-arm-apple-darwin9', 'speex-arm-apple-darwin9', 'srtp-arm-apple-darwin9', 'gsmcodec-arm-apple-darwin9', 'resample-arm-apple-darwin9'

    sub.preserve_paths      = 'pjproject-2.2.1/third_party/lib/*.a'
    sub.libraries           = libs
    sub.vendored_libraries  = libs.map {|l| 'pjproject-2.2.1/third_party/lib/lib' + l + '.a'}
  end

  s.header_mappings_dir = 'pjproject-2.2.1'

  s.xcconfig = {'GCC_PREPROCESSOR_DEFINITIONS' => 'PJ_AUTOCONF=1' }

end
