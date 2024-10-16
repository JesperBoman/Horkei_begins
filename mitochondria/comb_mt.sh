#!/bin/bash -l


while IFS= read -r sample
do


awk -v samp="$sample" 'NR==1{print ">" samp "_mt"} NR!=1{print $0}' $sample.mt/*fasta > tmp.$sample

done < "samples.list"

cat tmp.* > comb.mt.fasta

rm tmp.*
