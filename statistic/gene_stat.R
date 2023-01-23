
library("dplyr")
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


change_row_names<-function(stats_data){
  
  list_row_name<-rownames(stats_data)
  
  for(i in 1:length(list_row_name)){
    
    list_row_name[i]<-reagrange_string(list_row_name[i])
    
  }
  
  rownames(stats_data)<-list_row_name
  return(stats_data)
}


reagrange_string<-function(string){
  temp<-str_split(string, "-")
  string<-paste(temp[[1]][2],"-",temp[[1]][1])
  return(string)
}


to_dataframe<-function(p_adj_k,name){
  p_adj_k <- as.data.frame(p_adj_k)
  p_adj_k.name <- vector("character")
  p_adj_k.value <- vector("numeric")
  
  for (i in 1:ncol(p_adj_k) )
    for (j in i:length(p_adj_k) ) {
      p_adj_k.name <- c(p_adj_k.name,paste(colnames(p_adj_k[i]),"-",rownames(p_adj_k)[j]))
      p_adj_k.value <- c(p_adj_k.value,p_adj_k[j,i])
    }
  
  
  v <- order(p_adj_k.value,decreasing = F)
  data_frame<-data.frame(name =name,t(p_adj_k.value[v]))
  colnames(data_frame)<-c("name",p_adj_k.name[v])
  return (data_frame)
}

#importent to keep the same names
groupsNames<-c("Grouped","Mated","Singels")


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


#for generalzing I need to put alll data frames together
compute_stat<-function(csv_file_name,dir){
  datalist = list()
  setwd(dir[1,1])
  df1<-as.data.frame(read.csv(csv_file_name))
  first<-df1[ , grepl( "value" , names( df1 ) ) ]
  first$id <-as.factor(groupsNames[1])
  for (i in 2:num_of_pop){
    setwd(dir[i,1])
    df_temp<-as.data.frame(read.csv(csv_file_name))
    df_temp<-df_temp[ , grepl( "value" , names( df_temp ) ) ]
    df_temp$id <-as.factor(groupsNames[i])
    first<-bind_cols(first,df_temp)
  }
  
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
  
  for(i in 1:ncol(names_all)){
    names = c()
    for (j in 1:num_of_pop) {
      names = c(names, rep(groupsNames[j], length(unlist(featuers_comb[j]))))
    }
    value = rapply(featuers_comb[i,], c)
    data = data.frame(names, value)
    data$names <- as.character(data$names)
    data$names <- factor(data$names, levels=unique(data$names))
    
    
    len_stat <- getStatisticData(featuers_comb[i,], names, value, data)
    #i need to write this to dataframe
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
        p_adj_kk<-to_dataframe(p_adj_k,all_name[i])
        datalist[[i]]<-p_adj_kk
      }
      else{
        rownames(len_stat[[1]][["names"]])<-gsub("Males_", "", rownames(len_stat[[1]][["names"]]))
        stats_data<-as.data.frame(len_stat[[1]][["names"]]) 
        stats_data<-change_row_names(stats_data)
        list_rowname<-rownames(stats_data)
        data_frame_p_adj<-data.frame(name =all_name[i],t(stats_data[,-1:-3]))
        colnames(data_frame_p_adj)<-c("name",list_rowname)
        datalist[[i]]<-data_frame_p_adj
      }
      
    }
    
  }
  big_data = do.call(rbind, datalist)
  big_data
  csv_file_name <-paste("stats",csv_file_name)
  write.csv(big_data, csv_file_name, row.names = F)
  
  
  
}

Stat_sig<-function(dir){
  
  compute_stat("all_classifier_averages.csv",dir)
  compute_stat("averages per movie.csv",dir)
  compute_stat("bout_length_scores.csv",dir)
  compute_stat("frequency_scores.csv",dir)
}

stats_main<-function(dir){
  
  Stat_sig(dir)
  ave_kinetic.df<-as.data.frame(read.csv('stats averages per movie.csv'))
  ave_classifiers.df<-as.data.frame(read.csv('stats all_classifier_averages.csv'))
  ave_bl.df<-as.data.frame(read.csv('stats bout_length_scores.csv'))
  ave_frq.df<-as.data.frame(read.csv('stats frequency_scores.csv'))
  
  
  group_name_dir = tools::file_path_sans_ext(dirname((dir[1,1])))
  setwd(group_name_dir)
  net_stat_len.df<-as.data.frame(read.csv("stats of length network.csv"))
  net_stat_num.df<-as.data.frame(read.csv("stats of number network.csv"))
  
  all<-rbind(ave_kinetic.df,ave_classifiers.df,ave_bl.df,ave_frq.df,net_stat_len.df,net_stat_num.df)
  all$name<- str_replace(all$name, "scores_", "")
  all$name<- str_replace(all$name, ".mat", "")
  
  
  if(num_of_pop<3){
    fdr<-p.adjust(all$p_val, method ="fdr", n = length(all$p_val))
    all$fdr<-fdr
  }
  
  csv_file_name <-"all_togrther.csv"
  write.csv(all, csv_file_name, row.names = F)

}


num_of_pop=3
dir=as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))

dir[1,1]<-"D:/male_And_female_2/Males/Males_Grouped"
dir[2,1]<-"D:/male_And_female_2/Males/Males_Mated"
dir[3,1]<-"D:/male_And_female_2/Males/Males_Singels"





stats_main(dir)



