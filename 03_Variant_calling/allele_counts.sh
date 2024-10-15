#!/bin/bash -l


module load bioinfo-tools vcftools/0.1.16

gzvcf="Arx.preBQSR.PI.HQSNPs.Z_ploidyHapF.vcf.gz"

vcftools --gzvcf $gzvcf --keep samples.list.Horkei --counts --out ploidyHapF.HQSNPs.Horkei &

vcftools --gzvcf $gzvcf --keep samples.list.KBH_artax --counts --out ploidyHapF.HQSNPs.KBH_artax &

vcftools --gzvcf $gzvcf --keep samples.list.Agestis --counts --out ploidyHapF.HQSNPs.Agestis &

#vcftools --gzvcf $gzvcf --keep samples.list.Blekingeartax --counts --out PI.HQSNPs.Blekingeartax &


wait
