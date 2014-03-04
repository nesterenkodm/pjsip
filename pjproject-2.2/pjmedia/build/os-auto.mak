# pjmedia/build/os-auto.mak.  Generated from os-auto.mak.in by configure.

# Define the desired video device backend
# Valid values are:
#   - mac_os
#   - iphone_os
AC_PJMEDIA_VIDEO = iphone_os

# SDL flags
SDL_CFLAGS = 
SDL_LDFLAGS = 

# FFMPEG dlags
FFMPEG_CFLAGS =  
FFMPEG_LDFLAGS =  

# Video4Linux2
V4L2_CFLAGS = 
V4L2_LDFLAGS = 

# QT
AC_PJMEDIA_VIDEO_HAS_QT = 
QT_CFLAGS = 

# iOS
IOS_CFLAGS = -DPJMEDIA_VIDEO_DEV_HAS_IOS=1

# PJMEDIA features exclusion
export CFLAGS +=    \
		 $(SDL_CFLAGS) $(FFMPEG_CFLAGS) $(V4L2_CFLAGS) $(QT_CFLAGS) \
		 $(IOS_CFLAGS)
export LDFLAGS += $(SDL_LDFLAGS) $(FFMPEG_LDFLAGS) $(V4L2_LDFLAGS)

# Define the desired sound device backend
# Valid values are:
#   - pa_unix:	    	PortAudio on Unix (OSS or ALSA)
#   - pa_darwinos:  	PortAudio on MacOSX (CoreAudio)
#   - pa_old_darwinos:  PortAudio on MacOSX (old CoreAudio, for OSX 10.2)
#   - pa_win32:	    	PortAudio on Win32 (WMME)
#   - ds:	    	Win32 DirectSound (dsound.c)
#   - null:	    	Null sound device (nullsound.c)
#   - external:		Link with no sounddev (app will provide)
AC_PJMEDIA_SND=

# For Unix, specify if ALSA should be supported
AC_PA_USE_ALSA=

# Additional PortAudio CFLAGS are in  -DPA_LITTLE_ENDIAN

#
# Codecs
#
AC_NO_G711_CODEC=
AC_NO_L16_CODEC=
AC_NO_GSM_CODEC=
AC_NO_SPEEX_CODEC=
AC_NO_ILBC_CODEC=
AC_NO_G722_CODEC=
AC_NO_G7221_CODEC=
AC_NO_OPENCORE_AMRNB=1
AC_NO_OPENCORE_AMRWB=1

export CODEC_OBJS=

export PJMEDIA_AUDIODEV_OBJS += coreaudio_dev.o 

