Pod::Spec.new do |s|
  s.name         = "pjsip"
  s.version      = "2.1.0"
  s.summary      = "Open Source SIP, Media and NAT Traversal Library."
  s.homepage     = "http://www.pjsip.org"
  s.author       = 'www.pjsip.org'
  s.source       = { :git => "https://github.com/chebur/pjsip.git", :tag => "#{spec.version}" }
  s.platform     = :ios, '5.0'

  s.description  = <<-DESC
PJSIP is a free and open source multimedia communication library written in C language implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE. It combines signaling protocol (SIP) with rich multimedia framework and NAT traversal functionality into high level API that is portable and suitable for almost any type of systems ranging from desktops, embedded systems, to mobile handsets.

PJSIP is both compact and feature rich. It supports audio, video, presence, and instant messaging, and has extensive documentation. PJSIP is very portable. On mobile devices, it abstracts system dependent features and in many cases is able to utilize the native multimedia capabilities of the device.

PJSIP has been developed by a small team working exclusively for the project since 2005, with participation of hundreds of developers from around the world, and is routinely tested at SIP Interoperability Event (SIPit ) since 2007.
                    DESC
  s.license      = {
     :type => 'GPLv2',
     :text => <<-LICENSE
PJSIP source code ("The Software") is licensed under both General Public License (GPL) version 2 or later and a proprietary license that can be arranged with us. In practical sense, this means:

if you are developing Open Source Software (OSS) based on PJSIP, chances are you will be able to use PJSIP freely under GPL. But please double check here  for OSS license compatibility with GPL.
Alternatively, if you are unable to release your application as Open Source Software, you may arrange alternative licensing with us. Just send your inquiry to licensing@teluu.com to discuss this option.
PJSIP may include third party software in its source code distribution. Third Party Software does not comprise part of "The Software". Please make sure that you comply with the licensing term of each software.
     LICENSE
   }
  
  s.public_header_files = 'pjproject-#{spec.version}/pjsip/include/**', 'pjproject-#{spec.version}/pjlib/include/**', 'pjproject-#{spec.version}/pjlib-util/include/**', 'pjproject-#{spec.version}/pjnath/include/**', 'pjproject-#{spec.version}/pjmedia/include/**'

  s.preserve_paths = "**/lib/**/*.a", 'pjproject-#{spec.version}/pjsip/include/**/*.h', 'pjproject-#{spec.version}/pjlib/include/**/*.h', 'pjproject-#{spec.version}/pjlib-util/include/**/*.h', 'pjproject-#{spec.version}/pjnath/include/**/*.h', 'pjproject-#{spec.version}/pjmedia/include/**/*.h'

  s.header_mappings_dir = 'pjproject-#{spec.version}'

  s.libraries = 'libg7221codec-arm-apple-darwin9', 'libilbccodec-arm-apple-darwin9', 'libmilenage-arm-apple-darwin9', 'libpjsdp-arm-apple-darwin9', 'libspeex-arm-apple-darwin9', 'libsrtp-arm-apple-darwin9', 'libgsmcodec-arm-apple-darwin9', 'libpj-arm-apple-darwin9', 'libpjlib-util-arm-apple-darwin9', 'libpjmedia-arm-apple-darwin9', 'libpjmedia-audiodev-arm-apple-darwin9', 'libpjmedia-codec-arm-apple-darwin9', 'libpjmedia-videodev-arm-apple-darwin9', 'libpjnath-arm-apple-darwin9', 'libpjsip-arm-apple-darwin9', 'libpjsip-simple-arm-apple-darwin9', 'libpjsip-ua-arm-apple-darwin9', 'libpjsua-arm-apple-darwin9', 'libresample-arm-apple-darwin9'

  s.xcconfig = { 'HEADER_SEARCH_PATHS' => 'pjproject-#{spec.version}/pjsip/include pjproject-#{spec.version}/pjlib/include pjproject-#{spec.version}/pjlib-util/include pjproject-#{spec.version}/pjnath/include pjproject-#{spec.version}/pjmedia/include', 'GCC_PREPROCESSOR_DEFINITIONS' => 'PJ_AUTOCONF=1' }
end
