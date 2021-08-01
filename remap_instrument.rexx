/* Remap an instrument and its score */

/*SAY "Remap inst - v1.0"
SAY "ARexx script by KONEY 2021"
SAY "--------------------------------------------------"*/

address OCTAMED_REXX
options results

IF ~show(l,"rexxreqtools.library") THEN DO
	IF ~addlib("rexxreqtools.library", 0, -30) THEN DO
		'wi_request "Please install the rexxreqtools.library." "OK"'
		EXIT
	END
END

/*ED_GETDATA INUM;  SOURCE = result*/

IN_GETNUMBER; SOURCE = result
IN_GETNAME; NAME = result

WI_OPEN SELECTINSTRUMENT

gadgets= 'OK'
tagstring= 'rtez_flags = ezreqf_centertext|ezreqf_noreturnkey rt_pubscrname=OCTAMED'
selection = rtezrequest('SOURCE: 'NAME' Select DEST instr',gadgets,'Arexx by KONEY 2021 - v1.0',tagstring)

IN_GETNUMBER; DEST = result

'in_swapinstruments' SOURCE DEST
'rn_changeinum' SOURCE DEST 'swap'

'wi_showstring CHANGED ' NAME ' TO SLOT' DEST