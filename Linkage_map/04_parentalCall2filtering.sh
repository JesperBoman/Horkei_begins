#!/bin/bash -l

module load bioinfo-tools

LMdir="Lep-MAP3"
INPUT_DIR="../02_Mapping"

PEDIGREE="LM_pedigree_no361.txt"
MISS=0


zcat $INPUT_DIR/post.gz |java -cp $LMdir/bin/ ParentCall2 data=$PEDIGREE posteriorFile=- ZLimit=2 removeNonInformative=1 |gzip > data.call.gz 2> parentCall.log

zcat data.call.gz |java -cp $LMdir/bin/ Filtering2 data=- dataTolerance=0.001 missingLimit=$MISS removeNonInformative=1  |gzip > data.filt.$MISS.call.gz 2> data.filt.$MISS.call.log
