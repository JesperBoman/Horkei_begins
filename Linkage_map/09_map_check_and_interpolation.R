library(ggplot2)
library(cobs)
library(plyr)

setwd("~/Downloads")

map<-read.table("pMcomb",)
map<- map[,1:4]

colnames(map)<-c("Chromosome", "Position", "Male_gen_pos", "Female_gen_pos")


map$Position2 <- gsub("\\*", "", map$Position)
map$Position2 <- as.numeric(map$Position2)

map$Type <- ifelse(grepl("\\*", map$Position), "Asterisk", "Normal")

ggplot(map, aes(x=Position2, y=Male_gen_pos))+geom_point(alpha=0.1)+
  facet_wrap(~Chromosome)
  

#Fix map so that each linkage group runs from 5' to 3' according to the reference assembly
map<-map[order(map$Position2),]

fixmap<-data.frame()

for(Chr in unique(map$Chromosome)){
  
mp<-map[map$Chromosome == Chr,]

if(mp[1,]$Male_gen_pos>5){
  mp$Male_gen_pos_flip<-0
  prev_cM<-max(mp$Male_gen_pos[1:5])
  prev_new_cM<-0
  
  for(i in 1:length(mp$Position2)){
    
    if(mp$Male_gen_pos[i]!=prev_cM){
      mp$Male_gen_pos_flip[i]<-prev_new_cM+(prev_cM-mp$Male_gen_pos[i])
      prev_cM<-mp$Male_gen_pos[i]
    }
    else{
      mp$Male_gen_pos_flip[i]<-prev_new_cM
    }
    
    prev_new_cM<-mp$Male_gen_pos_flip[i]
  }
}

else{
  mp$Male_gen_pos_flip <- mp$Male_gen_pos
}

fixmap<-rbind(fixmap, mp)

}



#Visualize fixed map using a Marey map
ggplot(fixmap, aes(x=Position2, y=Male_gen_pos_flip))+geom_point(alpha=0.1)+
  geom_point( aes(y=Male_gen_pos), col="red", alpha=0.1)+
  facet_wrap(~Chromosome)



#Interpol map with cobs

interpolmap<-data.frame()

for(Chr in unique(fixmap$Chromosome)){
  mp<-fixmap[fixmap$Chromosome == Chr,]

  print(Chr)


fit = cobs(mp$Position2, mp$Male_gen_pos_flip,
           method="uniform",
           constraint= "increase", 
           lambda=0.5, 
           degree=1, # for L1 roughness
           knots=seq(min(mp$Position2),max(mp$Position2),length.out=30), # desired nr of knots 
           tau=0.5) # to predict median

X = predict(fit,interval="none",z=mp$Position2)[,1]
predY = predict(fit,interval="none",z=mp$Position2)[,2]

#ggplot(data=NULL, aes(x=X, y=predY))+geom_point()

testDF<-as.data.frame(cbind(X=X, Y=predY))

testDF<-testDF[order(testDF$X),]

all(round(testDF$Y,5) == cummax(round(testDF$Y,5)))

#prev<-NA
#for(i in 1:length(testDF$X)){
 # if(i >2){
#    if(round(testDF$Y[i], 10) < round(prev,10)){print(i)}
#
#  }
# prev<-testDF$Y[i]
#
#  
#}

testDF$Y2 <- ifelse(testDF$Y<1e-10, 0, testDF$Y)
testDF$Y2 <- round(testDF$Y2, 10)

print(all(testDF$Y2== cummax(testDF$Y2)))

testDF$Chromosome <- Chr

interpolmap<-rbind(interpolmap, testDF)
}

ggplot(interpolmap, aes(x=X, y=Y2))+
  geom_point(data=fixmap, aes(x=Position2, y=Male_gen_pos_flip))+
  geom_line(col="red")+
  facet_wrap(~Chromosome)


for(Chr in unique(fixmap$Chromosome)){
print(ggplot(interpolmap[interpolmap$Chromosome == Chr,], aes(x=X, y=Y2))+
  geom_point(data=fixmap[fixmap$Chromosome == Chr,], aes(x=Position2, y=Male_gen_pos_flip))+
  geom_line(col="red")+
  facet_wrap(~Chromosome))
}


map_length_per_chr<-ddply(interpolmap, c("Chromosome"), function(x) c(max(x$Y2) ))
colnames(map_length_per_chr)<-c("Chromosome", "Map_length")

sum(map_length_per_chr$Map_length)


ggplot(map, aes(x=Position2, y=Male_gen_pos))+geom_point(alpha=0.1)+
  geom_point(data=NULL, aes(x=X, y=predY), col="red", alpha=0.1)

ggplot(map, aes(x=Position2, y=Male_gen_pos))+geom_point(alpha=0.1)+
  geom_point(data=testDF, aes(x=X, y=Y2), col="red", alpha=0.1)

 ArxLM.interpol.1.0.txt
