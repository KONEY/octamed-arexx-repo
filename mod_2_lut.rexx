/* Export MOD score to ASM table*/

SAY "Export MOD score to ASM table"
SAY "v1.0 - ARexx script by www.KONEY.org 2021"
SAY "---------------------------------------------------------"

address OCTAMED_REXX
options results

library = 'rexxsupport.library'
IF ~SHOW( 'L', library ) THEN DO
	IF ~ADDLIB( library, 0, -30, 0 ) THEN DO
		SAY 'Failed to add library ' || library || '.'
		EXIT 10
	END
END

P61_POS=0
instr_sel=21
tracks=4
block_len=64
ED_GETNUMPLAYSEQ var total_sequence_blocks

/*op_update off*/
DO seq_pos = 1 to total_sequence_blocks /* CYCLE SEQUENCE */
	'ED_GETPLAYSEQBLOCK'  seq_pos 'var cur_block'
	'ED_GOTO b' cur_block
	'ED_GETBLOCKNAME b' cur_block 'var block_name'
	SAY P61_POS' 'cur_block': 'block_name' -------------------------------------------'
	P61_POS=seq_pos-1
	DO line = 0 to block_len-1 /* CYCLE NOTES*/
	'ED_GOTO l' line
		DO trk = 0 to tracks-1 /* CYCLE TRACKS*/
			'ED_GOTO t' trk
			/*SAY 'TRK: 'trk' -------------------------------------------'*/
			'ED_GETDATA l' line 'NOTE var note'
			'ED_GETDATA l' line 'INUM var instr '
			IF instr = instr_sel THEN
				DO
				SAY 'NOTE: 'note' - INST: 'instr
			END
		END
	END
END
op_update on

SAY '-----------------------'

'wi_showstring FINISHED'