/* CLONE TRACKS TO DOUBLE DYNAMICS ON PAULA OUTPUTS!! - v1.1 KONEY 2016  */

ADDRESS octamed_rexx
OPTIONS RESULTS

IF ~show(l,"rexxreqtools.library") THEN DO
    IF ~addlib("rexxreqtools.library", 0, -30) THEN DO
        'wi_request "Please install the rexxreqtools.library." "OK"'
        EXIT
    END
END

gadgets = '0-> 3   1-> 2|3-> 0   2-> 1'
tagstring = 'rtez_flags = ezreqf_centertext|ezreqf_noreturnkey rt_pubscrname=OCTAMED'
selection = rtezrequest('Select tracks sources and destinations',gadgets,'Arexx script v1.1 by KONEY 2016',tagstring)

IF selection = 1 THEN
	DO
		source1 = 0
		dest1	= 3
		source2	= 1
		dest2	= 2
	END
ELSE
	DO
		source1 = 3
		dest1	= 0
		source2	= 2
		dest2	= 1
	END


/* Cycle blocks */
ed_getnumblocks VAR bl
currentblock = 0
DO loop = 0 TO bl-1
	ed_goto block currentblock
	currentblock = currentblock + 1
	ed_goto track source1
	rn_copy track
	ed_goto track dest1
	rn_paste track
	ed_goto track source2
	rn_copy track
	ed_goto track dest2
	rn_paste track
END

'wi_showstring ALL TRACKS CLONED!'
