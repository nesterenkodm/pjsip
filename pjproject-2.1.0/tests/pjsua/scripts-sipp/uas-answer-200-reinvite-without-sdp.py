# $Id: uas-answer-200-reinvite-without-sdp.py 4188 2012-06-29 09:01:17Z nanang $
#
import inc_const as const

PJSUA = ["--null-audio --max-calls=1 $SIPP_URI"]

PJSUA_EXPECTS = [[0, const.STATE_CONFIRMED, "v"]]
