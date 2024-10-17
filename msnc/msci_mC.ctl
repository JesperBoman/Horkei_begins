seed =  1

#No split-off before hybridization

seqfile = 1000_random_autosomal_loci_mod.phy
Imapfile = samples.IMAP.txt
outfile = 1000auto.msci_mC.results/out_1000auto.txt
mcmcfile = 1000auto.msci_mC.results/mcmc_1000auto.txt

# fixed number of species/populations 
speciesdelimitation = 0 * fixed species tree

# fixed species tree
speciestree = 0


species&tree = 3 Artax Horkei Agestis
34 26 28
((Artax, (Horkei)H[&phi=0.5,&tau-parent=no])S, (H[&tau-parent=no], Agestis) T)R;

usedata = 1  * 0: no data (prior); 1:seq like

cleandata = 1    * remove sites with ambiguity data (1:yes, 0:no)?

threads = 20 1 1


thetaprior = 3 0.04 e # gamma(a, b) for theta (estimate theta)
tauprior = 3 0.2 # gamma(a, b) for root tau & Dirichlet(a) for other tau's
phiprior = 1 1

# finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr
finetune =  1: 0.01 0.02 0.03 0.04 0.05 0.01 0.01

# MCMC samples, locusrate, heredityscalars, Genetrees
print = 1 0 0 0   * 
burnin = 50000
sampfreq = 100
nsample = 10000
