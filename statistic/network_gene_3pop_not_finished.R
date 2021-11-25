
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

densL<-c()
varience<-c()
modL<-c()
sdL<-c()
strL<-c()
betL<-c()
densN<-c()
modN<-c()
sdN<-c()
strN<-c()
betN<-c()
group_name<-c()
num_of_pop<-0
colors_of_groups<<-data.frame()
with_rgb = FALSE

number_of_flies= 10
num_of_movies =0
datalist<-c()
datalist_num<-c()
num_of_pop <-3
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


statistic_to_csv_of_network<-function(groupsNames, groupsParams){
  names = c()
  for (i in 1:length(groupsNames)) {
    names = c(names, rep(groupsNames[i], length(unlist(groupsParams[i]))))
  }
  value = rapply(groupsParams, c)
  data = data.frame(names, value)
  data$names <- as.character(data$names)
  data$names <- factor(data$names, levels=unique(data$names))
  statsData <- getStatisticData(groupsParams, names, value, data)
  return(statsData)
  
}


calculateNetworksParams <- function(net, folderPath, graphName, vertexSize,fileName) {
  print(fileName)
  vertexNumber = gorder(net)
  par(mfrow=c(1,1), mar=c(1,1,1,1))
  l <- layout_in_circle(net)
  density <- sum(E(net)$weight) / (vertexNumber * (vertexNumber - 1) / 2)
  wtc <- cluster_walktrap(net)
  modularity <- modularity(wtc)
  sdStrength <- sd(strength(net, weights = E(net)$weight))
  strength <- strength(net, weights = E(net)$weight)
  betweenness <- betweenness(net, v = V(net), directed = FALSE, weights = E(net)$weight)
  
  return(list(density, modularity, sdStrength, strength, betweenness))
}

