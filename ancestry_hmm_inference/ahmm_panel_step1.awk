#u!/usr/bin/awk -f

#ahmm_panel_step1.awk
#usage: awk -f ahmm_panel_step1.awk allele_counts_from_vcftools_pop1 allele_counts_from_vcftools_pop2

FNR>1 && $3 == 2{

split($5, REF, ":"); split($6, ALT, ":");

if(FNR==NR){
pop1REF[$1 "\t" $2]=REF[2];
pop1ALT[$1 "\t" $2]=ALT[2]
}

if(FNR!=NR){
pop2REF[$1 "\t" $2]=REF[2];
pop2ALT[$1 "\t" $2]=ALT[2]
}


  }
  
END{for (locus in pop1REF){

	if(pop1REF[locus]/(pop1REF[locus]+pop1ALT[locus]) != pop2REF[locus]/(pop2REF[locus]+pop2ALT[locus]) ){
		print locus "\t" pop1REF[locus] "\t" pop1ALT[locus] "\t" pop2REF[locus] "\t" pop2ALT[locus]
	}

}}
