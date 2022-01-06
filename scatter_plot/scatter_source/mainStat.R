mainStat<-function(dir,xlsxFile,path_to_scripts,groupsNames,lengthParams,numberParams){
  
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  netWorkStats(dir[1,1],xlsxFile,path_to_scripts,groupsNames,lengthParams,numberParams)
  stats_main(dir,groupsNames,path_to_scripts)
  
}