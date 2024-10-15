#!/bin/bash -l

while IFS= read -r sample
do

id="Arx"

sbatch -J $sample -o slurm/$sample.$id.qualimap.output -e slurm/$sample.$id.qualimap.error  -A "Project ID"  -t 02:00:00 -p core -n 8 qualimapper.sh $sample $id

done < "samples.list"
