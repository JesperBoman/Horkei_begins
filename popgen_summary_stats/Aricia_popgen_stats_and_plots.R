library(ggplot2)
library(ggpubr)

setwd("~/Downloads")

faidx <- read.table("ilAriArta2.1_SH.fasta.fai")
chr_file <- faidx[,1:2]
chr_file$Start <- 1 
colnames(chr_file) <- c("Chromosome", "End", "Start")
chr_file$Chr_num <- as.numeric(gsub("Chr_", "", chr_file$Chromosome))
chr_file$Chr_num <- ifelse(chr_file$Chromosome == "Chr_Z", 23, chr_file$Chr_num)
chr_file$Chr_type <- ifelse(chr_file$Chromosome  == "Chr_Z", "Z", NA )
chr_file$Chr_type <- ifelse(chr_file$Chromosome  != "Chr_Z" & chr_file$Chromosome  != "mitochondrion" & chr_file$Chromosome  != "scaffold_29", "A", chr_file$Chr_type  )

#These comb files are made by combining autosomes and Z chromosomes after pixy analysis
dxy <- read.table("comb.dxy.txt", header=T)
fst <- read.table("comb.fst.txt", header=T)
pi <- read.table("comb.pi.txt", header=T)

fst$Chr_num <- as.numeric(gsub("Chr_", "", fst$chromosome))
fst$Chr_num <- ifelse(fst$chromosome == "Chr_Z", 23, fst$Chr_num)
dxy$Chr_num <- as.numeric(gsub("Chr_", "", dxy$chromosome))
dxy$Chr_num <- ifelse(dxy$chromosome == "Chr_Z", 23, dxy$Chr_num)
pi$Chr_num <- as.numeric(gsub("Chr_", "", pi$chromosome))
pi$Chr_num <- ifelse(pi$chromosome == "Chr_Z", 23, pi$Chr_num)

fst$Chr_type <- ifelse(fst$chromosome  == "Chr_Z", "Z", NA )
fst$Chr_type <- ifelse(fst$chromosome  != "Chr_Z" , "A", fst$Chr_type)
dxy$Chr_type <- ifelse(dxy$chromosome  == "Chr_Z", "Z", NA )
dxy$Chr_type <- ifelse(dxy$chromosome  != "Chr_Z" , "A", dxy$Chr_type)
pi$Chr_type <- ifelse(pi$chromosome  == "Chr_Z", "Z", NA )
pi$Chr_type <- ifelse(pi$chromosome  != "Chr_Z" , "A", pi$Chr_type)

#OVERALL STATS ####

#### Pi - set chromosome type to Z or A and choose population ####

df_sub<-pi[pi$pop == "horkei" & pi$Chr_type == "Z",]

#This is the correct pi for an overall estimate
round(sum(df_sub$count_diffs, na.rm=T)/sum(df_sub$count_comparisons, na.rm=T), 4)

#The following pi is incorrect as an estimate of overall pi but it's correct if you want the mean across windows
round(mean(df_sub$avg_pi, na.rm=T), 4)

#Both these are generally quite similar if windows on average have similar amounts of data (i.e. coverage)

N<-length(df_sub[!is.na(df_sub$avg_pi),]$avg_pi)
margins<-qt(0.975,df=N-1)*(sd(df_sub$avg_pi, na.rm=T))/sqrt(N)
round(mean(df_sub$avg_pi, na.rm=T)-margins, 4)
round(mean(df_sub$avg_pi, na.rm=T)+margins, 4)

#### FST - set chromosome type to Z or A ####

df_sub<-fst[fst$pop1 == "horkei" & fst$pop2 == "age" & fst$Chr_type == "Z",]
round(mean(df_sub$avg_hudson_fst, na.rm=T), 4)
N<-length(df_sub[!is.na(df_sub$avg_hudson_fst),]$avg_hudson_fst)
margins<-qt(0.975,df=N-1)*(sd(df_sub$avg_hudson_fst, na.rm=T))/sqrt(N)
round(mean(df_sub$avg_hudson_fst, na.rm=T)-margins, 4)
round(mean(df_sub$avg_hudson_fst, na.rm=T)+margins, 4)


