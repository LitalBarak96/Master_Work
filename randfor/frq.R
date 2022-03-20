boutLengthAndFrequencyForClassifiers<-function(dir,path_to_scripts){
  
  current_dir ="F:/GroupedvsSingle/Grouped"

  setwd(current_dir)
  
  str1 = "frequency"
  str2 = "bout length"
  dir<-list.dirs(recursive = F)
  print(dir)
  ave_bl<-data.frame()
  total_bl<-data.frame()
  total_all<-data.frame()
  per_movie_freq<-data.frame()
  total_freq_all<-data.frame()
  ave_bl_fly<-data.frame()
  avg_bl_df_per_Fly_combined<-data_frame()
  frq_df_per_Fly_combined<-data_frame()
  all_frq_cbind<-data.frame()
  all_bl_cbind<-data.frame()
  first<-TRUE
  for(k in 1:length(dir)){
    curr.dir<-(paste0(dir[k],'/')) 
    print(k)
    print(curr.dir)
    files<-list.files(path=paste0(curr.dir), pattern = 'scores')
    first<-TRUE
    total.df<-data.frame()
    total_freq.df<-data.frame()
    
    for(j in 1:length(files)){
      file<-readMat(paste0(curr.dir,'/',files[j])) #read each mat file
      #i is the number of flys
      avg_bl_df_per_Fly_combined<-data_frame()
      frq_df_per_Fly_combined<-data_frame()
      
      for (i in 1:length(file$allScores[[4]])){
        #gives the value in each frame if there was movement or not (0 or 1)
        tmp.df <- data.frame(dir=dir[k], files=files[j], fly=i, value=as.numeric(file$allScores[[4]][[i]][[1]])) # convert format of data for each fly
        
        ### get bout length for each fly ###
        counter<-0
        bl_vector<-data.frame(0)
        first_bout<-0
        for (m in 1:length(tmp.df$value)){ # get bout length of one fly
          if ((tmp.df$value[m]==1)&(first_bout==0)){
            counter<-1
            #there is the first bout?
            first_bout<-1
          }
          else if (tmp.df$value[m]==1) {
            counter<-counter+1
          }
          else if ((tmp.df$value[m]==0)&(first_bout==1)) {
            if (counter>10){ # minimum length of bout in frames
              bl_vector<-rbind(bl_vector, counter) # add all bouts to one data frame for one fly
              counter<-0
            }
          }
        }
        #ave_bl_fly<-mean(bl_vector)
        #frq calculated by the number of accurance that is happening
        
        
       # ave_bl<-rbind(ave_bl,as.numeric(colMeans(bl_vector, na.rm = T, dims = 1))) # combine average bout lengths of all flies per movie
        avg_bl_df_per_Fly <- data.frame(dir=dir[k], files=files[j], fly=i, value=as.numeric(colMeans(bl_vector, na.rm = T, dims = 1))) # convert format of data for each fly
        avg_bl_df_per_Fly_combined<-bind_rows(avg_bl_df_per_Fly_combined,avg_bl_df_per_Fly)
        #calculating the number of instans that had movemnt (e.g 21 accurance divideing by 27001 frames)
        #multiply with 30 beacuse we wanted to change from perframe to seconds
        #per_movie_freq<-rbind(per_movie_freq, as.numeric(lengths(bl_vector)/((length(tmp.df$value))/30)))
        frq_df_per_Fly <- data.frame(dir=dir[k], files=files[j], fly=i, value=as.numeric(lengths(bl_vector)/((length(tmp.df$value))/30))) # convert format of data for each fly
        frq_df_per_Fly_combined<-bind_rows(frq_df_per_Fly_combined,frq_df_per_Fly)
        # combine frequency of all flies
      }
      
     # all_frq_cbind<-bind_cols(all_frq_cbind,frq_df_per_Fly_combined)
      
      #all_bl_cbind<-bind_cols(all_bl_cbind,avg_bl_df_per_Fly_combined)
      #I THINK I FIXES THAT PROBLEM WITH INIT THE BL VECTOR TO DATAFRAME OF ZEROS AND ALSO CHANGE FROM MEAN TO COL MEAN BECAUSE THE DF WONT ALLOW TO DO MEAN (I THIINK BECASUE OF THE TITLE OF THE DF)

      if(j==1){
        #total.df<-data.frame(dir=dir[k], file=files[j], value=mean(row_ave.df$value)) #make average per movie
        all_frq_cbind<-frq_df_per_Fly_combined
        all_bl_cbind<-avg_bl_df_per_Fly_combined
      }
      else{
        library(dplyr)
        all_frq_cbind<-bind_cols(all_frq_cbind,frq_df_per_Fly_combined)
        all_bl_cbind<-bind_cols(all_bl_cbind,avg_bl_df_per_Fly_combined)
      }
    }
    ### add average bout length to data frame of averages per movie ###
    if(k==1){
      total_frq<-all_frq_cbind
      total_bl<-all_bl_cbind
    }
    else{
      total_frq<-bind_rows(total_frq,all_frq_cbind)
      total_bl<-bind_rows(total_bl,all_bl_cbind)
      
    }
    
  }
  write.csv(total_frq, 'total_frq_per_fly.csv', row.names = F)
  write.csv(total_bl, 'total_bl_per_fly.csv', row.names = F)
  
}
