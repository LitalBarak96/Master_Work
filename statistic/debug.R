require(R.matlab)
library(base)
library(openxlsx)
library(igraph)
library(ggplot2)
library(cowplot)
library(ggpubr)
library(ggsignif)
library(nortest)
library(fmsb)
library(argparser, quietly=TRUE)
library(stringr)
library("readxl")

getStatisticData <- function(groupsParams, names, value, data) {
  #statistic data about each paramter density, modularity, sdStrength, strength, betweenness
  for (i in 1:length(groupsParams)) {
    shapDist <- shapiro.test(unlist(groupsParams[[i]]))
    #22.11.21 changed p value to 0.1
    if (shapDist$p.value < 0.1) {
      if (length(groupsParams) < 3) {
        stats <- wilcox.test(value~names, data)
        return(list(stats, "Wilcoxen"))
      } else {
        kruskal.test(value~names, data)
        stats <- pairwise.wilcox.test(data$value, data$names, p.adjust.method = 'fdr')
        return(list(stats, "Kruskal"))
      }
    }
  }
  if (length(groupsParams) < 3) {
    stats <- t.test(value~names, data)
    return(list(stats, "T Test"))
  } else {
    aov.res <- aov(value~names, data)
    summary(aov.res)
    stats <- TukeyHSD(aov.res)
    return(list(stats, "Anova"))
  }
}

setwd("D:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single")
df1<-as.data.frame(read.csv("frequency_scores.csv"))

setwd("D:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped")
df2<-as.data.frame(read.csv("frequency_scores.csv"))
groupsNames<-c("Single","Gropued")

num_of_pop = 2
library("dplyr")
datalist = list()

first<-df1[ , grepl( "value" , names( df1 ) ) ]
first$id <-as.factor(groupsNames[1])

second<-df2[ , grepl( "value" , names( df2 ) ) ]
second$id <-as.factor(groupsNames[2])
first<-bind_cols(first,second)
indexs<-c()
indexs<-which(grepl( "id" , names( first ) ))



       
names_all<-df1[ , grepl( "file" , names( df1 ) ) ]
all_name<-as.character(names_all[1,1:ncol(names_all)])

featuers_comb<-c()

#the j is for the feature names and i is for the number oof pop

for(j in 1:ncol(names_all)){
temp<-c()
temp<-cbind(temp,(as.list(first[j])))
for(i in 2:num_of_pop){
  temp<-cbind(temp,(as.list(first[indexs[i-1]+j])))
}

featuers_comb<-rbind(featuers_comb,temp)

}

rownames(featuers_comb)<-all_name



  i <-3
#for(i in 1:ncol(names_all)){
  names = c()
  for (j in 1:num_of_pop) {
    names = c(names, rep(groupsNames[j], length(unlist(featuers_comb[j]))))
  }
  value = rapply(featuers_comb[i,], c)
  data = data.frame(names, value)
  data$names <- as.character(data$names)
  data$names <- factor(data$names, levels=unique(data$names))


  statsData <- getStatisticData(featuers_comb[i,], names, value, data)
  print(all_name[i])
  #print(statsData)
  print(statsData[[1]]$p.value)
  #stats <- pairwise.wilcox.test(data$value, data$names, p.adjust.method = 'fdr')
  #print(stats)
  

  # #statistic data about each paramter density, modularity, sdStrength, strength, betweenness
  # for (i in 1:length(groupsParams)) {
  #   shapDist <- shapiro.test(unlist(groupsParams[[i]]))
  #   #22.11.21 changed p value to 0.1
  #   #if true this mean that not normal distrubted
  #   if (shapDist$p.value < 0.1) {
  #     if (length(groupsParams) < 3) {
  #       stats <- wilcox.test(value~names, data)
  #       print(list(stats$p.value, "Wilcoxen"))
  #     } else {
  #       kruskal.test(value~names, data)
  #       stats <- pairwise.wilcox.test(data$value, data$names, p.adjust.method = 'fdr')
  #       print(list(stats$p.value, "Kruskal"))
  #     }
  #   }
  # }
  # if (length(groupsParams) < 3) {
  #   stats <- t.test(value~names, data)
  #   print(list(stats$p.value, "T Test"))
  # } else {
  #   aov.res <- aov(value~names, data)
  #   summary(aov.res)
  #   stats <- TukeyHSD(aov.res)
  #   print(list(stats$p.value, "Anova"))
  # }
  # 
  # 
  # 
  
  
  #statsData <- getStatisticData(test[i,], names, value, data)
  #i need to write this to dataframe
  #print(all_name[i])
  #print(statsData[[1]]$p.value)

  #dat <- data.frame(name =all_name[i],p_val = statsData[[1]]$p.value)
  #dat$test <- statsData[[2]]  # maybe you want to keep track of which iteration produced it?
  #datalist[[i]] <- dat # add it to your list

#}
#big_data = do.call(rbind, datalist)


















