#!/bin/bash -l


ml bioinfo-tools plink2/2.00-alpha-3.7-20221024


#Make .bed-file 
plink2 --threads 4 --pedmap ArxRef.preBQSR.auto --allow-extra-chr --make-bed -out ArxRef.preBQSR.auto
