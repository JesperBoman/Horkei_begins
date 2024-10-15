#!/bin/bash -l

Chr="Chr_Z"
Chr_size=45450413
wind_size=10000

id="Arx"


while IFS= read -r sample
do


sbatch -J $sample -o slurm/$sample.$id.Z_cov.output -e slurm/$sample.$id.Z_cov.error  -A "Project ID"  -t 01:00:00 -p core -n 1 bamcov.sh $sample $id $Chr $Chr_size $wind_size


done < "samples.list"
