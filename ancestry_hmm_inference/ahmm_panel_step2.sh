#!/bin/bash -l

ml bioinfo-tools BEDTools/2.31.1

#Annotate file with recombination rates

#Divide rates by two if you use a male-specific map. Here we care about the population recombination rate.

awk '(FNR==1 || prevChr != $1){prevChr=$1; prevPPos=$2; prevGPos=$3} FNR>1 && prevChr==$1{print $1 "\t" prevPPos-1 "\t" $2 "\t" $3; prevChr=$1; prevPPos=$2; prevGPos=$3}' ArxLM.interpol.1.0.txt > ArxLM.interpol.1.0.bed

bedtools intersect -a <(awk '{print $1 "\t" $2-1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6}' step1.txt) -b ArxLM.interpol.1.0.bed -wa -wb | awk '{OFS="\t"; print $1, $3, $4, $5, $6, $7, $11}' > step2.txt

cp step2.txt tmp.1.txt
