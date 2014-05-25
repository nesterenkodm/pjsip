# $Id: strict-route.py 4188 2012-06-29 09:01:17Z nanang $
#
import inc_const as const

PJSUA = ["--null-audio --max-calls=1 --id=sip:pjsua@localhost --username=pjsua --realm=* $SIPP_URI"]

PJSUA_EXPECTS = [[0, "ACK sip:proxy@.* SIP/2\.0", ""],
		 [0, const.STATE_CONFIRMED, "h"]
 		 ]
