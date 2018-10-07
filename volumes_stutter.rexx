/* Halve HEX volumes. KONEY 2016 */

SAY "Stutters volumes on track"
SAY "AreXX script by KONEY 2016"
SAY "--------------------------------------------------"

address OCTAMED_REXX
options results

even = 1

ED_GETNUMLINES var lines
DO i = 0 to lines-1
	if even=1 then
		do
		'ed_setdata l' i 'CMDNUM 12 QUAL 100'
		even=2
		end
	else
		do
		'ed_setdata l' i 'CMDNUM 12 QUAL 00'
		even=1
		end
END




'wi_showstring DONE!'