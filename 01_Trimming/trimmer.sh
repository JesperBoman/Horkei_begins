#!/bin/bash -l
#Trimming 

module load bioinfo-tools TrimGalore/0.6.1 cutadapt/4.0


dir="reads"


sample=$1
R1=$(ls $dir | grep $sample | grep "R1")
R2=$(ls $dir | grep $sample | grep "R2")

trim_galore \
            --quality 30 \
            --paired \
            --illumina \
            --phred33 \
            --stringency 1 \
            -e 0.1 \
            --length 30 \
            --gzip \
	          --cores 4 \
            --output_dir trimmed_files \
            --fastqc \
            $dir/$R1 \
            $dir/$R2
