#split this to 3 part ,the first part is for ave_kinetic.df and ave_classifiers.df
#the second is for ave_bl.df and ave_frq.df
#the third is for the networks


z_score <- function(First_classf.df,Sec_classf.df,numer_of_rows) {
  
  x <- data.matrix(First_classf.df)
  y<-data.matrix(Sec_classf.df)
  
  combined_2_group<- data.frame(group=c(rep("x", length(x[,1])), rep("y", length(y[,1]))), value=c(x[,1],y[,1]))
  
  temp_x<-as.data.frame(lapply(structure(.Data=1:length(Sec_classf.df),.Names=1:length(Sec_classf.df)),function(x) numeric(numer_of_rows)))
  temp_y<-as.data.frame(lapply(structure(.Data=1:length(Sec_classf.df),.Names=1:length(Sec_classf.df)),function(x) numeric(numer_of_rows)))
  
  for (i in 1:length(Sec_classf.df)){
    #to do this for every value of both groups
    combined_2_group$value<-scale(c(x[,i],y[,i]), center = T, scale = T)
    #giving me only the row that are belong to x and have x value in group
    
    a<-subset(combined_2_group, group %in% "x")
    temp_x[,i]<-a$value
    b<-subset(combined_2_group, group %in% "y")
    temp_y[,i]<-b$value
  }
  
  return(list("temp_x"=temp_x,"temp_y"=temp_y))
}


z_score_t <- function(First_classf.df,Sec_classf.df) {
  
  
  x <- (data.matrix(First_classf.df))
  y<-(data.matrix(Sec_classf.df))
  
  colnames(x) <-NULL
  colnames(y) <-NULL
  
  
  
  
  combined_2_group<- data.frame(group=c(rep("x", length(x[1,])), rep("y", length(y[1,]))), value=c(x[1,],y[1,]))
  
  temp_x<-as.data.frame(lapply(structure(.Data=1:nrow(Sec_classf.df),.Names=1:nrow(Sec_classf.df)),function(x) numeric(ncol(First_classf.df))))
  temp_y<-as.data.frame(lapply(structure(.Data=1:nrow(Sec_classf.df),.Names=1:nrow(Sec_classf.df)),function(x) numeric(ncol(First_classf.df))))
  
  for (i in 1:nrow(y)){
    print(nrow(y))
    #to do this for every value of both groups
    combined_2_group$value<-scale(c(x[i,],y[i,]), center = T, scale = T)
    #giving me only the row that are belong to x and have x value in group
    
    a<-subset(combined_2_group, group %in% "x")
    temp_x[,i]<-a$value
    b<-subset(combined_2_group, group %in% "y")
    temp_y[,i]<-b$value
  }
  
  
  return(list("temp_x"=temp_x,"temp_y"=temp_y))
}


library(base)
setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped') #where is the data folder


#first
#there are rows as the number of movies in my case it was 12 rows and coloms as the number of features that 
#is 16 * 3 = 48 in kinetics
#and number of scores which is 11 * 3 = 33 in classifier
ave_kinetic_first.df<-as.data.frame(read.csv('averages per movie.csv'))
ave_classifiers_first.df<-as.data.frame(read.csv('all_classifier_averages.csv'))

First_classf.df<-data.frame(ave_classifiers_first.df[,seq(3, length(ave_classifiers_first.df), 3)])                         
First_kinef.df<-data.frame(ave_kinetic_first.df[,seq(3, length(ave_kinetic_first.df), 3)])                         

ave_bl_first.df<-as.data.frame(read.csv('bout_length_scores.csv'))
ave_frq_first.df<-as.data.frame(read.csv('frequency_scores.csv'))



setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single') #where is the data folder
ave_kinetic_Sec.df<-as.data.frame(read.csv('averages per movie.csv'))
ave_classifiers_sec.df<-as.data.frame(read.csv('all_classifier_averages.csv'))

Sec_classf.df<-data.frame(ave_classifiers_sec.df[,seq(3, length(ave_classifiers_sec.df), 3)])                         
Sec_kinef.df<-data.frame(ave_kinetic_Sec.df[,seq(3, length(ave_kinetic_Sec.df), 3)])                         


ave_bl_sec.df<-as.data.frame(read.csv('bout_length_scores.csv'))
ave_frq_sec.df<-as.data.frame(read.csv('frequency_scores.csv'))










classify<-z_score(First_classf.df,Sec_classf.df,nrow(ave_classifiers_first.df))
kinnetic<-z_score(First_kinef.df,Sec_kinef.df,nrow(ave_kinetic_Sec.df))



for(j in 1:length(Sec_classf.df)){
  ave_classifiers_first.df[,j*3]=classify$temp_x[,j]
  ave_classifiers_sec.df[,j*3]=classify$temp_y[,j]
}

for(j in 1:length(Sec_kinef.df)){
  ave_kinetic_first.df[,j*3]=kinnetic$temp_x[,j]
  ave_kinetic_Sec.df[,j*3]=kinnetic$temp_y[,j]
}






###########################################################
#part 2

fir_bl.df<-data.frame(ave_bl_first.df[,seq(3, length(ave_bl_first.df), 3)])                         
Sec_bl.df<-data.frame(ave_bl_sec.df[,seq(3, length(ave_bl_sec.df), 3)])  


fir_frq.df<-data.frame(ave_frq_first.df[,seq(3, length(ave_frq_first.df), 3)])                         
Sec_frq.df<-data.frame(ave_frq_sec.df[,seq(3, length(ave_frq_sec.df), 3)])  



bl<-z_score_t(fir_bl.df,Sec_bl.df)

frq<-z_score_t(fir_frq.df,Sec_frq.df)



#12
for (i in 1:nrow(bl$temp_x)){
  #11
  for (j in 1:ncol(bl$temp_x)){
    ave_frq_first.df[j,i*3]=frq$temp_x[i,j]
    ave_frq_sec.df[j,i*3]=frq$temp_y[i,j]
    
    ave_bl_first.df[j,i*3]=bl$temp_x[i,j]
    ave_bl_sec.df[j,i*3]=bl$temp_y[i,j]
    
  }
}



#write it back again


setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped') #where is the data folder

write.csv(ave_classifiers_first.df, 'all_classifier_averages.csv', row.names = F)
write.csv(ave_kinetic_first.df, 'averages per movie.csv', row.names=F)
write.csv(ave_bl_first.df, 'bout_length_scores.csv', row.names = F)
write.csv(ave_frq_first.df, 'frequency_scores.csv', row.names = F)


setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single') #where is the data folder
write.csv(ave_classifiers_sec.df, 'all_classifier_averages.csv', row.names = F)
write.csv(ave_kinetic_Sec.df, 'averages per movie.csv', row.names=F)
write.csv(ave_bl_sec.df, 'bout_length_scores.csv', row.names = F)
write.csv(ave_frq_sec.df, 'frequency_scores.csv', row.names = F)




