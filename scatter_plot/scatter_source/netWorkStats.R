netWorkStats<-function(current_path,xlsxFile,path_to_scripts,groupsNames,lengthParams,numberParams){
  
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  datalist = list()
  datalist_num = list()
  

  setwd(current_path)
  group_name_dir = tools::file_path_sans_ext(dirname((current_path)))
  setwd(group_name_dir)
  #we need to make this file befor using this script
 
  
  all_name<-c("Density", "Modularity", "SD Strength", "Strength", "Betweenness Centrality")
  all_name_NOI<-paste("NOI",all_name)
  all_name_LOI<-paste("LOI",all_name)
  
  
  for (i in 1:length(all_name)) {
    lenStat<-statProcess(groupsNames, lengthParams[i,],path_to_scripts)
    
    if(num_of_pop<3){
      #print(all_name_LOI[i])
      #print(lenStat[[1]]$p.value)
      dat <- data.frame(name =all_name_LOI[i],pVal = lenStat[[1]]$p.value)
      dat$test <- lenStat[[2]]  #what is the test 
      datalist[[i]] <- dat # add it to your list
      
    }
    else{
      ##check in creatExpNet what she did in addStatsToGraph function
      if(lenStat[[2]]=="Kruskal"){
        p_adj_k<-as.data.frame(lenStat[[1]][["p.value"]])
        p_adj_kk<-to_dataframe(p_adj_k,all_name_LOI[i],lenStat[[2]],path_to_scripts)
        datalist[[i]]<-p_adj_kk
      }
      else{
        stats_data<-as.data.frame(lenStat[[1]][["names"]]) 
        stats_data<-change_row_names(stats_data,path_to_scripts)
        list_rowname<-rownames(stats_data)
        data_frame_p_adj<-data.frame(name =all_name_LOI[i],t(stats_data[,-1:-3]),test=lenStat[[2]])
        colnames(data_frame_p_adj)<-c("name",list_rowname,"test")
        datalist[[i]]<-data_frame_p_adj
      }
      
    }
    lenData = do.call(rbind, datalist)
    lenData
    
    #####################################################################################
    numStat<-statProcess(groupsNames, numberParams[i,],path_to_scripts)
    
    if(num_of_pop<3){
      print(all_name_NOI[i])
      print(numStat[[1]]$p.value)
      dat <- data.frame(name =all_name_NOI[i],p_val = numStat[[1]]$p.value)
      dat$test <- numStat[[2]]  # maybe you want to keep track of which iteration produced it?
      datalist_num[[i]] <- dat # add it to your list
      
    }
    else{
      if(numStat[[2]]=="Kruskal"){
        p_adj_k_num<-as.data.frame(numStat[[1]][["p.value"]])
        p_adj_kk_num<-to_dataframe(p_adj_k_num,all_name_NOI[i],numStat[[2]],path_to_scripts)
        datalist_num[[i]]<-p_adj_kk_num
        
      }
      else{
        print(numStat[[2]])
        print(numStat)
        test<-numStat
        stats_data<-data.frame()
        stats_data<-as.data.frame(numStat[[1]][["names"]]) 
        stats_data<-change_row_names(stats_data,path_to_scripts)
        list_rowname_num<-rownames(stats_data)
        data_frame_p_adj<-data.frame()
        data_frame_p_adj<-data.frame(name =all_name_NOI[i],t(stats_data[,-1:-3]),test=numStat[[2]])
        colnames(data_frame_p_adj)<-c("name",list_rowname_num,"test")
        datalist_num[[i]]<-data_frame_p_adj
      }
      
    }
    numData = do.call(rbind, datalist_num)
    numData
    
    csv_file_name <-"stats of number network.csv"
    write.csv(numData, csv_file_name, row.names = F)
    
    csv_file_name <-"stats of length network.csv"
    write.csv(lenData, csv_file_name, row.names = F)
    
    
  }
  
  
  
}
