change_row_names<-function(stats_data){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  list_row_name<-rownames(stats_data)
  
  for(i in 1:length(list_row_name)){
    
    list_row_name[i]<-reagrange_string(list_row_name[i])
    
  }
  
  rownames(stats_data)<-list_row_name
  return(stats_data)
}
