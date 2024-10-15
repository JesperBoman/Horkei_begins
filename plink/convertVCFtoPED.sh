#!/bin/bash -l

#Inspired by: https://github.com/linneas/fennoscandian_wolf/blob/main/run_vcftools_convertVCFtoPED.sh

ml bioinfo-tools vcftools/0.1.16

gzvcf=$1
chrMap=$2 
outprefix=$3

# Extract only known autosomes
vcftools --gzvcf $gzvcf --not-chr "Chr_Z" --plink --chrom-map $chrMap --out $outprefix
