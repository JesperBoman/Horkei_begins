#!/usr/bin/env bash -l

# Align mitochondrail sequences of all samples after they have been rotated to start at trnM

conda activate clustalo

clustalo \
	-i results/alignments/all_rotated_trnMstart_unaligned.fasta \
	-o results/alignments/all_rotated_trnMstart_aligned.fasta \
	-v \
	--output-order=tree-order \
	--auto \
	-t DNA
