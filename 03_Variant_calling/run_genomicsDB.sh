#!/bin/bash -l

id="Arx"

while IFS= read -r scaffold
do

#Building genomics DB
sbatch -J genomicsDB.$id.$scaffold -o slurm/genomicsDB.$id.$scaffold.output -e slurm/genomicsDB.$id.$scaffold.error  -A "Project ID"  -t 0-08:00:00 -p core -n 4 genomicsDB.sh $id $scaffold

done < "scaffolds.list.Arx"
