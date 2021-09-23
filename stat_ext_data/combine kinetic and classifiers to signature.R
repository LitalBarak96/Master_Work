library(base)

setwd('F:/statistic_test/MalesandFemales') #where is the data folder
all.df<-data.frame()
bl_frq.df<-data.frame()

names<-c("density_l","modularity_l","sd_l","srength_l","betweens_l","density_n","modularity_n","sd_n","srength_n","betweens_n")
values<-c(densL,modL,sdL,strL,betL,densN,modN,sdN,strN,betN)
network.df<-data.frame(names,values,varience)
colnames(network.df) <- c("file", "value","Variance")

# write data to a sample.csv file

ave_kinetic.df<-as.data.frame(read.csv('averages per movie.csv'))
ave_classifiers.df<-as.data.frame(read.csv('all_classifier_averages.csv'))
ave_bl.df<-as.data.frame(read.csv('bout_length_scores.csv'))
ave_frq.df<-as.data.frame(read.csv('frequency_scores.csv'))
new.df<-data.frame()
all.df<-cbind(ave_classifiers.df, ave_kinetic.df)
bl_frq.df<-cbind(ave_bl.df, ave_frq.df)


for (k in 1:length(all.df)){
  
  if (is.numeric(all.df[[k[1]]])){
    all.df[[k-1]]<-factor(all.df[[k-1]])
    print(levels(all.df[[k-1]]))
    tmp_new.df<-data.frame(file=levels(all.df[[k-1]]), value=mean(all.df[[k]]), Variance=sd(all.df[[k]])) # create average per condition
    new.df<-rbind(new.df, tmp_new.df) # make list of averages per condition of all features
 }
}
new.df<-rbind(new.df,network.df)



write.csv(all.df, 'combined per movie.csv',row.names = F)
write.csv(new.df, 'averages per condition.csv', row.names = F)