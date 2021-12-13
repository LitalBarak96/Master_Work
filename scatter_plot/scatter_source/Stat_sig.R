Stat_sig<-function(dir,groupsNames,path_to_scripts){
  
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  compute_stat("all_classifier_averages.csv",dir,groupsNames,path_to_scripts)
  compute_stat("averages per movie.csv",dir,groupsNames,path_to_scripts)
  compute_stat("bout_length_scores.csv",dir,groupsNames,path_to_scripts)
  compute_stat("frequency_scores.csv",dir,groupsNames,path_to_scripts)
}