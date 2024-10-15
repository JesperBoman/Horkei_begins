#!/bin/bash -l



while IFS= read -r sample
do

sbatch -J $sample -o slurm/$sample.output -e slurm/$sample.error -A "project ID" -t 0-03:00:00 -p core -n 16 trimmer.sh $sample

done < "samples.list"
