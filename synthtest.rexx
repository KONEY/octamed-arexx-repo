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
/* flush inst, set type, and reset synth scripts. faster than deleting wf */
IN_FLUSH
IN_SETTYPE SYNTHETIC
SY_SETPROGRAM END WF /* reset synth script */
SY_SETPROGRAM 64 CHD 127 END VOL /* set vol script. but i don't know if this is right */
/*
SAY '->DELETING  OLD WFs...'
DO i = 0 to 63
	SY_DELWAVE 
END
*/

/* reset cursor position in synth editor or sy_setprogram below will fail (buggy octamed) */
DO i = 0 to 127
	SY_MOVEPROGCURSOR UP
END

IN_SETNAME "WF_FROM_INST_1"
SAY '->CREATING ' waves ' NEW WFs...'
DO i = 0 to waves
/* should start at 0 not 1 */
/*	IF i > 0 THEN 
		DO */
		SY_NEWWAVE
/* set wf script. but i don't know if this is right. might also be X2D(i) instead */
		SY_SETPROGRAM i WF INS
/*		END */
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
/* set some instrument properties */
/* these might be different for different samples, especially transpose */
IN_SETTRANSPOSE 24
SY_SETPROGSPEED WF 1
SY_SETPROGSPEED VOL 8
/* playing around with wf and vol speeds afterward is fun! */