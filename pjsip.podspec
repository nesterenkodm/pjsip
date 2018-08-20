Pod::Spec.new do |s|
  s.name         = "pjsip"
  s.version      = "2.7.1"
  s.summary      = "Open Source SIP, Media and NAT Traversal Library."
  s.homepage     = "http://www.pjsip.org"
  s.author       = 'www.pjsip.org'
  s.source       = { :git => "https://github.com/chebur/pjsip.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
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

  s.source_files        =
  s.public_header_files =[
                          'build/pjproject/src/pjlib/include/**/*.h',
                          'build/pjproject/src/pjlib-util/include/**/*.h',
                          'build/pjproject/src/pjmedia/include/**/*.h',
                          'build/pjproject/src/pjnath/include/**/*.h',
                          'build/pjproject/src/pjsip/include/**/*.h',
                          'build/pjproject/src/pjsip/include/**/*.hpp']
  s.preserve_paths      =['build/pjproject/src/pjlib/include/**/*',
                          'build/pjproject/src/pjlib-util/include/**/*',
                          'build/pjproject/src/pjmedia/include/**/*',
                          'build/pjproject/src/pjnath/include/**/*',
                          'build/pjproject/src/pjsip/include/**/*']
 
   s.vendored_libraries  =['build/openh264/lib/*.a',
                           'build/opus/dependencies/lib/*.a',
                           'build/pjproject/src/pjlib/lib/*.a',
                           'build/pjproject/src/pjlib-util/lib/*.a',
                           'build/pjproject/src/pjmedia/lib/*.a',
                           'build/pjproject/src/pjnath/lib/*.a',
                           'build/pjproject/src/pjsip/lib/*.a',
                           'build/pjproject/src/third_party/lib/*.a']
  
  header_search_paths   =['"$(PODS_ROOT)/Headers/Public/pjsip/pjlib/include"',
                          '"$(PODS_ROOT)/Headers/Public/pjsip/pjlib-util/include"',
                          '"$(PODS_ROOT)/Headers/Public/pjsip/pjmedia/include"',
                          '"$(PODS_ROOT)/Headers/Public/pjsip/pjnath/include"',
                          '"$(PODS_ROOT)/Headers/Public/pjsip/pjsip/include"']

  s.xcconfig            = {
      'HEADER_SEARCH_PATHS'          => header_search_paths.join(' '),
      'GCC_PREPROCESSOR_DEFINITIONS' => 'PJ_AUTOCONF=1'
  }

  s.dependency          'OpenSSL-Universal'
  s.frameworks          = 'CFNetwork', 'AudioToolbox', 'AVFoundation', 'CoreMedia'
  s.libraries           = 'stdc++'
  s.header_mappings_dir = 'build/pjproject/src'
  s.requires_arc        = false
end

