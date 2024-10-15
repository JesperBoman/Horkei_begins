#!/bin/bash -l

ml bioinfo-tools plink2/2.00-alpha-3.7-20221024

 
prefix="ArxRef.preBQSR.auto"

w=50kb
s=1 #Step size in SNPs
r=0.5

plink2 --threads 10 --bfile $prefix --indep-pairwise $w $s $r --allow-extra-chr --bad-ld --out $prefix.LD.$w.$s.$r

plink2 --threads 10 --bfile $prefix --extract $prefix.LD.$w.$s.$r.prune.in --make-bed --allow-extra-chr --out $prefix.LD.$w.$s.$r
