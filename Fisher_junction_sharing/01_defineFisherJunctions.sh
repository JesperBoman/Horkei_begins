#!/bin/bash -l

dir="directory_with_phased_vcf_files"

while IFS= read -r chromosome
do
	while IFS= read -r sample
	do

	awk -v sample=$sample -f make_FJ_bed.awk <(zcat $dir/$chromosome.phased.vcf.gz) > fisher.junctions/$sample.$chromosome.fj.bed

	done < "samples.list"
done < "scaffolds.list.Arx.auto"
