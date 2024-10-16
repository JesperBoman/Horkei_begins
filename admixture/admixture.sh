#!/bin/bash -l

ml bioinfo-tools ADMIXTURE/1.3.0

infile=$1
threads=$2
K=$3
br=$4

admixture --cv -j$threads -B$br $infile $K
