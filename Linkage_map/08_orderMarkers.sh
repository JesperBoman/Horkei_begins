#!/bin/bash -l

#Inspired by: https://github.com/clairemerot/lepmap3_pipeline and https://github.com/karinnasvall/Leptidea_chromosome_research2022/tree/main/Scripts/Linkage_map



LMdir="Lep-MAP3"

CPU=20
MISS=0
LODL=7


REFINE_STEPS=2



IN_FILE=data.filt.0.call.mod.gz
MAP_FILE=maleInfMap.LODL7.mod.txt
NB_CHR=23


#ITE="numMergeIterations=2" #will merge several iterations
#RECOMB_2="recombination2=0"
PHASE="outputPhasedData=1" #if we want phased data as output. 
#SCALE="scale=0.04 1"


for j in $(seq $NB_CHR)
do
echo "assessing marker order for LG" $j "1st step"


OUT_FILE="order_LG/order_"$MISS".LODL."$LODL".LG"$j".1.txt"


zcat $IN_FILE | java -cp $LMdir/bin/ OrderMarkers2 map=$MAP_FILE numThreads=$CPU data=- usePhysical=1 useMorgan=1 $PHASE chromosome=$j > $OUT_FILE 2> $OUT_FILE.log


	for k in $(seq $REFINE_STEPS)
	 	do
 	IT=$[$k + 1]
	echo "assessing marker order for LG" $j "refining step" $IT
 	OUT_FILE="order_LG/order_"$MISS".LODL."$LODL".LG"$j"."$IT".txt"
	ORDER_FILE="order_LG/order_"$MISS".LODL."$LODL".LG"$j"."$k".txt"

 #One may want to use improveOrder=1 in the following OrderMarkers2 command
 #N.B. Claire Merot in her original implementation (https://github.com/clairemerot/lepmap3_pipeline/blob/master/01_scripts/07_run_order_marker.sh), does not use improveOrder=1
 	zcat $IN_FILE | java -cp $LMdir/bin/ OrderMarkers2 evaluateOrder=$ORDER_FILE  numThreads=$CPU data=- usePhysical=1 useMorgan=1 $PHASE chromosome=$j > $OUT_FILE  2> $OUT_FILE.log
	
	done

awk -vFS="\t" -vOFS="\t" '(NR==FNR){s[NR-1]=$0}(NR!=FNR){if ($1 in s) $1=s[$1];print}' snps.0.mod.txt  $OUT_FILE > "physMapped/physMapped_order_"$MISS".LODL."$LODL".LG"$j"."$IT".txt"  
done
