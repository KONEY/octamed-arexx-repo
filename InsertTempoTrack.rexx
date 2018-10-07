/* ADD A TRACK WITH PRESET TEMPO COMMANDS 906- KONEY 2016 */

ADDRESS octamed_rexx
OPTIONS RESULTS

/* Cycle blocks */
'ed_getnumblocks VAR bl'
currentblock = 0
DO loop = 0 TO bl-1
	'ed_goto block' currentblock
	currentblock = currentblock + 1
	'ed_setblocktracks 5'
	'ed_goto track 4'
	'ed_goto line 0'
	'ed_setdata NOTE 0 INUM 99 CMDNUM 9 QUAL 6'
END

'wi_showstring TRACK WITH TEMPO ADDED'
