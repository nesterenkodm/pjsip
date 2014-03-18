# $Id: uas-reinv-with-less-media.py 4373 2013-02-27 06:44:44Z ming $
#
import inc_const as const

PJSUA = ["--null-audio --extra-audio --max-calls=1 $SIPP_URI"]

# Send hold after remote holds (double hold)
PJSUA_EXPECTS = [[0, const.MEDIA_HOLD, "H"]]
