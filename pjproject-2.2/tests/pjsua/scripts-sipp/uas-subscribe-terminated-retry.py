# $Id: uas-subscribe-terminated-retry.py 4188 2012-06-29 09:01:17Z nanang $
#
import inc_const as const

PJSUA = ["--null-audio --max-calls=1 --id sip:pjsua@localhost --add-buddy $SIPP_URI"]

PJSUA_EXPECTS = [[0, "", "s"],
		 [0, "Subscribe presence of:", "1"],
		 [0, "Presence subscription .* is TERMINATED", ""],
		 [0, "Resubscribing .* in 5000 ms", ""]
		 ]
