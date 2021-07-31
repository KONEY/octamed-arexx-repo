/* add HIGHLIGHTS every 4 beats */

/*SAY "add HIGHLIGHT every 4 beats - v1.4"
SAY "AreXX script by KONEY 2016"
SAY "--------------------------------------------------"*/

address OCTAMED_REXX
options results

IF ~show(l,"rexxreqtools.library") THEN DO
	IF ~addlib("rexxreqtools.library", 0, -30) THEN DO
		'wi_request "Please install the rexxreqtools.library." "OK"'
		EXIT
	END
END

divider = 8
gadgets= 'ALL BLOCKS|ONLY CURRENT BLOCK'
tagstring= 'rtez_flags = ezreqf_centertext|ezreqf_noreturnkey rt_pubscrname=OCTAMED'
selection = rtezrequest('Select ALL blocks or CURRENT block',gadgets,'Arexx by KONEY 2017 - v1.4',tagstring)

IF selection = 1 THEN
	DO
		'ED_GETNUMBLOCKS VAR bl'
		START = 0
		STOP =  bl-1
		/*SAY 'Processing ALL 'STOP' Blocks'*/
	END
ELSE
	DO
		'ED_GETCURRBLOCK VAR START'
		'ED_GETCURRBLOCK VAR STOP'
		/*SAY 'Processing block# 'STOP*/
	END

DO loop = START TO STOP
	'ED_GOTO block' loop
	'ED_GETNUMLINES var lines'
	spacing_factor = lines / divider
	/*SAY 'BLOCK#'loop'->'lines' lines - ON every 'spacing_factor' lines'*/
	DO i = 0 to divider -1
		'ED_HIGHLIGHTLINE l' i*spacing_factor 'ON'
		/*SAY i*spacing_factor"->ON"*/
	END

END
/*SAY "DONE!"*/
'wi_showstring DONE!'