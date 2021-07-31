/* Remap an instrument and its score */

/*SAY "Remap inst - v1.0"
SAY "ARexx script by KONEY 2021"
SAY "--------------------------------------------------"*/

address OCTAMED_REXX
options results

ED_GETDATA INUM;  SOURCE = result
IN_GETNUMBER; DEST = result

'in_swapinstruments' SOURCE DEST
'rn_changeinum' SOURCE DEST 'swap'

IN_GETNAME; NAME = result
'wi_showstring CHANGED ' NAME ' TO SLOT' DEST