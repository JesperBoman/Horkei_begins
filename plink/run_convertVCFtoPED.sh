#!/bin/bash -l

faidx="../Reference/ilAriArta2.1_SH.fasta.fai"

gzvcf="../03_Variant_calling/Arx.preBQSR.HQSNPs.dedup.g.vcf.gz"

id="Arx"

#Make chrom map

awk '{print $1 "\t" $1}' $faidx > $id.chrMap

chrMap="$id.chrMap"
outprefix="ArxRef.preBQSR.auto"

#Genotype gVCFs
sbatch -J convertVCFtoPED -o slurm/convertVCFtoPED.output -e slurm/convertVCFtoPED.error -A "Project ID"  -t 0-5:00:00 -p core -n 1 convertVCFtoPED.sh $gzvcf $chrMap $outprefix
