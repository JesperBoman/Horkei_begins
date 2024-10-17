#!/bin/bash -l

module load bioinfo-tools vcftools/0.1.16 samtools/1.19

vcf=$1
haplotype=$2
ref=$3
vcfdir=$4
sample=$5
Chr=$6
start=$7
end=$8


samtools faidx $ref ${Chr}:${start}-${end} | vcf-consensus -H $haplotype -s $sample $vcfdir/$vcf \
| awk -v samp="$sample" -v hap="$haplotype" '{if($1 ~ />/){print ">" samp "_" hap} else{print $0}  }' > work/$sample.${Chr}_${start}-${end}.Hap${haplotype}.fa
