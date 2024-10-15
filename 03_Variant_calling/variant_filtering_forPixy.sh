#!/bin/bash -l



#Load modules
module load bioinfo-tools vcftools/0.1.16 samtools/1.19

#gzvcf="Arx.preBQSR.allsites.g.vcf"
gzvcf="Arx.preBQSR.allsites.g.Z_ploidyHapF.vcf"

vcftools --gzvcf $gzvcf.gz \
--remove-indels \
--max-missing 0.8 \
--min-meanDP 10 \
--max-meanDP 200 \
--recode --stdout | bgzip -@ 2 > $gzvcf.pixy_filt.gz

tabix -p vcf $gzvcf.pixy_filt.gz 
