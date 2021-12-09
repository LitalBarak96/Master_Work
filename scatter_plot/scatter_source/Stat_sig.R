Stat_sig<-function(dir,groupsNames){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  compute_stat("all_classifier_averages.csv",dir,groupsNames)
  compute_stat("averages per movie.csv",dir,groupsNames)
  compute_stat("bout_length_scores.csv",dir,groupsNames)
  compute_stat("frequency_scores.csv",dir,groupsNames)
}