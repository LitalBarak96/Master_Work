
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
df1<-as.data.frame(read.csv("all_classifier_averages.csv"))

setwd("D:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped")
df2<-as.data.frame(read.csv("all_classifier_averages.csv"))
groupsNames<-c("Single","Gropued")

num_of_pop = 2
library("dplyr")
datalist = list()

first<-df1[ , grepl( "value" , names( df1 ) ) ]
second<-df2[ , grepl( "value" , names( df2 ) ) ]
names<-df1[ , grepl( "file" , names( df1 ) ) ]
all_name<-as.character(names[1,1:ncol(names)])
temp<-c()
test<-c()
for (i in 1:11){
  temp<-cbind(as.list(first[i]),as.list(second[i]))
  test<-rbind(test,temp)
}
rownames(test)<-all_name


for(i in 1:11){
  names = c()
  for (j in 1:num_of_pop) {
    names = c(names, rep(groupsNames[j], length(unlist(test[j]))))
  }
  value = rapply(test[i,], c)
  data = data.frame(names, value)
  data$names <- as.character(data$names)
  data$names <- factor(data$names, levels=unique(data$names))
  
  
  statsData <- getStatisticData(test[i,], names, value, data)
  #i need to write this to dataframe
  print(all_name[i])
  print(statsData[[1]]$p.value)
  
  dat <- data.frame(name =all_name[i],p_val = statsData[[1]]$p.value)
  dat$test <- statsData[[2]]  # maybe you want to keep track of which iteration produced it?
  datalist[[i]] <- dat # add it to your list
  
}
big_data = do.call(rbind, datalist)





