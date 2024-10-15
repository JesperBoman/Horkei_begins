#!/bin/bash -l


#

id="Arx"
ref="Reference/ilAriArta2.1_SH.fasta"
bamdir="../02_Mapping"


while IFS= read -r sample
do

while IFS= read -r scaffold
do

#Haplotype calling
sbatch -J $sample.$id.$scaffold -o slurm/$sample.$id.$scaffold.output -e slurm/$sample.$id.$scaffold.error -A "Project ID" -t 0-12:00:00 -p core -n 1 hap_call.sh $sample $id $scaffold $ref $bamdir

done < "scaffolds.list.Arx"

done < "samples.list"
