#!/bin/bash -l

date
echo "$1 has BEGUN"

unset DISPLAY

id=$2

module load bioinfo-tools QualiMap/2.2.1

qualimap bamqc -bam $1.$id.dedup.bam -nt 8 -outdir qualimap_results/$1.$id -outfile $1.$id.qualimap.report.pdf -outformat pdf

date
echo "$1 is DONE"
