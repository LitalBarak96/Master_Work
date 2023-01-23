combind_all<-function(dir,path_to_scripts){
  
  current_dir =dir
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  all.df<-data.frame()
  bl_frq.df<-data.frame()
  all_bl.df<-data.frame()
  all_freq.df<-data.frame()
  ave_kinetic.df<-data.frame()
  ave_frq.df<-data.frame()
  ave_classifiers.df<-data.frame()
  ave_bl.df<-data.frame()
  avg_of_bl.df<-data.frame()
  avg_of_frq.df<-data.frame()
  tmp_new.df<-data.frame()
  
  ave_kinetic.df<-as.data.frame(read.csv('averages per fly per movie.csv'))
  ave_classifiers.df<-as.data.frame(read.csv('all_classifier_scores.csv'))
  ave_bl.df<-as.data.frame(read.csv('total_bl_per_fly.csv'))
  ave_frq.df<-as.data.frame(read.csv('total_frq_per_fly.csv'))
  
  new.df<-data.frame()
  all.df<-cbind(ave_classifiers.df, ave_kinetic.df)
  all.df<-cbind(all.df, ave_bl.df)
  all.df<-cbind(all.df, ave_frq.df)
  
  for (k in 1:length(all.df)){
    
    if (is.numeric(all.df[[k[1]]])){
      all.df[[k-1]]<-factor(all.df[[k-1]])
      print(levels(all.df[[k-1]]))
      tmp_new.df<-data.frame(file=levels(all.df[[k-1]]), value=mean(all.df[[k]]), Variance=sd(all.df[[k]])) # create average per condition
      new.df<-rbind(new.df, tmp_new.df) # make list of averages per condition of all features
    }
  }
  #network don't need to be proccesed 
  # new.df<-rbind(new.df,network.df)
  
  write.csv(all.df, 'combined_per_fly.csv',row.names = F)
  write.csv(new.df, 'averages per condition.csv', row.names = F)
  
  
}