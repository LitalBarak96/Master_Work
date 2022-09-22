change_row_names<-function(stats_data,path_to_scripts){
  
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  list_row_name<-rownames(stats_data)
  
  for(i in 1:length(list_row_name)){
    
    list_row_name[i]<-reagrange_string(list_row_name[i],path_to_scripts)
    
  }
  
  rownames(stats_data)<-list_row_name
  return(stats_data)
}
