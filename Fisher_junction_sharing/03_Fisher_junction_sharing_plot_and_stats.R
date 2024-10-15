library(ggplot2)
library(corrplot)
library(RColorBrewer)
library(plyr)
library(readr)


setwd("~/Downloads")
sample.info <- read.table(file = file.choose(), header = T)
sample.info$Short.ID <- gsub("P28119_", "", sample.info$NGI_ID)
sample.info <- sample.info[order(sample.info$Short.ID),]

#Gsubbing å/ä/ö in this way may not work dependent on input file and/or R version
sample.info$Locality<-gsub("\\x9a", "ö", sample.info$Locality)
#

df<-read.table("fisher.junction.pairwise.results.norm", fill = TRUE)

colnames(df)<-c("Chromosome","s1", "s2", "Overlap", "Overlap_counts", "s1_self", "s2_self", "Overlap_norm")

#Recalculate normalization over all chromosomes, alternatively use data frame df only and visualize per chromosome
df_total <- ddply(df, c("s1", "s2"), function(x) c(Overlap_counts=sum(x$Overlap_counts, na.rm=T), s1_self=sum(x$s1_self, na.rm=T), s2_self=sum(x$s2_self, na.rm=T)))
df_total$Overlap_norm <- 2*(df_total$Overlap_counts/(df_total$s1_self+df_total$s2_self))

#Row-bind the dataframe to itself to make a quadratic plot
df_total<-rbind(df_total, cbind(s1=df_total$s2, s2=df_total$s1, Overlap_counts=df_total$Overlap_counts, s1_self=df_total$s1_self, s2_self=df_total$s2_self, Overlap_norm=df_total$Overlap_norm))
df_total$Overlap_norm <- as.numeric(df_total$Overlap_norm)


#### PLOTTING ####
                  
#Make a matrix of the pairwise sharing data
m<-xtabs(Overlap_norm ~ s1 + s2, data=df_total)
diag(m)<-NA

rownames(m)<-sample.info$Admixture_taxa
colnames(m)<-sample.info$Locality


#Visualize Fisher junction sharing patterns using corrplot
corrplot(m,  method="color", is.corr = FALSE, type="full", order = "hclust",
         col=colorRampPalette(c("white","blue", "orange", "red", "brown"))(200),
         diag=F,
         addrect=3,
         number.cex = 0.5,
         cl.align.text="l"
)



#### SUMMARY STATS ####

#Average overlap
df_total$s1_taxa<-NA
for(i in 1:length(sample.info$Short.ID )){
  matches <-  sample.info$Short.ID [i] == df_total$s1 
  m_list <- (1:length(matches))[matches]
  df_total$s1_taxa[m_list] <- sample.info$Admixture_taxa[i]
}

df_total$s2_taxa<-NA
for(i in 1:length(sample.info$Short.ID )){
  matches <-  sample.info$Short.ID [i] == df_total$s2 
  m_list <- (1:length(matches))[matches]
  df_total$s2_taxa[m_list] <- sample.info$Admixture_taxa[i]
}

Hork_Hork_overlap<-df_total[(df_total$s1_taxa == "Horkei" & df_total$s2_taxa == "Horkei") & df_total$s1 != df_total$s2,]$Overlap_norm
Hork_Hork_overlap<-Hork_Hork_overlap[1:(length(Hork_Hork_overlap)/2)]
mean(Hork_Hork_overlap)

Arx_Arx_overlap<-df_total[(df_total$s1_taxa == "Artax" & df_total$s2_taxa == "Artax") & df_total$s1 != df_total$s2,]$Overlap_norm
Arx_Arx_overlap<-Arx_Arx_overlap[1:(length(Arx_Arx_overlap)/2)]
mean(Arx_Arx_overlap)

Age_Age_overlap<-df_total[(df_total$s1_taxa == "Agestis" & df_total$s2_taxa == "Agestis") & df_total$s1 != df_total$s2,]$Overlap_norm
Age_Age_overlap<-Age_Age_overlap[1:(length(Age_Age_overlap)/2)]
mean(Age_Age_overlap)





Arx_Hork_overlap<-df_total[(df_total$s1_taxa == "Horkei" | df_total$s2_taxa == "Horkei") & df_total$s1 != df_total$s2 & (df_total$s1_taxa == "Artax" | df_total$s2_taxa == "Artax"),]$Overlap_norm
Arx_Hork_overlap<-Arx_Hork_overlap[1:(length(Arx_Hork_overlap)/2)]
mean(Arx_Hork_overlap)

Age_Hork_overlap<-df_total[(df_total$s1_taxa == "Horkei" | df_total$s2_taxa == "Horkei") & df_total$s1 != df_total$s2 & (df_total$s1_taxa == "Agestis" | df_total$s2_taxa == "Agestis"),]$Overlap_norm
Age_Hork_overlap<-Age_Hork_overlap[1:(length(Age_Hork_overlap)/2)]

mean(Arx_Hork_overlap)/(mean(Age_Hork_overlap)+mean(Arx_Hork_overlap))


Arx_Bhork_overlap<-df_total[(df_total$s1_taxa == "Blekingehorkei" | df_total$s2_taxa == "Blekingehorkei") & df_total$s1 != df_total$s2 & (df_total$s1_taxa == "Artax" | df_total$s2_taxa == "Artax"),]$Overlap_norm
Arx_Bhork_overlap<-Arx_Bhork_overlap[1:(length(Arx_Bhork_overlap)/2)]

Age_Bhork_overlap<-df_total[(df_total$s1_taxa == "Blekingehorkei" | df_total$s2_taxa == "Blekingehorkei") & df_total$s1 != df_total$s2 & (df_total$s1_taxa == "Agestis" | df_total$s2_taxa == "Agestis"),]$Overlap_norm
Age_Bhork_overlap<-Age_Bhork_overlap[1:(length(Age_Bhork_overlap)/2)]

mean(Arx_Bhork_overlap)/(mean(Age_Bhork_overlap)+mean(Arx_Bhork_overlap))

mean(Arx_Bhork_overlap)
mean(Age_Bhork_overlap)

Hork_Bhork_overlap<-df_total[(df_total$s1_taxa == "Blekingehorkei" | df_total$s2_taxa == "Blekingehorkei") & df_total$s1 != df_total$s2 & (df_total$s1_taxa == "Horkei" | df_total$s2_taxa == "Horkei"),]$Overlap_norm
Hork_Bhork_overlap<-Hork_Bhork_overlap[1:(length(Hork_Bhork_overlap)/2)]
mean(Hork_Bhork_overlap)
