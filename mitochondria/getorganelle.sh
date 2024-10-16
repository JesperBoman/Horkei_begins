#!/bin/bash -l

conda activate getorganelle

dir="../01_Trimming/trimmed_files"

sample=$1
R1="P28119_${sample}_S*_L003_R1_001_val_1.fq.gz"
R2="P28119_${sample}_S*_L003_R2_001_val_2.fq.gz"

#Add --continue as an option to use in continue-mode
get_organelle_from_reads.py -1 $dir/$R1 -2 $dir/$R2 -t 2 -o ${sample}.mt -F animal_mt -R 10 -k 21,45,65,85,105 --disentangle-time-limit 600000000
