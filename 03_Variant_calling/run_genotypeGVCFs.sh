#!/bin/bash -l

id="Arx"
ref="../Reference/ilAriArta2.1_SH.fasta"

while IFS= read -r scaffold
do

#Genotype gVCFs
sbatch -J genotypeGVCFs.$id.$scaffold -o slurm/genotypeGVCFs.$id.$scaffold.output -e slurm/genotypeGVCFs.$id.$scaffold.error -A "Project ID" -t 0-24:00:00 -p node -n 1 genotypeGVCFs.sh $id $scaffold $ref

done < "scaffolds.list.Arx"

