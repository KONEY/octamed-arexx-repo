/* Append song 2 in song 1 */

address OCTAMED_REXX
options results

block_name = "CIPPA";
spacing_factor=8
ED_GETNUMBLOCKS VAR BLOCK_OFFSET
ED_GETNUMBLOCKS VAR BLOCK_COUNTER
ED_GOTO BLOCK FIRST
SG_GOTOSONG FIRST
SG_GOTOSONG NEXT

ED_GOTO BLOCK FIRST

ED_GETNUMBLOCKS VAR bl
START = 0
STOP =  bl-1

OP_UPDATE OFF

DO loop = START TO STOP
	ED_GOTO BLOCK loop
	ED_GETBLOCKNAME; block_name = result
	wi_showstring block_name
	RN_COPY BLOCK
	SG_GOTOSONG PREV

	ED_NEWBLOCK LAST

	ED_GOTO BLOCK BLOCK_COUNTER
	BLOCK_COUNTER=BLOCK_COUNTER+1

	RN_PASTE BLOCK
	ED_SETBLOCKNAME block_name

	DO i = 0 to spacing_factor -1
		ED_HIGHLIGHTLINE l i*spacing_factor ON
	END
	SG_GOTOSONG NEXT
END

SG_GOTOSONG FIRST
SG_GOTOSONG NEXT

ED_GETNUMPLAYSEQ var total_sequence_blocks
DO seq_pos = 1 to total_sequence_blocks
	wi_showstring seq_pos
	ED_GETPLAYSEQBLOCK seq_pos; cur_block=result
	SG_GOTOSONG PREV
	ED_GOTOPLAYSEQ BOTTOM
	ED_NEWPLAYSEQ cur_block+BLOCK_OFFSET
	SG_GOTOSONG NEXT
END
SG_GOTOSONG FIRST

OP_UPDATE ON

wi_showstring 'SONG APPENDED!'