#!/bin/bash -l

module load bioinfo-tools vcftools/0.1.16


sample=$1
gzvcf=$2
outdir=$3

vcftools --gzvcf $gzvcf --indv $sample --counts --out $outdir/$sample
