
#Determine amount of coding novel transcripts

load("Human_logitModel.RData")
test <- read.table(file="cpatOut.dat",sep="\t",col.names=c("ID","mRNA","ORF","Fickett","Hexamer"))
test$prob <- predict(mylogit,newdata=test,type="response")
attach(test)
output <- cbind("mRNA_size"=mRNA,"ORF_size"=ORF,"Fickett_score"=Fickett,"Hexamer_score"=Hexamer,"coding_prob"=test$prob)
write.table(output,file="cpatOut",quote=F,sep="\t",row.names=ID)


####### cutout for human 
data <- read.table("cpatOut")
data

library(tidyverse)

#Select all novel transcripts
datanovel <- data %>% 
  mutate(novel = grepl("MSTRG",rownames(data))) %>% 
  filter(novel ==TRUE)

#select all transcripts with a coding_prob over the threshold
datanovelcut <- datanovel %>% 
  filter(datanovel$coding_prob > 0.364)
  
head(datanovelcut)

#percentage protein coding
dim(datanovelcut)[1] / dim(datanovel)[1] *100

# 76.48928% are protein coding

write.table(datanovelcut,"CPAT_datanovelcut.txt")
