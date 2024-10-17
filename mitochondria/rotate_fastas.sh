#!/usr/bin/env bash

# Uses annotation to orient all mitocondrial assemblies into the same direction
# (cox1 +) and start the sequences at the beginning of cox1
# Requires rotate: https://github.com/richarddurbin/rotate

mkdir -p results/rotated_fastas

for i in data/fasta/???_mt.fa; do

	sample=$(basename $i .fa)

	orient=$(grep "trnM(cat)" results/mito_annotation/$sample/result.bed | cut -f 6)

	if [ $orient == "-" ]; then
		start=$(grep "trnM(cat)" results/mito_annotation/$sample/result.bed | cut -f 3)
		rotate -x $start -rc -o results/rotated_fastas/$sample.fa data/fasta/$sample.fa
	else
		start=$(grep "trnM(cat)" results/mito_annotation/$sample/result.bed | cut -f 2)
		rotate -x $start -o results/rotated_fastas/$sample.fa data/fasta/$sample.fa
	fi

done
