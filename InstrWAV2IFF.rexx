/*
Changes current instrument type to SAMPLE and pitch up.
SAY "Convert loaded 16BIT sample to 8BIT"
SAY "v1.0 - ARexx Script for OctaMED SS by www.KONEY.org 2025"
SAY "-----------------------------------------------------------------------"
SAY "USAGE: Load sample, launch .rexx, play."*/

address OCTAMED_REXX
options results

IN_ISSTEREO var is_stereo
if is_stereo=1 then
	DO
		IN_MONO
	END

IN_SETTYPE SAMPLE
SA_CHANGEPITCH 1 3 ANTIALIAS
SA_CHANGEVOL 999 999 NOCLIP
SA_REMUNUSEDSPACE
IN_SAVE 'RAM:CIPPA.iff'

WI_SHOWSTRING 'DONE!'
