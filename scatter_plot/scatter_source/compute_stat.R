compute_stat<-function(csv_file_name,dir,groupsNames){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
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
