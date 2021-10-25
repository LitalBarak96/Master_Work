#split this to 3 part ,the first part is for ave_kinetic.df and ave_classifiers.df
#the second is for ave_bl.df and ave_frq.df
#the third is for the networks


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



setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single') #where is the data folder
ave_kinetic_Sec.df<-as.data.frame(read.csv('averages per movie.csv'))
ave_classifiers_sec.df<-as.data.frame(read.csv('all_classifier_averages.csv'))

Sec_classf.df<-data.frame(ave_classifiers_sec.df[,seq(3, length(ave_classifiers_sec.df), 3)])                         
Sec_kinef.df<-data.frame(ave_kinetic_Sec.df[,seq(3, length(ave_kinetic_Sec.df), 3)])                         



x <- data.matrix(First_classf.df)
y<-data.matrix(Sec_classf.df)

x_kin<- data.matrix(First_kinef.df)
y_kin<-data.matrix(Sec_kinef.df)


combined_2_group<- data.frame(group=c(rep("x", length(x[,1])), rep("y", length(y[,1]))), value=c(x[,1],y[,1]))

combined_2_group_kin<- data.frame(group=c(rep("x", length(x_kin[,1])), rep("y", length(y_kin[,1]))), value=c(x_kin[,1],y_kin[,1]))



#creat data frame in the wanted sizes

temp_x<-as.data.frame(lapply(structure(.Data=1:length(Sec_classf.df),.Names=1:length(Sec_classf.df)),function(x) numeric(nrow(ave_classifiers_first.df))))
temp_y<-as.data.frame(lapply(structure(.Data=1:length(Sec_classf.df),.Names=1:length(Sec_classf.df)),function(x) numeric(nrow(ave_classifiers_first.df))))

temp_x_kin<-as.data.frame(lapply(structure(.Data=1:length(Sec_kinef.df),.Names=1:length(Sec_kinef.df)),function(x) numeric(nrow(ave_kinetic_first.df))))
temp_y_kin<-as.data.frame(lapply(structure(.Data=1:length(Sec_kinef.df),.Names=1:length(Sec_kinef.df)),function(x) numeric(nrow(ave_kinetic_first.df))))





for (i in 1:length(Sec_classf.df)){
  #to do this for every value of both groups
  combined_2_group$value<-scale(c(x[,i],y[,i]), center = T, scale = T)
  #giving me only the row that are belong to x and have x value in group
  
  a<-subset(combined_2_group, group %in% "x")
  temp_x[,i]<-a$value
  b<-subset(combined_2_group, group %in% "y")
  temp_y[,i]<-b$value
}



for (i in 1:length(Sec_kinef.df)){
  #to do this for every value of both groups
  combined_2_group_kin$value<-scale(c(x_kin[,i],y_kin[,i]), center = T, scale = T)
  #giving me only the row that are belong to x and have x value in group
  
  a_kin<-subset(combined_2_group_kin, group %in% "x")
  temp_x_kin[,i]<-a_kin$value
  b_kin<-subset(combined_2_group_kin, group %in% "y")
  temp_y_kin[,i]<-b_kin$value
}



for(j in 1:length(Sec_classf.df)){
  ave_classifiers_first.df[,j*3]=temp_x[,j]
  ave_classifiers_sec.df[,j*3]=temp_y[,j]
}

for(j in 1:length(Sec_kinef.df)){
  ave_kinetic_first.df[,j*3]=temp_x_kin[,j]
  ave_classifiers_sec.df[,j*3]=temp_y_kin[,j]
}




#write it back again


setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped') #where is the data folder

write.csv(ave_classifiers_first.df, 'all_classifier_averages.csv', row.names = F)
write.csv(ave_kinetic_first.df, 'averages per movie.csv', row.names=F)

setwd('F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single') #where is the data folder
write.csv(ave_classifiers_sec.df, 'all_classifier_averages.csv', row.names = F)
write.csv(ave_classifiers_sec.df, 'averages per movie.csv', row.names=F)



