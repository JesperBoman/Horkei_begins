#!/bin/bash -l

ml bioinfo-tools BEDTools/2.31.1 samtools/1.19

sample=$1
id=$2
Chr=$3
Chr_size=$4
wind_size=$5


tot_wind=$(awk -v Chr_size=$Chr_size -v wind_size=$wind_size 'function ceil(x, y){y=int(x); return(x>y?y+1:y)}; BEGIN{print ceil(Chr_size/wind_size)}')


for (( i=1; i<=$tot_wind; i++ ))
do

start=$(( 1+($i-1)*$wind_size ))

if [ $i -eq $tot_wind ]
then

end=$Chr_size

else

end=$(( $wind_size*$i ))

fi


samtools coverage -H -r $Chr:$start-$end $sample.$id.dedup.bam >> Z_cov/$sample.$id.Z.$wind_size.cov
done

#The tabulated form uses the following headings.

#rname	Reference name / chromosome
#startpos	Start position
#endpos	End position (or sequence length)
#numreads	Number reads aligned to the region (after filtering)
#covbases	Number of covered bases with depth >= 1
#coverage	Percentage of covered bases [0..100]
#meandepth	Mean depth of coverage
#meanbaseq	Mean baseQ in covered region
#meanmapq	Mean mapQ of selected read
