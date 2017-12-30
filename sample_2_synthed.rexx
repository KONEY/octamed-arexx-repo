/*
Splits a sample in slices and puts them in synthsound waveforms
*/

SAY "Slices sample into syntshond waveforms"
SAY "v1.1 - ARexx script by www.KONEY.org 2017 and Daniele Scarano"
SAY "-----------------------------------------------------------------------"
SAY "USAGE: Load sample in slot #1 create synthsound in slot #2"

address OCTAMED_REXX
options results
w_size=127
SAY "Enter WaveForms count in SynthSound: (0-63)"
waves= READLN(stdout)
IF waves>63 THEN waves = 63
IN_SELECT 2
SAY '->DELETING  OLD WFs...'
DO i = 0 to 63
	SY_DELWAVE 
END
IN_SETNAME "WF_FROM_INST_1"
SAY '->CREATING ' waves ' NEW WFs...'
DO i = 0 to waves
	IF i > 0 THEN 
		DO
		SY_NEWWAVE
		END
END
IN_SELECT 1
SAY "->Now populating from slot #1..."
DO i = 0 to waves
	/*SAY '## WF#' i '-->' i * w_size i*w_size+w_size*/
	SA_RANGE i * w_size i*w_size+w_size
	SA_RANGETOSYNTHED
	IN_SELECT 2
	SY_GOTOWAVE i
	SY_COPYWAVE FROMTEMP
	IN_SELECT 1
END
SAY "DONE!"
IN_SELECT 2