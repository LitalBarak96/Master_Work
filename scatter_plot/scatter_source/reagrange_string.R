reagrange_string<-function(string,path_to_scripts){
  
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  temp<-str_split(string, "-")
  string<-paste(temp[[1]][2],"-",temp[[1]][1])
  return(string)
}