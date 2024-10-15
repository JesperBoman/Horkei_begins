#!/bin/bash -l


ml bioinfo-tools vcftools/0.1.16 samtools/1.19

vcf="Arx.preBQSR.allsites"

vcftools --chr "Chr_Z" --gzvcf $vcf.vcf.gz --recode --out $vcf.Z


cat $vcf.Z.recode.vcf |/sw/bioinfo/vcftools/0.1.16/rackham/bin/vcf-fix-ploidy -p ploidy.def.txt -s sample.list.MF.txt > $vcf.Z_ploidyHapF.vcf

bgzip $vcf.Z_ploidyHapF.vcf -@ 2
tabix $vcf.Z_ploidyHapF.vcf.gz

rm $vcf.Z.recode.vcf
rm $vcf.Z_ploidyHapF.vcf
