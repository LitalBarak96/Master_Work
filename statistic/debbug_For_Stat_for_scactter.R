data <- as.data.frame(rnorm(15))

shapiro.test(data$`rnorm(15)`)



setwd("D:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped")
comb1<-as.data.frame(read.csv("all_classifier_averages.csv"))
setwd("D:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single")
comb2<-as.data.frame(read.csv("all_classifier_averages.csv"))
shapiro.test(comb1$Grouped.value.2)
shapiro.test(comb2$Single.value.2)



first<-comb1[ , grepl( "value" , names(comb1) ) ]
second<-comb2[ , grepl( "value" , names(comb2) ) ]
for (i in 1:length(first)){
  shapDistF<-shapiro.test(first[i])
  shapDistS<-shapiro.test(second[i])
  
  if(shapDistF$p.value < 0.05){
    stats[i]<-wilcox.test(first[i],second[i])
  }
  else{
    stats[i]<-t.test(first[i],second[i])
  }
  
}


