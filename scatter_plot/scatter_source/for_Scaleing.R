for_Scaleing<-function(dir){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  #do the scaling for each group
  scaleing("all_classifier_averages.csv",dir)
  scaleing("averages per movie.csv",dir)
  scaleing("bout_length_scores.csv",dir)
  scaleing("frequency_scores.csv",dir)
}
