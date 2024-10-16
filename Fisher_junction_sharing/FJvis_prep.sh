#!/bin/bash -l

ml bioinfo-tools BEDTools/2.31.1

while IFS= read -r sample
do

bedtools intersect -a switch.regions3/$sample.Chr_1.switch.regions.bed -b <(awk 'BEGIN{print "Chr_1" "\t" 9800003 "\t" 9801446}') | awk -v samp=$sample '{print $0 "\t" samp}' >> FJvis_Chr1.9800003-9801446.bed

done < "samples.list"
