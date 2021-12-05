for_Scaleing<-function(dir){
  #do the scaling for each group
  scaleing("all_classifier_averages.csv",dir)
  scaleing("averages per movie.csv",dir)
  scaleing("bout_length_scores.csv",dir)
  scaleing("frequency_scores.csv",dir)
}
