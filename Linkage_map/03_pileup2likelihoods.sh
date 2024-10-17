#!/bin/bash -l


ml bioinfo-tools samtools/1.19

LMdir="Lep-MAP3"

samtools mpileup -q 10 -Q 10 -s $(cat bam.files.list)|java -cp $LMdir/bin/ Pileup2Likelihoods|gzip >post.gz
