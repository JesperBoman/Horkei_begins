#!/bin/bash -l


while IFS= read -r sample
do

id="Arx"
ref="Reference/ilAriArta2.1_SH.fasta"

#Map using BWA
sbatch -J $sample -o slurm/$sample.$id.output -e slurm/$sample.$id.error  -A "Project ID"  -t 08:00:00 -p node -n 20 map_bwa.sh $sample $id $ref


done < "samples.list"
