library(ggplot2)

setwd("~/Downloads")

#### AUTOSOMES ####
ahmm_data<-data.frame()
for(sample in c(105,119,120,127,128,135,151,159,167,174,175,183,191)){
  tmp<- read.table(paste(sample, ".posterior", sep=""), header=T)
  tmp$Sample <- sample
  ahmm_data<-rbind(ahmm_data, tmp)
  print(paste(sample, "done!"))
}
ahmm_data$GT <- NA
ahmm_data$GT <- ifelse(ahmm_data$X2.0>0.5, "Arx_HOM", ahmm_data$GT)
ahmm_data$GT <- ifelse(ahmm_data$X1.1>0.5, "HET", ahmm_data$GT)
ahmm_data$GT <- ifelse(ahmm_data$X0.2>0.5, "Age_HOM", ahmm_data$GT)

ahmm_data$Arx_freq <- NA
ahmm_data$Arx_freq <- ifelse(ahmm_data$GT == "Arx_HOM", 1, ahmm_data$Arx_freq)
ahmm_data$Arx_freq <- ifelse(ahmm_data$GT == "HET", 0.5, ahmm_data$Arx_freq)
ahmm_data$Arx_freq <- ifelse(ahmm_data$GT == "Age_HOM", 0, ahmm_data$Arx_freq)

table(ahmm_data$GT)
ahmm_data$Chr_num <- as.numeric(gsub("Chr_", "", ahmm_data$chrom))

ahmm_data_avg <- aggregate(Arx_freq~chrom+position+Chr_num, ahmm_data, mean)

length(ahmm_data_avg[ahmm_data_avg$Arx_freq == 0,]$chrom)/length(ahmm_data_avg$chrom)
length(ahmm_data_avg[ahmm_data_avg$Arx_freq == 1,]$chrom)/length(ahmm_data_avg$chrom)


write.table(ahmm_data_avg, file="ahmm_data_avg_6733_auto.txt", quote=F,col.names = F, row.names=F, sep="\t")


#### Autosomes - weighted means ####

prevChr=""
prevPos=0
j=1
ahmm_data_avg$Block <- NA
ahmm_data_avg$wt <- NA
for(i in 1:length(ahmm_data_avg$position)){
  if(i %% 1000 == 0){j=j+1}
  if(ahmm_data_avg$chrom[i] != prevChr){
    j=1
    ahmm_data_avg$wt[i] <- ahmm_data_avg$position[i]
  }
  else{
    ahmm_data_avg$wt[i] <- ahmm_data_avg$position[i]-prevPos
  }
  ahmm_data_avg$Block[i] <- j 
  prevChr=ahmm_data_avg$chrom[i]
  prevPos=ahmm_data_avg$position[i]
}

arxfrqblocks<-sapply(split(ahmm_data_avg, list(ahmm_data_avg$chrom, ahmm_data_avg$Block)), function(x) weighted.mean(x$rrFix_arx_freq,x$wt))
arxfrqblocks<-sapply(split(ahmm_data_avg, list(ahmm_data_avg$chrom)), function(x) weighted.mean(x$rrFix_arx_freq,x$wt))

min(arxfrqblocks)
max(arxfrqblocks)



#### Z chromosome ####
ahmm_data_Z<-data.frame()
for(sample in c(105,119,120,127,128,135,151,159,167,174,175,183,191)){
  tmp<- read.table(paste(sample, ".Z5k.posterior", sep=""), header=T)

  if(sample == 120 | sample == 151){
    colnames(tmp)<-c("chrom","position", "X2.0", "X0.2") 
    tmp$X1.1 <- NA
    tmp<-tmp[,c(1,2,3,5,4)]
    tmp$Sex <- "F"
  }
  else{
    tmp$Sex <- "M"
  }
  tmp$Sample <- sample
  ahmm_data_Z<-rbind(ahmm_data_Z, tmp)
  print(paste(sample, "done!"))
}

