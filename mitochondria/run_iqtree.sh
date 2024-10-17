#!/usr/bin/env bash -l

# Infer phylogenetic tree from aligned and trimmed mitochondrial sequences

conda activate iqtree2

iqtree \
	-s results/alignments/all_rotated_trnMstart_aligned_trimmed.fasta \
	-B 1000
