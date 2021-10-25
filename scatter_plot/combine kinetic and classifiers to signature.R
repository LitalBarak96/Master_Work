library(base)
number_of_movies = 8
setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped') #where is the data folder
all.df<-data.frame()
bl_frq.df<-data.frame()



# write data to a sample.csv file

ave_kinetic.df<-as.data.frame(read.csv('averages per movie.csv'))
ave_classifiers.df<-as.data.frame(read.csv('all_classifier_averages.csv'))
ave_bl.df<-as.data.frame(read.csv('bout_length_scores.csv'))
ave_frq.df<-as.data.frame(read.csv('frequency_scores.csv'))
new.df<-data.frame()
new_frq.df<-data.frame()
new_bl.df<-data.frame()
all.df<-cbind(ave_classifiers.df, ave_kinetic.df)
#all.df<-rbind(all.df, ave_frq.df)

#all_freq.df<-data.frame(ave_frq.df[, c('files','value', 'value.1', 'value.2','value.3','value.4','value.5','value.6','value.7','value.8','value.9')])
#avg_of_frq<-data.frame(files=ave_frq.df[,2], value=rowMeans(all_freq[1:9]),Variance =rowSds(all_freq[1:9]) )

all_bl.df<-data.frame(ave_bl.df[,seq(3, number_of_movies*3, 3)])                         
for (i in 2:length(ave_bl.df)){
  
  
  ave_bl.df[[i-1]]<-factor(ave_bl.df[[i-1]])
  print(levels(ave_bl.df[[i-1]]))
  avg_of_bl.df<-data.frame(file=levels(ave_bl.df[[i-1]]),   value=mean(unlist(all_bl.df[i,])),Variance =sd(unlist(all_bl.df[i,])) ) # create average per condition
  new_lb.df<-rbind(new.df, avg_of_bl.df) # make list of averages per condition of all features
  
  
}

for (i in 1:11){
  new_lb.df[i,]$value = mean(unlist(all_bl.df[i,2:number_of_movies]))
  new_lb.df[i,]$Variance = sd(unlist(all_bl.df[i,2:number_of_movies]))
  
}



all_freq.df<-data.frame(ave_frq.df[,seq(3, number_of_movies*3, 3)])                         
for (i in 2:length(ave_frq.df)){
  

  ave_frq.df[[i-1]]<-factor(ave_frq.df[[i-1]])
    print(levels(ave_frq.df[[i-1]]))
    avg_of_frq.df<-data.frame(file=levels(ave_frq.df[[i-1]]),   value=mean(unlist(all_freq.df[i,])),Variance =sd(unlist(all_freq.df[i,])) ) # create average per condition
    new_frq.df<-rbind(new.df, avg_of_frq.df) # make list of averages per condition of all features
  

}

for (i in 1:11){
  new_frq.df[i,]$value = mean(unlist(all_freq.df[i,2:number_of_movies]))
  new_frq.df[i,]$Variance = sd(unlist(all_freq.df[i,2:number_of_movies]))
  
}


#avg_of_frq<-data.frame(files=ave_frq.df[,2],  value=mean(unlist(all_freq.df[i,2:11])),Variance =sd(unlist(all_freq.df[i,2:11])) )

for (k in 1:length(all.df)){
  
  if (is.numeric(all.df[[k[1]]])){
    all.df[[k-1]]<-factor(all.df[[k-1]])
    print(levels(all.df[[k-1]]))
    tmp_new.df<-data.frame(file=levels(all.df[[k-1]]), value=mean(all.df[[k]]), Variance=sd(all.df[[k]])) # create average per condition
    new.df<-rbind(new.df, tmp_new.df) # make list of averages per condition of all features
 }
}

new.df<-rbind(new.df,new_frq.df)



write.csv(all.df, 'combined per movie.csv',row.names = F)
write.csv(new.df, 'averages per condition.csv', row.names = F)