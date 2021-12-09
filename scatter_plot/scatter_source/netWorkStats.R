netWorkStats<-function(current_path){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  datalist = list()
  datalist_num = list()
  
  setwd(current_path)
  group_name_dir = tools::file_path_sans_ext(dirname((current_path)))
  setwd(group_name_dir)
  #we need to make this file befor using this script
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
  all_name<-paramsNames
  all_name_NOI<-paste("NOI",all_name)
  all_name_LOI<-paste("LOI",all_name)
  
  
  for (i in 1:length(paramsNames)) {
    len_stat<-statistic_to_csv_of_network(groupsNames, lengthParams[i,])
    
    if(num_of_pop<3){
      print(all_name_LOI[i])
      print(len_stat[[1]]$p.value)
      dat <- data.frame(name =all_name_LOI[i],p_val = len_stat[[1]]$p.value)
      dat$test <- len_stat[[2]]  # maybe you want to keep track of which iteration produced it?
      datalist[[i]] <- dat # add it to your list
      
    }
    else{
      if(len_stat[[2]]=="Kruskal"){
        #rownames(len_stat[[1]][["p.value"]])<-gsub("Males_", "", rownames(len_stat[[1]][["p.value"]]))
        #colnames(len_stat[[1]][["p.value"]])<-gsub("Males_", "", colnames(len_stat[[1]][["p.value"]]))
        p_adj_k<-as.data.frame(len_stat[[1]][["p.value"]])
        p_adj_kk<-to_dataframe(p_adj_k,all_name_LOI[i])
        datalist[[i]]<-p_adj_kk
      }
      else{
        #rownames(len_stat[[1]][["names"]])<-gsub("Males_", "", rownames(len_stat[[1]][["names"]]))
        stats_data<-as.data.frame(len_stat[[1]][["names"]]) 
        stats_data<-change_row_names(stats_data)
        list_rowname<-rownames(stats_data)
        data_frame_p_adj<-data.frame(name =all_name_LOI[i],t(stats_data[,-1:-3]))
        colnames(data_frame_p_adj)<-c("name",list_rowname)
        datalist[[i]]<-data_frame_p_adj
      }
      
    }
    len_data = do.call(rbind, datalist)
    len_data
    
    #####################################################################################
    num_stat<-statistic_to_csv_of_network(groupsNames, numberParams[i,])
    
    if(num_of_pop<3){
      print(all_name_NOI[i])
      print(num_stat[[1]]$p.value)
      dat <- data.frame(name =all_name_NOI[i],p_val = num_stat[[1]]$p.value)
      dat$test <- num_stat[[2]]  # maybe you want to keep track of which iteration produced it?
      datalist_num[[i]] <- dat # add it to your list
      
    }
    else{
      if(num_stat[[2]]=="Kruskal"){
        #rownames(num_stat[[1]][["p.value"]])<-gsub("Males_", "", rownames(num_stat[[1]][["p.value"]]))
        #colnames(num_stat[[1]][["p.value"]])<-gsub("Males_", "", colnames(num_stat[[1]][["p.value"]]))
        p_adj_k_num<-as.data.frame(num_stat[[1]][["p.value"]])
        p_adj_kk_num<-to_dataframe(p_adj_k_num,all_name_NOI[i])
        datalist_num[[i]]<-p_adj_kk_num
        
      }
      else{
        print(num_stat[[2]])
        print(num_stat)
        test<-num_stat
        #rownames(num_stat[[1]][["names"]])<-gsub("Males_", "", rownames(num_stat[[1]][["names"]]))
        stats_data<-data.frame()
        stats_data<-as.data.frame(num_stat[[1]][["names"]]) 
        stats_data<-change_row_names(stats_data)
        list_rowname_num<-rownames(stats_data)
        data_frame_p_adj<-data.frame()
        data_frame_p_adj<-data.frame(name =all_name_NOI[i],t(stats_data[,-1:-3]))
        colnames(data_frame_p_adj)<-c("name",list_rowname_num)
        datalist_num[[i]]<-data_frame_p_adj
      }
      
    }
    num_data = do.call(rbind, datalist_num)
    num_data
    
    csv_file_name <-"stats of number network.csv"
    write.csv(num_data, csv_file_name, row.names = F)
    
    csv_file_name <-"stats of length network.csv"
    write.csv(len_data, csv_file_name, row.names = F)
    
    
  }
  
  
  
}
