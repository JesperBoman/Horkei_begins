#u!/usr/bin/awk -f

#Example usage: 
#awk -v sample=101 -f make_FJ_bed.awk <(zcat Chr_9.phased.vcf.gz) > 101.Chr9.fj.bed 

#Script also known as make_switch_bed3.awk

BEGIN{
currphase="NA";
pos=1;
}

NR==10{for(i=1; i<=NF; i++) {if($i==sample){break}}}

NR>10{

split($i, phase, "|"); 

if(phase[1] == phase[2]){
pos=$2;
}

else{
	if( (phase[1] > phase[2]) && $i !~/*/ ){ #I.e. phase looks like 1|0
		
		if(currphase == "NA"){pos=$2; currphase = 1; next}
		if(currphase == 1){pos=$2; next;}
		else{currphase = 1; print $1 "\t" pos-1 "\t" $2-1; pos=$2}
}
	else if( (phase[1] < phase[2]) && $i !~/*/ ){ #I.e. phase looks like 0|1
	
		if(currphase == "NA"){pos=$2; currphase = 2; next}
		if(currphase == 2){pos=$2; next;}
		else{currphase = 2; print $1 "\t" pos-1 "\t" $2-1; pos=$2;}
}
}
}
