#!/bin/bash -l


gzvcf="../03_Variant_calling/Arx.preBQSR.HQSNPs.vcf.gz"
outdir="Individual_allele_counts"


while IFS= read -r sample
do


sbatch -J $sample -o slurm/$sample.output -e slurm/$sample.error -A "Project ID" -t 0-01:00:00 -p core -n 1 ind_allele_counts.sh $sample $gzvcf $outdir


done < "samples.list"
