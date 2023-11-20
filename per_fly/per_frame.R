
per_frame<-function(curr_dir,path_to_scripts){

  
  curr_dir<-tmp_dir[1,1]
library(dplyr)

setwd(curr_dir)
  

tmp_list<-list()
dir<-list.dirs(recursive = F)
print(dir)

col_ave.df<-data.frame()
row_ave.df<- data.frame()
final.df<-data.frame()
#included_list.df<-as.data.frame(read.csv2('included.csv', header = F, colClasses = "character"))  
#included<-as.character(included_list.df$V1)

for(k in 1:length(dir)){
  curr.dir<-(paste0(dir[k],'/perframe/')) 
  print(k)
  print(curr.dir)
  files<-list.files(path=paste0(curr.dir))
  index<-0
  for(j in 1:length(files)){ 
    
    row_ave.df<-data.frame()
    index<-index+1
    df <- readMat(paste0(curr.dir, '/', files[j])) # read each MAT file
    #print(j)
    
    for(i in 1:length(df$data)){
      tmp.df<- data.frame(dir=dir[k], file=files[j], fly=i, value=as.numeric(df$data[[i]][[1]])) #convert to data frame
      #tmp_ave.df<-  data.frame(dir=dir[k], file=files[j], fly=i, value=mean(tmp.df$value)) #make average per fly
      row_ave.df<- rbind(row_ave.df, tmp.df) #add average of each fly to others in the same movie
    }
    #tmp_movie_ave.df<-data.frame(dir=dir[k], file=files[j], value=mean(row_ave.df$value))
    
    if (index==1){
      col.df<- row_ave.df
    }else{
      col.df<- bind_rows(col.df, row_ave.df)
    }
    
  }
  
  
  tmp_list[[k]]<-col.df

  #ordered_ave<- col.df[order(col.df$file),]
  #final.df<-rbind(final.df, ordered_ave)
}

all_col.df<-do.call(qpcR:::cbind.na, tmp_list)



write.csv(all_col.df, 'averages per fly per movie per frame.csv', row.names=F)












dir<-list.dirs(recursive = F)
print(dir)
allscore.df<-data.frame()
score.df<-data.frame()
totalscore.df<-data.frame()
finalavepermovie.df<-data.frame()

#NUMBER OF MOVIES
for(k in 1:length(dir)){
  curr.dir<-(paste0(dir[k],'/')) 
  print(k)
  print(curr.dir)
  #FILES ARE THE SCORE PARAMETERS
  files<-list.files(path=paste0(curr.dir), pattern = 'scores')
  avepermovie.df<-data.frame()
  index<-0
  for(j in 1:length(files)){
    file<-readMat(paste0(curr.dir,'/',files[j])) #read each mat file
    score.df<-data.frame()
    index<-index+1
    for (i in 1:length(file$allScores[[4]])){
      #THIS IS PER FLY IN BINARY DATA PER FRAME 0 OR 1
      #i IS THE NUMBER OF FLY
      tmp.df <- data.frame(dir=dir[k], files=files[j], fly=i, value=as.numeric(file$allScores[[4]][[i]][[1]])) # convert format of data for each fly
        # scores.table<-(table(tmp.df$value))/((length(tmp.df$value))) #calculate amount(%) of behavior(In FRAMES it is not frq)
        # tmpflyscore.df<-data.frame(dir=dir[k], files=files[j], fly=i, values=(scores.table[2])) 
        score.df<-rbind(score.df, tmp.df)
      
    }
    if (index==1){
      avepermovie.df<-score.df
    }
    else{
      avepermovie.df<-bind_rows(avepermovie.df, score.df) #add averages to one list
    }
    
  }
  
  tmp_list[[k]]<-avepermovie.df

}

totalscore.df<-do.call(qpcR:::cbind.na, tmp_list)

write.csv(totalscore.df, 'all_classifier_scores_per_frame.csv', row.names = F)









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

ave_kinetic.df<-as.data.frame(read.csv('averages per fly per movie per frame.csv'))
ave_classifiers.df<-as.data.frame(read.csv('all_classifier_scores_per_frame.csv'))


new.df<-data.frame()
all.df<-cbind(ave_classifiers.df, ave_kinetic.df)


write.csv(all.df, 'combined_per_fly_per_Frame.csv',row.names = F)


}



