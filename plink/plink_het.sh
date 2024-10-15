#!/bin/bash -l

ml bioinfo-tools plink2/2.00-alpha-3.7-20221024


prefix="ArxRef.preBQSR.auto.LD.50kb.1.0.5"


plink2 --threads 2 --bfile $prefix --het --allow-extra-chr --bad-freqs --out $prefix
