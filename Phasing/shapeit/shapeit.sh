#!/bin/bash -l

ml bioinfo-tools SHAPEIT/v4.2.2 bcftools/1.19

vcf=$1
chr=$2
map=$3
options=$4
out=$5

#Phasing
shapeit4 --input "${vcf}" --map "${map}" $options --region "${chr}" --output "${out}"

#Indexing phased vcf
bcftools index "${out}"
