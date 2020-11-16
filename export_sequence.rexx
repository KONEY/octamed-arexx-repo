/* Export block names in sequence*/

SAY "Sequence of blocks in OctaMED SS song, by names"
SAY "v1.0 - AreXX script by www.KONEY.org 2020"
SAY "-----------------------------------------------"

address OCTAMED_REXX
options results

/* Add libs. */
/*library = 'rexxmathlib.library'
IF ~SHOW( 'L', library ) THEN DO
	IF ~ADDLIB( library, 0, -30, 0 ) THEN DO
		SAY 'Failed to add library ' || library || '.'
		EXIT 10
	END
END*/
library = 'rexxsupport.library'
IF ~SHOW( 'L', library ) THEN DO
	IF ~ADDLIB( library, 0, -30, 0 ) THEN DO
		SAY 'Failed to add library ' || library || '.'
		EXIT 10
	END
END
P61_POS=0
	/* CYCLE SEQUENCE */
	ED_GETNUMPLAYSEQ var total_sequence_blocks
	op_update off /* Thanks to AlphA202303 for this command! */
	DO seq_pos = 1 to total_sequence_blocks
		'ED_GETPLAYSEQBLOCK'  seq_pos 'var cur_block'
		'ED_GOTO b' cur_block
		'ED_GETBLOCKNAME b' cur_block 'var block_name'
		P61_POS=seq_pos-1
		SAY P61_POS' 'cur_block': 'block_name
	END /* BLOCK SEQ*/
	op_update on

SAY '-----------------------'

'wi_showstring FINISH'