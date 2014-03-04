# $Id: uac-ticket-1148.py 4177 2012-06-26 02:28:59Z nanang $
#
import inc_const as const

PJSUA = ["--null-audio --max-calls=1 --auto-answer=200"]

PJSUA_EXPECTS = [[0, const.STATE_CONFIRMED, "v"]]
