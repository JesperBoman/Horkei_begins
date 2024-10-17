#!/bin/bash -l

#Generate random intervals

#https://bedtools.readthedocs.io/en/latest/content/tools/random.html

module load bioinfo-tools BEDTools/2.29.2

genome="/crex/proj/uppstore2017185/b2014034_nobackup/Jesper/Aricia/Reference/ilAriArta2.1_SH_auto.genome"
length=499
num=1000

bedtools random -g $genome -l $length -n $num -seed 100 > 1000_random_autosomal_loci.bed
