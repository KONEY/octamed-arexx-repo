/*
Export MOD score to ASM table
v1.0 - ARexx script by www.KONEY.org 2021
USAGE: 
Load module into OctaMED SoundStudio
Select desired instrument
Run this script
File is saved in RAM:
Include instr_#_tbl.i into ASM project
THEN:
P61_Position*64 is the offset to current block in sequence
P61_Row is the index for the value of currently triggered note, if any
---------------------------------------------------------
TO DO: keep track of shorter blocks
*/

address OCTAMED_REXX
options results
op_update off
/*library = 'rexxsupport.library'
IF ~SHOW( 'L', library ) THEN DO
	IF ~ADDLIB( library, 0, -30, 0 ) THEN DO
		SAY 'Failed to add library ' || library || '.'
		EXIT 10
	END
END*/
SAY 'ARexx by KONEY 2021 - v1.0'
'IN_GETNUMBER var instr_sel'
'IN_GETNAME var instr_name'
file = 'RAM:instr_'||instr_sel||'_tbl.i'
IF ~OPEN( 'MYFILE', file, 'W' ) THEN DO
	SAY 'Failed to create file "' || file || '".'
	EXIT 10
END

P61_POS=0
tracks=4
block_len=64
divider=16

CALL WRITELN( 'MYFILE', '; 'instr_name' | Data exported with mod_2_lut.rexx by KONEY')
CALL WRITELN( 'MYFILE',  'INSTR_'instr_sel'_TABLE:')
ED_GETNUMPLAYSEQ var total_sequence_blocks
DO seq_pos = 1 to total_sequence_blocks /* CYCLE SEQUENCE */
	'ED_GETPLAYSEQBLOCK'  seq_pos 'var cur_block'
	'ED_GOTO B' cur_block
	'ED_GETBLOCKNAME B' cur_block 'var block_name'
	CALL WRITELN( 'MYFILE', '	; SEQ_POS 'P61_POS' - BLK# 'cur_block' - 'block_name)
	SAY 'SEQ_POS 'P61_POS' - BLK# 'cur_block' - 'block_name
	P61_POS=seq_pos-1
	temp_block_value=''
	DO line = 0 to block_len-1 /* CYCLE NOTES*/
		'ED_GOTO L' line
		note=0
		DO trk = 0 to tracks-1 /* CYCLE TRACKS*/
			'ED_GOTO T' trk
			'ED_GETDATA L' line 'INUM var instr '
			/*SAY 'LINE:' line ' - NOTE: ' note ' - INST: ' instr''*/
			IF note < 1 THEN DO
				IF instr = instr_sel THEN DO
					'ED_GETDATA L' line 'NOTE var note'
					/*SAY 'LINE:' line ' - NOTE: ' note ' - INST: ' instr''*/
					temp_block_value=temp_block_value||note||','
				END
			END
		END
		IF note < 1 THEN DO
			/*SAY 'NOTE: 0 - INST: 0'*/
			temp_block_value=temp_block_value||'0,'
		END
		/*SAY (line+1)//divider*/
		IF (line+1)//divider=0 THEN DO
			CALL WRITELN( 'MYFILE', '	DC.B '||STRIP(temp_block_value,'T',','))
			temp_block_value=''
		END
	END
END
CALL CLOSE( 'MYFILE' )
SAY 'Saved to  'file
op_update on
'wi_showstring DONE!'