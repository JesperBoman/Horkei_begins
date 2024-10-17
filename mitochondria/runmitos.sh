#!/usr/bin/env bash


# Run mitos2 to annotate genomes assembled by GetOrganelle

conda activate mitos2

runmitos.py \
	--input $1 \
	--code 5 \
	--outdir $2 \
	--refdir ../../aricia/haplonet/resources \
	--refseqver refseq63m \
	--debug