calculateGroupParams <- function(fileNames, maxNumberOfInteration) {
  density <- vector()
  modularity <- vector()
  sdStrength <- vector()
  strength <- vector()
  betweenness <- vector()
  for (i in 1:length(fileNames)) {
    matFile <- fileNames[i]
    mat <- scan(toString(matFile))
    numCol <- sqrt(length(mat))
    mat <- matrix(mat, ncol = numCol, byrow = TRUE)
    net <- graph_from_adjacency_matrix(mat, mode = "undirected", weighted = TRUE)
    folderPath <- dirname(toString(matFile))
    if (maxNumberOfInteration > 0) {
      E(net)$weight <- E(net)$weight / maxNumberOfInteration
      E(net)$width <- E(net)$weight*7
      cur <- calculateNetworksParams(net, folderPath, "number of interaction", 7,fileNames[i])
    } else {
      E(net)$width <- E(net)$weight*10
      cur <- calculateNetworksParams(net, folderPath, "length of interction", 25,fileNames[i])
    }
    density <- c(cur[1], density)
    modularity <- c(cur[2], modularity)
    sdStrength <- c(cur[3], sdStrength)
    strength <- c(cur[4], strength)
    betweenness <- c(cur[5], betweenness)
  }
  
  return(list(density, modularity, sdStrength, strength, betweenness))
}



  current_path ="D:/male_And_female_2/Males/Males_Mated"
  setwd(current_path)
  group_name_dir = tools::file_path_sans_ext(dirname((current_path)))
  setwd(group_name_dir)
  allData <- read.xlsx("expData_0_to_27000.xlsx")
  lengthParams <- c()
  numberParams <- c()
  numberOfMovies<-c()
  for (i in 1:allData$Number.of.groups[1]) {
    cur <- (i + 1) * 2
    numberOfMovies[i]<- allData[i, 3]
    lengthParams <- cbind(lengthParams, calculateGroupParams(allData[1:numberOfMovies[i], cur], 0))
    numberParams <- cbind(numberParams, calculateGroupParams(allData[1:numberOfMovies[i], cur + 1], allData$Max.number.of.interaction[1]))
  }
  
  #parametrs name
  paramsNames <- c("Density", "Modularity", "SD Strength", "Strength", "Betweenness Centrality")
  groupsNames <- as.character(na.omit(allData$Groups.names))
  #6 is because there is 5 paramters
  length<-as.data.frame(lapply(structure(.Data=1:6,.Names=1:6),function(x) numeric(num_of_pop)))
  number<-as.data.frame(lapply(structure(.Data=1:6,.Names=1:6),function(x) numeric(num_of_pop)))
  
  for (i in 1:num_of_pop){ 
    lengthAvg<-paste0("lengthAvg",as.character(i))
    length[i,1]<-lengthAvg
  }
  for (i in 1:num_of_pop){ 
    numberAvg<-paste0("numberAvg",as.character(i))
    number[i,1]<-numberAvg
  }
  
  
  num<-apply(numberParams, 1, unlist)
  lengh<-apply(lengthParams, 1, unlist)
  for (j in 1:5){
    scaled_num<-scale(as.numeric(unlist(num[j])))
    scaled_len<-scale(as.numeric(unlist(lengh[j])))
    
    for(m in 1:num_of_pop){
      start =1
      if(m!=1) {
        start = (length(scaled_num)/num_of_pop)*(m-1)
      }
      numberParams[j,m]<-list(scaled_num[(start+1):((length(scaled_num)/num_of_pop)*m)])
    }
    
    for(m in 1:num_of_pop){
      start =1
      if(m!=1) {
        start = (length(scaled_len)/num_of_pop)*(m-1)
      }
      lengthParams[j,m]<-list(scaled_len[(start+1):((length(scaled_len)/num_of_pop)*m)])
    }
    
  }
  
  #first i will do it generic and than i will implement it here
  all_name<-paramsNames
  
  
  for (i in 1:length(paramsNames)) {
    len_stat<-statistic_to_csv_of_network(groupsNames, lengthParams[i,])
    
    if(num_of_pop<3){
      print(all_name[i])
      print(len_stat[[1]]$p.value)
      dat <- data.frame(name =all_name[i],p_val = len_stat[[1]]$p.value)
      dat$test <- len_stat[[2]]  # maybe you want to keep track of which iteration produced it?
      datalist[[i]] <- dat # add it to your list
      
    }
    else{
      if(len_stat[[2]]=="Kruskal"){
        rownames(len_stat[[1]][["p.value"]])<-gsub("Males_", "", rownames(len_stat[[1]][["p.value"]]))
        colnames(len_stat[[1]][["p.value"]])<-gsub("Males_", "", colnames(len_stat[[1]][["p.value"]]))
        
        p_adj_k<-as.data.frame(len_stat[[1]][["p.value"]])
        p_adj_kk<-data.frame(name = all_name[i],GropuedMated =  p_adj_k["Gropued","Mated"], SingleMated=p_adj_k["Single","Mated"],SingleGropued =  p_adj_k["Single","Gropued"])
        datalist[[i]]<-p_adj_kk
        
      }
      else{
        stats_data<-as.data.frame(len_stat[[1]][["names"]]) 
        p_adj<-data.frame(name = all_name[i],GropuedMated =  stats_data["Gropued-Mated","p adj"], SingleMated=stats_data["Single-Mated","p adj"],SingleGropued =  stats_data["Single-Gropued","p adj"])
        datalist[[i]]<-p_adj
      }
      
    }
    len_data = do.call(rbind, datalist)
    len_data
    
    
    num_stat<-statistic_to_csv_of_network(groupsNames, numberParams[i,])
    
    if(num_of_pop<3){
      print(all_name[i])
      print(num_stat[[1]]$p.value)
      dat <- data.frame(name =all_name[i],p_val = num_stat[[1]]$p.value)
      dat$test <- num_stat[[2]]  # maybe you want to keep track of which iteration produced it?
      datalist_num[[i]] <- dat # add it to your list
      
    }
    else{
      if(num_stat[[2]]=="Kruskal"){
        rownames(num_stat[[1]][["names"]])<-gsub("Males_", "", rownames(num_stat[[1]][["names"]]))
        colnames(num_stat[[1]][["names"]])<-gsub("Males_", "", colnames(num_stat[[1]][["names"]]))
        
        p_adj_k<-as.data.frame(num_stat[[1]][["p.value"]])
        
        p_adj_kk<-data.frame(name = all_name[i],GropuedMated =  p_adj_k["Gropued","Mated"], SingleMated=p_adj_k["Single","Mated"],SingleGropued =  p_adj_k["Single","Gropued"])
        datalist_num[[i]]<-p_adj_kk
        
      }
      else{
        
        stats_data<-as.data.frame(num_stat[[1]][["names"]]) 
        #remove the male
        p_adj<-data.frame(name = all_name[i],GropuedMated =  stats_data["Gropued-Mated","p adj"], SingleMated=stats_data["Single-Mated","p adj"],SingleGropued =  stats_data["Single-Gropued","p adj"])
        datalist_num[[i]]<-p_adj
      }
      
    }
    num_data = do.call(rbind, datalist_num)
    num_data
    
    
    csv_file_name <-"stats of number network.csv"
    write.csv(num_data, csv_file_name, row.names = F)

    csv_file_name <-"stats of length network.csv"
    write.csv(len_data, csv_file_name, row.names = F)
    
    
    
    #the whole row i of lengthParams/numberParams
    #calculating the mean of each population
    for(j in 1:num_of_pop){
      length[j,i+1] <- mean(unlist(lengthParams[i,j]))
      number[j,i+1] <-mean(unlist(numberParams[i,j]))
      
    }
    
  }
  
  index_name <- function(input_name,groupsNames){
    
    for (i in 1:length(groupsNames)){
      if(input_name == groupsNames[i]){
        return (i)
      }
    }
  }
  
  my_index = index_name(group_name,groupsNames)
  varience<<-c(sd(unlist(lengthParams[1,my_index])),sd(unlist(lengthParams[2,my_index])),sd(unlist(lengthParams[3,my_index])),sd(unlist(lengthParams[4,my_index])),sd(unlist(lengthParams[5,my_index])),sd(unlist(numberParams[1,my_index])),sd(unlist(numberParams[2,my_index])),sd(unlist(numberParams[3,my_index])),sd(unlist(numberParams[4,my_index])),sd(unlist(numberParams[5,my_index])))
  
  densL1<-c()
  modL1<-c()
  sdL1<-c()
  strL1<-c()
  betL1<-c()
  densN1<-c()
  modN1<-c()
  sdN1<-c()
  strN1<-c()
  betN1<-c()
  
  densL1<-as.numeric(as.data.frame(t(length[2])))
  modL1<-as.numeric(as.data.frame(t(length[3])))
  sdL1<-as.numeric(as.data.frame(t(length[4])))
  strL1 <- as.numeric(as.data.frame(t(length[5])))
  betL1 <- as.numeric(as.data.frame(t(length[6])))
  densN1 <- as.numeric(as.data.frame(t(number[2])))
  modN1 <- as.numeric(as.data.frame(t(number[3])))
  sdN1 <- as.numeric(as.data.frame(t(number[4])))
  strN1 <- as.numeric(as.data.frame(t(number[5])))
  betN1 <- as.numeric(as.data.frame(t(number[6])))
  
  
  densL<<-densL1[my_index]
  modL<<-modL1[my_index]
  
  sdL<<-sdL1[my_index]
  
  strL<<-strL1[my_index]/sqrt(number_of_flies)
  
  
  betL<<-betL1[my_index]/sqrt(number_of_flies)
  
  
  densN<<-densN1[my_index]
  
  
  modN<<-modN1[my_index]
  
  
  sdN<<-sdN1[my_index]
  
  
  strN<<-strN1[my_index]/sqrt(number_of_flies)
  
  
  betN<<-betN1[my_index]/sqrt(number_of_flies)
  
  setwd(current_path)
  names<-c("density(LOI)","modularity(LOI)","sd strength(LOI)","strength(LOI)","betweens(LOI)","density(NOI)","modularity(NOI)","sd strength(NOI)","strength(NOI)","betweens(NOI)")  
  values<-c(densL,modL,sdL,strL,betL,densN,modN,sdN,strN,betN)
  network.df<-data.frame(names,values,varience)
  View(network.df)
  colnames(network.df) <- c("file", "value","Variance")
  write.csv(network.df, 'network.csv', row.names = F)
  
}