df_sub<-fst[fst$pop1 == "arx" & fst$pop2 == "horkei" & fst$Chr_type == "Z",]
round(mean(df_sub$avg_hudson_fst, na.rm=T), 4)
N<-length(df_sub[!is.na(df_sub$avg_hudson_fst),]$avg_hudson_fst)
margins<-qt(0.975,df=N-1)*(sd(df_sub$avg_hudson_fst, na.rm=T))/sqrt(N)
round(mean(df_sub$avg_hudson_fst, na.rm=T)-margins, 4)
round(mean(df_sub$avg_hudson_fst, na.rm=T)+margins, 4)


df_sub<-fst[fst$pop1 == "arx" & fst$pop2 == "age" & fst$Chr_type == "Z",]
round(mean(df_sub$avg_hudson_fst, na.rm=T), 4)
N<-length(df_sub[!is.na(df_sub$avg_hudson_fst),]$avg_hudson_fst)
margins<-qt(0.975,df=N-1)*(sd(df_sub$avg_hudson_fst, na.rm=T))/sqrt(N)
round(mean(df_sub$avg_hudson_fst, na.rm=T)-margins, 4)
round(mean(df_sub$avg_hudson_fst, na.rm=T)+margins, 4)


##### PLOTS #####


#### FST ####
ggplot(data=fst[ fst$pop1 == "arx" & fst$pop2 == "age",], aes(x=(window_pos_1+window_pos_2)/2, y=avg_hudson_fst))+geom_point(size=0.2, alpha=0.2)+
 geom_smooth(method="loess", span = 0.01, method.args = list(degree=1), col="#1E88E5", fill="#1E88E5", size=0.6)+
scale_color_manual(values = c("#D81B60", "#FFC107") ) +
  scale_fill_manual(values = c("#D81B60", "#FFC107") ) +
  xlab("Position")+
  ylab(expression(italic("F"["ST"])))+
  theme_classic()+
  facet_grid(~Chr_num, scales = 'free_x', space = 'free_x', switch='x')+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.spacing = unit(0, "lines")) +
  scale_x_continuous(expand = c(0, 0))+
  ylim(0, 1)+
 theme(title= element_text(size=16), legend.position = "none", panel.border = element_rect(colour = "black", fill=NA, size=1), plot.title = element_text(face = "bold", hjust = 0.5), axis.text=element_text(size=15, colour="black"), axis.title=element


#### PI ####
ggplot(data=pi[pi$Chr_num < numChr & pi$pop != "blekingehorkei",], aes(x=(window_pos_1+window_pos_2)/2, y=avg_pi, col=pop, fill=pop))+geom_point(size=0.2, alpha=0.2)+
  geom_smooth(method="loess", span = 0.02, method.args = list(degree=1), size=0.6)+
 xlab("Position")+
  ylab(expression(italic(π)))+
  theme_classic()+
  scale_fill_manual(values = c("orange","brown4", "darkgreen"), labels=c("Agestis", "Artaxerxes", "horkei"), name="Ancestry"  ) +
  scale_colour_manual(values = c("orange","brown4", "darkgreen"), labels=c("Agestis", "Artaxerxes", "horkei"), name="Ancestry"  ) +
  facet_grid(~Chr_num, scales = 'free_x', space = 'free_x', switch='x')+
  theme(axis.text.x = element_blank(),
       axis.ticks.x = element_blank(),
       panel.spacing = unit(0, "lines")) +
  scale_x_continuous(expand = c(0, 0))+
  ylim(0,0.025)+
  theme(title= element_text(size=16), legend.position = "none", panel.border = element_rect(colour = "black", fill=NA, size=1), plot.title = element_text(face = "bold", hjust = 0.5), axis.text=element_text(size=15, colour="black"), axis.title=element_text(size=18), legend.text=element_text(size=16),  legend.title=element_text(size=18))
