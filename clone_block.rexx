/* Clone block with name as next */

/*SAY "clone BLOCK into next - v1.0"
SAY "ARexx script by KONEY 2021"
SAY "--------------------------------------------------"*/

address OCTAMED_REXX
options results

ED_GETBLOCKNAME var block_name
/*ED_SETBLOCKNAME block_name'_1'*/
RN_COPY BLOCK
ED_GOTOBLOCK NEXT
ED_NEWBLOCK HERE CLONECURR
RN_PASTE BLOCK
ED_SETBLOCKNAME block_name'_2'

/*Always add highlights!*/
'ED_GETCURRBLOCK VAR START'
'ED_GETCURRBLOCK VAR STOP'

divider=4
ED_GETNUMLINES var lines
spacing_factor = lines / divider
DO i = 0 to divider -1
	'ED_HIGHLIGHTLINE l' i*spacing_factor 'ON'
END

wi_showstring block_name' CLONED'