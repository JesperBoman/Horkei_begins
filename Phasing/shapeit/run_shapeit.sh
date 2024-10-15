#!/bin/bash -l

####################### PHASE VARIANTS WITH SHAPEIT4  ##########################


awk 'BEGIN{print "pos" "\t" "chr" "\t" "cM"} {GPmid=$2/(10^6); GPend=2*GPmid ;print 1 "\t" $1 "\t" 0 "\n" int($2/2) "\t" $1 "\t" GPmid  "\n" $2 "\t" $1 "\t" GPend }' ../../Reference/ilAriArta2.1_SH.fasta.fai > constant2cM_per_Mb.map

dir="../../03_Variant_calling"
vcf="$dir/Arx.preBQSR.HQSNPs.vcf.gz"

# Run one chromosome at a time.

while IFS= read -r Chr
do


 grep -w "$Chr" constant2cM_per_Mb.map > tmp${Chr}_2cM_per_Mb.map
 outp="${Chr}.phased.vcf.gz"
 sbatch -J shapeit.$Chr -o slurm/shapeit.$Chr.output -e slurm/shapeit.$Chr.error -A "Project ID" -t 00-01:00:00 -p core -n 8 shapeit.sh $vcf $Chr tmp${Chr}_2cM_per_Mb.map "--thread 8" $outp

done < "scaffolds.list.Arx.auto"
