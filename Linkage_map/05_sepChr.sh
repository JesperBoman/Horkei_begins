#!/bin/bash -l

LMdir="Lep-MAP3"

MISS=0

SIZEL=100 # to exclude chromosome with less than X markers (adjust depending on the data)
LODL=7
CPU=20

zcat data.filt.$MISS.call.gz | java -cp $LMdir/bin/ SeparateChromosomes2 data=- lodLimit=$LODL numThreads=$CPU sizeLimit=$SIZEL informativeMask=1 > maleInfMap.LODL${LODL}.sizeL${SIZEL}.txt
