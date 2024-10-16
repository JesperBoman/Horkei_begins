#!/bin/bash -l

while IFS= read -r sample
do

sbatch -J $sample -o slurm/$sample.output -e slurm/$sample.error  -A "Project ID" -t 7-00:00:00 -p core -n 2 getorganelle.sh $sample

done < "samples.list"
