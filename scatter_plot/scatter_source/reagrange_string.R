reagrange_string<-function(string){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  temp<-str_split(string, "-")
  string<-paste(temp[[1]][2],"-",temp[[1]][1])
  return(string)
}