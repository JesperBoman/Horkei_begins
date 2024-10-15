#!/bin/bash -l



ml bioinfo-tools BEDTools/2.31.1

dir="fisher.junctions"

while IFS= read -r chromosome
do

readarray -t arr < samples.list
readarray -t arr2 < samples.list



p=0
for s1 in "${arr[@]}"
do



for s2 in "${arr2[@]}"
do

#Count the pairwise overlap
bedtools intersect -a $dir/$s1.$chromosome.fj.bed -b $dir/$s2.$chromosome.fj.bed -wo | awk -v s1=$s1 -v s2=$s2 -v chr=$chromosome 'BEGIN{sum=0}{sum+=$7} END{print chr "\t" s1 "\t" s2 "\t" sum "\t" NR}' >> fisher.junction.pairwise.results



done

#Use this to include self-comparisons
#Remove the focal sample from the second array
unset 'arr2[$p]'
p=$(($p+1))
##

done

done < "scaffolds.list.Arx.auto"

#Normalize on a scale from 0 (no sharing) to 1 (complete sharing)
awk 'NR==FNR{if($2 == $3){self[$1,$2]=$5}} NR!=FNR{NormOverlap=2*($5/(self[$1,$2]+self[$1,$3])); print $0 "\t" self[$1,$2] "\t" self[$1,$3] "\t" NormOverlap }' fisher.junction.pairwise.results fisher.junction.pairwise.results > fisher.junction.pairwise.results.norm
