#u!/usr/bin/awk -f

#Obtain agestis allele frequency at a set of sites
#A. agestis allele frequency is determined from a set of fixed differences, obtained via the fix_diff_2pops.awk script.

#Usage:
#awk -f evalpop_af.awk fixeddiff_noZ.list PI.HQSNPs.Horkei.frq.count > Horkei_fd_Agestis_freq

NR==FNR{
agestis_variant[$1 "\t" $2]=$4;
}
NR!=FNR{
locus=$1 "\t" $2;
if(locus in agestis_variant){

split($5, ref, ":");
split($6, alt, ":");

if((ref[2]+alt[2]) >0){
if(ref[1] == agestis_variant[locus] && ref[1] != 0 ){af=ref[2]/(ref[2]+alt[2])}
else if(alt[1] == agestis_variant[locus] && alt[1] != 0){af=alt[2]/(ref[2]+alt[2])}
	print locus "\t" agestis_variant[locus] "\t" af;
	}
}
}