ifeq ($(AC_NO_G711_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_G711_CODEC=0
else
export CODEC_OBJS +=
endif

ifeq ($(AC_NO_L16_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_L16_CODEC=0
else
export CODEC_OBJS += l16.o
endif

ifeq ($(AC_NO_GSM_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_GSM_CODEC=0
else
export CODEC_OBJS += gsm.o
endif

ifeq ($(AC_NO_SPEEX_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_SPEEX_CODEC=0
else
export CFLAGS += -I$(THIRD_PARTY)/build/speex -I$(THIRD_PARTY)/speex/include
export CODEC_OBJS += speex_codec.o

ifneq (,1)
export PJMEDIA_OBJS += echo_speex.o
endif

endif

ifeq ($(AC_NO_ILBC_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_ILBC_CODEC=0
else
export CODEC_OBJS += ilbc.o
endif

ifeq ($(AC_NO_G722_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_G722_CODEC=0
else
export CODEC_OBJS += g722.o g722/g722_enc.o g722/g722_dec.o
endif

ifeq ($(AC_NO_G7221_CODEC),1)
export CFLAGS += -DPJMEDIA_HAS_G7221_CODEC=0
else
export CODEC_OBJS += g7221.o
export G7221_CFLAGS += -I$(THIRD_PARTY)
endif

ifeq ($(AC_NO_OPENCORE_AMRNB),1)
export CFLAGS += -DPJMEDIA_HAS_OPENCORE_AMRNB_CODEC=0
else
export CODEC_OBJS += opencore_amr.o
endif

ifeq ($(AC_NO_OPENCORE_AMRWB),1)
export CFLAGS += -DPJMEDIA_HAS_OPENCORE_AMRWB_CODEC=0
else
ifeq ($(AC_NO_OPENCORE_AMRNB),1)
export CODEC_OBJS += opencore_amr.o
endif
endif


#
# SRTP
#
ifeq (0,1)
# External SRTP
export CFLAGS += -DPJMEDIA_EXTERNAL_SRTP=1
# SRTP srtp_deinit()/srtp_shutdown() API availability settings
export CFLAGS += -DPJMEDIA_SRTP_HAS_DEINIT= \
		 -DPJMEDIA_SRTP_HAS_SHUTDOWN=
else
# Our SRTP in third_party
export CFLAGS += -I$(THIRD_PARTY)/build/srtp \
	 -I$(THIRD_PARTY)/srtp/crypto/include \
	 -I$(THIRD_PARTY)/srtp/include

endif

#
# Resample
#
AC_PJMEDIA_RESAMPLE=libresample

ifeq ($(AC_PJMEDIA_RESAMPLE),none)
# No resample support
export CFLAGS += -DPJMEDIA_RESAMPLE_IMP=PJMEDIA_RESAMPLE_NONE
endif

ifeq ($(AC_PJMEDIA_RESAMPLE),libresample)
export CFLAGS += -DPJMEDIA_RESAMPLE_IMP=PJMEDIA_RESAMPLE_LIBRESAMPLE
endif

ifeq ($(AC_PJMEDIA_RESAMPLE),libsamplerate)
export CFLAGS += -DPJMEDIA_RESAMPLE_IMP=PJMEDIA_RESAMPLE_LIBSAMPLERATE
endif

ifeq ($(AC_PJMEDIA_RESAMPLE),speex)
export CFLAGS += -DPJMEDIA_RESAMPLE_IMP=PJMEDIA_RESAMPLE_SPEEX
endif

#
# PortAudio
#
ifneq ($(findstring pa,$(AC_PJMEDIA_SND)),)
ifeq (0,1)
# External PA
export CFLAGS += -DPJMEDIA_AUDIO_DEV_HAS_PORTAUDIO=1
else
# Our PA in third_party
export CFLAGS += -I$(THIRD_PARTY)/build/portaudio -I$(THIRD_PARTY)/portaudio/include -DPJMEDIA_AUDIO_DEV_HAS_PORTAUDIO=1
endif
endif

#
# Windows specific
#
ifneq ($(findstring win32,$(AC_PJMEDIA_SND)),)
export CFLAGS += -DPJMEDIA_AUDIO_DEV_HAS_WMME=1
else
export CFLAGS += -DPJMEDIA_AUDIO_DEV_HAS_WMME=0
endif

#
# Null sound device
#
ifeq ($(AC_PJMEDIA_SND),null)
export CFLAGS += -DPJMEDIA_AUDIO_DEV_HAS_PORTAUDIO=0 -DPJMEDIA_AUDIO_DEV_HAS_WMME=0
endif

#
# External sound device
#
ifeq ($(AC_PJMEDIA_SND),external)
export CFLAGS += -DPJMEDIA_AUDIO_DEV_HAS_PORTAUDIO=0 -DPJMEDIA_AUDIO_DEV_HAS_WMME=0
endif

#
# QT video device
#
ifeq ($(AC_PJMEDIA_VIDEO_HAS_QT),yes)
export PJMEDIA_VIDEODEV_OBJS += qt_dev.o
endif

#
# iOS video device
#
ifeq ($(AC_PJMEDIA_VIDEO),iphone_os)
export PJMEDIA_VIDEODEV_OBJS += ios_dev.o
endif

#
# Determine whether we should compile the obj-c version of a particular source code
#
ifneq (,$(filter $(AC_PJMEDIA_VIDEO),mac_os iphone_os))
# Mac and iPhone OS specific, use obj-c
export PJMEDIA_VIDEODEV_OBJS += sdl_dev_m.o
else
# Other platforms, compile .c
export PJMEDIA_VIDEODEV_OBJS += sdl_dev.o
endif
