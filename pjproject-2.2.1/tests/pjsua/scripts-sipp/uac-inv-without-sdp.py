# $Id: uac-inv-without-sdp.py 4177 2012-06-26 02:28:59Z nanang $
#
import inc_const as const

PJSUA = ["--null-audio --max-calls=1"]

PJSUA_EXPECTS = [[0, const.EVENT_INCOMING_CALL, "a"],
		 [0, "", "200"],
		 [0, const.MEDIA_ACTIVE, ""],
		 [0, const.STATE_CONFIRMED, "h"]
		 ]