ahmm_data_Z$GT <- NA
ahmm_data_Z$GT <- ifelse(ahmm_data_Z$X2.0>0.5, "Arx_HOM", ahmm_data_Z$GT)
ahmm_data_Z$GT <- ifelse(ahmm_data_Z$X1.1>0.5, "HET", ahmm_data_Z$GT)
ahmm_data_Z$GT <- ifelse(ahmm_data_Z$X0.2>0.5, "Age_HOM", ahmm_data_Z$GT)

ahmm_data_Z$Arx_freq <- NA
ahmm_data_Z$Arx_freq <- ifelse(ahmm_data_Z$GT == "Arx_HOM" & ahmm_data_Z$Sex == "M", 1, ahmm_data_Z$Arx_freq)
ahmm_data_Z$Arx_freq <- ifelse(ahmm_data_Z$GT == "Arx_HOM" & ahmm_data_Z$Sex == "F", 0.5, ahmm_data_Z$Arx_freq)
ahmm_data_Z$Arx_freq <- ifelse(ahmm_data_Z$GT == "HET", 0.5, ahmm_data_Z$Arx_freq)
ahmm_data_Z$Arx_freq <- ifelse(ahmm_data_Z$GT == "Age_HOM", 0, ahmm_data_Z$Arx_freq)

ahmm_data_Z$Chr_num <- as.numeric(gsub("Chr_", "", ahmm_data_Z$chrom))

ahmm_data_avg_Z <- aggregate(Arx_freq~position, ahmm_data_Z, mean)
ahmm_data_avg_Z_m <- aggregate(Arx_freq~position, ahmm_data_Z[ahmm_data_Z$Sex == "M",], mean)


#### Z chromosome - weighted means ####
prevChr=""
prevPos=0
j=1
ahmm_data_avg_Z$Block <- NA
ahmm_data_avg_Z$wt <- NA
ahmm_data_avg_Z$chrom <- "Chr_Z"
for(i in 1:length(ahmm_data_avg_Z$position)){
  if(i %% 100 == 0){j=j+1}
  if(ahmm_data_avg_Z$chrom[i] != prevChr){
    j=1
    ahmm_data_avg_Z$wt[i] <- ahmm_data_avg_Z$position[i]
  }
  else{
    ahmm_data_avg_Z$wt[i] <- ahmm_data_avg_Z$position[i]-prevPos
  }
  ahmm_data_avg_Z$Block[i] <- j 
  prevChr=ahmm_data_avg_Z$chrom[i]
  prevPos=ahmm_data_avg_Z$position[i]
}

weighted.mean(ahmm_data_avg_Z$Arx_freq, ahmm_data_avg_Z$wt)


wilcox.test(ahmm_data_avg_Z$Arx_freq, ahmm_data_avg$Arx_freq)


#### Auto + Z plot ####

head(ahmm_data_avg)
head(ahmm_data_avg_Z)

ahmm_data_avg_Z$Chr_num<-23

ahmm_data_comb<-rbind(ahmm_data_avg, ahmm_data_avg_Z[,c(6,1,7,2,3,4,5 )])



ggplot(data=ahmm_data_comb[ahmm_data_comb$Chr_num > 0 ,], aes(x=position, y=Arx_freq))+geom_line(col="red", alpha=0.5)+
 xlab("Position")+
  ylab(expression(paste(italic(A), "." ,italic(artaxerxes), " frequency")))+
  theme_classic()+
 facet_grid(~Chr_num, scales = 'free_x', space = 'free_x', switch='x')+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.spacing = unit(0, "lines")) +
  scale_x_continuous(expand = c(0, 0))+
  theme(strip.text = element_text(size = 20))+
  theme(title= element_text(size=16), legend.position = "none", panel.border = element_rect(colour = "black", fill=NA, size=1), plot.title = element_text(face = "bold", hjust = 0.5), axis.text.y=element_text(size=15, colour="black"), axis.title=element_text(size=18), legend.text=element_text(size=16),  legend.title=element_text(size=18))
