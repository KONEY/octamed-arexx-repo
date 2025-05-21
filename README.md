# octamed-arexx-repo
my ARexx scripts for OctaMED SoundStudio for AMIGA
These are some tools I wrote in ARexx for OctaMED. Hope they're useful to someone :)

## InsertTempoTrack.rexx

Inserts an extra (e.g. 5th) track into every block, steps to line 0 on that track and writes a tempo command (CMD 9 QUAL X) so you can drive per-block BPM changes from a dedicated “tempo track.”

## add_highlights.rexx

Cycles through your selected pattern blocks, computes “every N beats” based on block length, and calls ED_HIGHLIGHTLINE to turn on highlights at those spaced intervals—so you can visually flag downbeats (or any regular subdivision) across multiple blocks.

## append_song.rexx

Takes the second song in memory and pastes all its blocks (and their play-sequence entries) onto the end of the first song—automatically offsetting block numbers and extending your sequence so it “appends” one song onto another in one go.

## calc_playtime.rexx

Simulates playback of the entire sequence—stepping through each block, applying any BPM/LPB changes on the first line—accumulating the millisecond duration of each line to compute and display your song’s total play time in mm:ss. example at https://www.youtube.com/watch?v=Fc_SkySeS90

## clone_block.rexx

Makes a copy of the current pattern block into the “next” block slot, renames it (original_2), then highlights a few evenly spaced lines inside that new block so you immediately see its extents.

## clone_tracks.rexx

Prompts you (via a GUI) for two source-and-destination track pairs, then loops over every block, copying track A→X and B→Y in each one—handy for mirroring MIDI/Paula channels to double-up your output paths.

## export_sequence.rexx

Walks your play-sequence from start to finish, looks up each block’s name, and prints out a numbered “sequence map” (e.g. “0: Intro”, “1: Verse”, …)—so you get a human-readable listing of your song’s structure.

## mod_2_lut.rexx / mod2lut.rexx

Both scripts serve the same broad purpose: they let you take a tracker‐based composition (specifically, the note data for one instrument in your OctaMED play-sequence) and automatically dump it into an assembly-language include file for use in demos, games or custom players.

mod2lut.rexx generates one labeled table per sequence position, emitting your instrument’s 64-step pitch data in hex so your engine can jump directly to the right chunk of notes.
mod_2_lut.rexx (KONEY’s 2021 version) consolidates everything into a single INSTR_n_TABLE: in decimal, with commented markers for each sequence slot, making it easy to include one flat lookup array in your code.
In short, both are exporters—from tracker patterns into lookup tables you can feed straight into your assembly or C sound routines.

## remap_instrument.rexx

Asks you to pick a source instrument slot and then a destination via a small GUI; it then swaps their sample data and score assignments under the hood, effectively “moving” your instrument to a new slot without losing its pattern usage.

## sample_2_synthed.rexx

Prompts for how many waveforms you want, then slices your loaded sample (slot 1) into equal-sized segments and copies each slice into successive waveforms of a synthetic instrument (slot 2)—turning one long sample into a multi-waveform “drum kit.”

## synthtest.rexx

A variant of the above that explicitly creates new synth waveforms, sets their program slots, then copies in sample slices—plus applies a fixed transpose and waveform/volume speeds so you can immediately play back and tweak your freshly built synth patch.

Example at `synthtest.med`

## volumes_stutter.rexx

Scans through your song’s sequence, jumping to each line and track, and injects alternating volume-on/volume-off commands into the effect column to chop the sound into a rapid “stutter.” It reads any block comments (/* … */) out of the way, takes its stutter interval (step size) and target volume levels from user‐supplied arguments, and then uses ARexx commands like ED_GOTOPLAYSEQ, ED_GOTOTRACK, and SG_SETTRACKVOL (or OP_MULTICMD/OP_REPEATCMD) in a tight loop to write the volume changes at the specified rate.
