sample.info$Admixture_taxa <- ifelse(sample.info$Short.ID == 192, "Blekingehorkei", sample.info$Admixture_taxa)

FJdf<-read.table("FJvis_Chr1.9800003-9801446.bed") #Fronm FJvis_prep.sh

colnames(FJdf)<-c("Chromosome", "Start", "End", "Sample")

ggplot(FJdf , aes(x=(Start+End)/2, y=Sample))+geom_tile()+
  scale_fill_viridis_d(option="viridis")

Arxsamps<-sample.info[sample.info$Admixture_taxa == "Artax",]$Short.ID

FJdf<-rbind(FJdf, cbind(Chromosome="NA", Start="NA", End="NA", Sample=Arxsamps))

FJdf$Start<-as.numeric(FJdf$Start)
FJdf$End<-as.numeric(FJdf$End)
FJdf$Sample<-as.numeric(FJdf$Sample)

FJdf$Taxa<-NA
for(i in 1:length(sample.info$Short.ID )){
  matches <-  sample.info$Short.ID [i] == FJdf$Sample 
  m_list <- (1:length(matches))[matches]
  FJdf$Taxa[m_list] <- sample.info$Admixture_taxa[i]
}


FJdf$Taxa <- factor(FJdf$Taxa, levels=c("Agestis", "Horkei", "Blekingehorkei", "Artax"))

FJdf<-FJdf[order(FJdf$Sample),]
FJdf<-FJdf[order(FJdf$Taxa),]

FJdf$Sample <- factor(FJdf$Sample,levels = unique(FJdf$Sample) )



ggplot(data = FJdf)+
  geom_segment(aes(x = Start, xend = End, y = Sample, yend = Sample, colour=Taxa), size = 5, alpha = 1) +
  theme_bw()+
  ylab("")+
  xlab("Position")+
  scale_colour_manual(values = c("orange", "darkgreen", "purple", "brown4"), labels=c(expression(italic("A. agestis")),  expression(italic("horkei")), "Blekingehorkei", expression(italic("A. artaxerxes"))), name="Ancestry"  )+
  theme(axis.text.y=element_blank(), axis.ticks.y=element_blank())+
  theme(aspect.ratio=1, title= element_text(size=16), legend.position = "right", panel.border = element_rect(colour = "black", fill=NA, size=1), plot.title = element_text(face = "bold", hjust = 0.5), axis.text=element_text(size=15, colour="black"), axis.title=element_text(size=18), legend.text=element_text(size=16),  legend.title=element_text(size=18))

