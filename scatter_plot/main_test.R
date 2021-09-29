require(R.matlab)
library(base)

densL<-c()
varience<-c()
modL<-c()
sdL<-c()
strL<c()
betL<-c()
densN<-c()
modN<-c()
sdN<-c()
strN<-c()
betN<-c()
setwd('F:/statistic_test/MalesSingels')
averagesPerMovieByFile<-function(){
  
  dir<-list.dirs(recursive = F)
  print(dir)
  
  col_ave.df<-data.frame()
  row_ave.df<- data.frame()
  final.df<-data.frame()
  included_list.df<-as.data.frame(read.csv2('included.csv', header = F, colClasses = "character"))  
  included<-as.character(included_list.df$V1)
  
  for(k in 1:length(dir)){
    curr.dir<-(paste0(dir[k],'/perframe/')) 
    print(k)
    print(curr.dir)
    files<-list.files(path=paste0(curr.dir))
    index<-0
    for(j in 1:length(files)){ 
      if (files[j] %in% included){
        index<-index+1
        df <- readMat(paste0(curr.dir, '/', files[j])) # read each MAT file
        #print(j)
        
        for(i in 1:length(df$data)){
          tmp.df<- data.frame(dir=dir[k], file=files[j], fly=i, value=as.numeric(df$data[[i]][[1]])) #convert to data frame
          tmp_ave.df<-  data.frame(dir=curr.dir, file=files[j], fly=i, value=mean(tmp.df$value)) #make average per fly
          row_ave.df<- rbind(row_ave.df, tmp_ave.df) #add average of each fly to others in the same movie
        }
        tmp_movie_ave.df<-data.frame(dir=dir[k], file=files[j], value=mean(row_ave.df$value))
        
        if (index==1)
          movie_ave.df<-data.frame(dir=dir[k], file=files[j], value=mean(row_ave.df$value)) #make average per movie
        if (index==1)  
          col.df<- row_ave.df
        #col_ave.df<- cbind(col_ave.df, row_ave.df)
        
        
        else {
          col.df<- cbind(col.df, row_ave.df)
          movie_ave.df<-cbind(movie_ave.df, tmp_movie_ave.df) #combine averages per movie
        }
        col.df<- cbind(col.df, row_ave.df)
        
        row_ave.df<- NULL
      }
    }
    #ordered_ave<- col.df[order(col.df$file),]
    if (k==1)
      total_movie_ave.df<- movie_ave.df
    else 
      total_movie_ave.df<-rbind(total_movie_ave.df, movie_ave.df)
    
    ordered_ave<- col.df[order(col.df$file),]
    final.df<-rbind(final.df, ordered_ave)
  }
  #write.csv(rowave.df, 'averages per fly.csv',row.names = F)
  #write.csv(colave.df, 'averages per fly.csv',row.names = F)
  #write.csv(final.df, 'averages per fly.csv',row.names = F)
  write.csv(total_movie_ave.df, 'averages per movie.csv', row.names=F)
  #print(length(files))
  #print(files)
}

#calculating density, modularity, sdStrength, strength, betweenness
calculateNetworksParams <- function(net, folderPath, graphName, vertexSize,fileName) {
  # all
  print(fileName)
  vertexNumber = gorder(net)
  par(mfrow=c(1,1), mar=c(1,1,1,1))
  l <- layout_in_circle(net)
  jpeg(file.path(folderPath, paste("network ", graphName, ".jpg", sep = "")))
  plot(net, layout = l)
  dev.off()
  
  # density
  density <- sum(E(net)$weight) / (vertexNumber * (vertexNumber - 1) / 2)
  print(paste("density = ", density))
  x <- c(1 - density, density)
  labels <- c("","Density")
  jpeg(file.path(folderPath, paste("density ", graphName, ".jpg", sep = "")))
  pie(x, labels)
  dev.off()
  
  # modularity
  #This function tries to find densely connected subgraphs
  wtc <- cluster_walktrap(net)
  modularity <- modularity(wtc)
  print(paste("modularity = ", modularity))
  jpeg(file.path(folderPath, paste("modularity ", graphName, ".jpg", sep = "")))
  plot(wtc, net)
  dev.off()
  
  # strength std
  sdStrength <- sd(strength(net, weights = E(net)$weight))
  print(paste("sd strength = ", sdStrength))
  
  
  #individual
  
  # strength
  #Summing up the edge weights of the adjacent edges for each vertex.
  print(net)
  strength <- strength(net, weights = E(net)$weight)
  
  print("strength: ")
  print(strength)
  jpeg(file.path(folderPath, paste("strength ", graphName, ".jpg", sep = "")))
  plot(net, vertex.size=strength*vertexSize, layout = l)
  dev.off()
  
  # betweenness centality 
  betweenness <- betweenness(net, v = V(net), directed = FALSE, weights = E(net)$weight)
  print("betweenness: ")
  print(betweenness)
  return(list(density, modularity, sdStrength, strength, betweenness))
}
#calculating the params of the group with calculateNetworksParams for length and number groups
calculateGroupParams <- function(fileNames, maxNumberOfInteration) {
  density <- vector()
  modularity <- vector()
  sdStrength <- vector()
  strength <- vector()
  betweenness <- vector()
  #number of files we want
  for (i in 1:length(fileNames)) {
    #when debuging see what is inside matfile
    matFile <- fileNames[i]
    mat <- scan(toString(matFile))
    #because the matrix is smetric and there is 100 value so it is 10
    numCol <- sqrt(length(mat))
    #all this just to transform to mat format?
    mat <- matrix(mat, ncol = numCol, byrow = TRUE)
    #creat the net itself
    net <- graph_from_adjacency_matrix(mat, mode = "undirected", weighted = TRUE)
    folderPath <- dirname(toString(matFile))
    #numberParams
    if (maxNumberOfInteration > 0) {
      #normalization to the number of the max interaction to the weights of the network this is not happning in lengthparams
      E(net)$weight <- E(net)$weight / maxNumberOfInteration
      E(net)$width <- E(net)$weight*7
      #the 7 and 25?? is for the vertex size for visualization beacuse the lenght value are smaller than the number values
      cur <- calculateNetworksParams(net, folderPath, "number of interaction", 7,fileNames[i])
    } else {
      #which means length of interaction
      E(net)$width <- E(net)$weight*10
      
      cur <- calculateNetworksParams(net, folderPath, "length of interction", 25,fileNames[i])
    }
    #for each of the movies
    density <- c(cur[1], density)
    modularity <- c(cur[2], modularity)
    sdStrength <- c(cur[3], sdStrength)
    strength <- c(cur[4], strength)
    betweenness <- c(cur[5], betweenness)
  }
  
  return(list(density, modularity, sdStrength, strength, betweenness))
}
importClassifierFilesAndCalculatePerFrame<-function(){
  dir<-list.dirs(recursive = F)
  print(dir)
  allscore.df<-data.frame()
  score.df<-data.frame()
  totalscore.df<-data.frame()
  finalavepermovie.df<-data.frame()
  
  first<-T
  for(k in 1:length(dir)){
    curr.dir<-(paste0(dir[k],'/')) 
    print(k)
    print(curr.dir)
    #find all that contains the word scores
    files<-list.files(path=paste0(curr.dir), pattern = 'scores')
    #print(files)
    avepermovie.df<-data.frame()
    first<-T
    #the number of scores there  is 11
    for(j in 1:length(files)){
      file<-readMat(paste0(curr.dir,'/',files[j])) #read each mat file
      score.df<-data.frame()
      #for each of the number of flies there is (10)
      for (i in 1:length(file$allScores[[4]])){
        #everytime overide the last temp.df
        tmp.df <- data.frame(dir=dir[k], files=files[j], fly=i, value=as.numeric(file$allScores[[4]][[i]][[1]])) # convert format of data for each fly
        # add to dataframe of one movie
        # calculate average per frame
        if (mean(tmp.df$value)!=0){
          scores.table<-(table(tmp.df$value))/(length(tmp.df$value)) #calculate frequency of behavior
          tmpflyscore.df<-data.frame(dir=dir[k], files=files[j], fly=i, values=(scores.table[2])) 
          score.df<-rbind(score.df, tmpflyscore.df)
        }
        else{
          tmpflyscore.df<-data.frame(dir=dir[k], files=files[j], fly=i, values=(scores.table[2])) 
          score.df<-rbind(score.df, tmpflyscore.df)
        }
      }
      if (first){
        avepermovie.df<-data.frame(dir=dir[k], file=files[j], value=mean(score.df$values))
      }
      else{
        tmp_avepermovie.df<-data.frame(dir=dir[k], file=files[j], value=mean(score.df$values)) #calculate average per movie
        avepermovie.df<-cbind(avepermovie.df, tmp_avepermovie.df) #add averages to one list
      }
      
      if (first){
        allscore.df<-score.df
        first<-F
      }
      else
        allscore.df<-cbind(allscore.df,score.df) # merge all files in each movie
      
    }
    totalscore.df<-rbind(totalscore.df, allscore.df) #merge all into one table according to file name
    finalavepermovie.df<-rbind(finalavepermovie.df, avepermovie.df)
  }
  
  write.csv(totalscore.df, 'all_classifier_scores.csv', row.names = F)
  write.csv(finalavepermovie.df, 'all_classifier_averages.csv', row.names = F)
  
}

creatNetwork3popforscatter<-function(){
  group_name = "MalesSingels"
  setwd('F:/statistic_test')
  
  #where we choosing the files we want for analysis
  #xlsxFile <- choose.files()
  #all data is the data from the exel in the first sheet
  allData <- read.xlsx("expData_0_to_27000.xlsx")
  
  lengthParams <- c()
  numberParams <- c()
  numberOfMovies<-c()
  for (i in 1:allData$Number.of.groups[1]) {
    #it is depened on the poisiton of the colom in the execl so we can get the length and number files
    cur <- (i + 1) * 2
    numberOfMovies[i]<- allData[i, 3]
    #the params are density, modularity, sdStrength, strength, betweenness
    lengthParams <- cbind(lengthParams, calculateGroupParams(allData[1:numberOfMovies[i], cur], 0))
    numberParams <- cbind(numberParams, calculateGroupParams(allData[1:numberOfMovies[i], cur + 1], allData$Max.number.of.interaction[1]))
  }
  

  #parametrs name
  paramsNames <- c("Density", "Modularity", "SD Strength", "Strength", "Betweenness Centrality")
  #light or dark
  groupsNames <- as.character(na.omit(allData$Groups.names))
  lengthAvg1 <- c()
  lengthAvg2 <- c()
  lengthAvg3<- c()
  numberAvg1 <- c()
  numberAvg2 <- c()
  numberAvg3<-c()
  #5 time
  
  
  
  
  for (i in 1:length(paramsNames)) {
    lengthAvg1 <- c(lengthAvg1, mean(unlist(lengthParams[i,1])))
    lengthAvg2 <- c(lengthAvg2, mean(unlist(lengthParams[i,2])))
    lengthAvg3 <- c(lengthAvg3, mean(unlist(lengthParams[i,3])))
    numberAvg1 <- c(numberAvg1, mean(unlist(numberParams[i,1])))
    numberAvg2 <- c(numberAvg2, mean(unlist(numberParams[i,2])))
    numberAvg3 <- c(numberAvg3, mean(unlist(numberParams[i,3])))
  }
  
  
  lengthMaxValues <- c(0.2,0.25,0.6,1.5,5)
  numberMaxValues <- c(0.4,0.2,0.85,3.5,4)
  
  
  
  index_name <- function(input_name,groupsNames){
    
    for (i in 1:length(groupsNames)){
      if(input_name == groupsNames[i]){
        return (i)
      }
    }
  }
  
  my_index = index_name(group_name,groupsNames)
  
  
  
  densL <<- cbind(lengthAvg1[1], lengthAvg2[1])
  densL <<- cbind(densL, lengthAvg3[1])
  densL<<-densL[my_index]
  
  #density,mudilarity,sd strength,strength,bewtweenss
  varience<<-c(sd(unlist(lengthParams[1,my_index])),sd(unlist(lengthParams[2,my_index])),sd(unlist(lengthParams[3,my_index])),sd(unlist(lengthParams[4,my_index])),sd(unlist(lengthParams[5,my_index])),sd(unlist(numberParams[1,my_index])),sd(unlist(numberParams[2,my_index])),sd(unlist(numberParams[3,my_index])),sd(unlist(numberParams[4,my_index])),sd(unlist(numberParams[5,my_index])))
  
  modL <<- cbind(lengthAvg1[2], lengthAvg2[2])
  modL <<- cbind(modL, lengthAvg3[2])
  
  modL<<-modL[my_index]
  
  
  sdL <<- cbind(lengthAvg1[3], lengthAvg2[3])
  sdL <<- cbind(sdL, lengthAvg3[3])
  sdL<<-sdL[my_index]
  
  
  
  strL <<- cbind(lengthAvg1[4], lengthAvg2[4])
  strL <<- cbind(strL, lengthAvg3[4])
  strL<<-strL[my_index]
  
  
  betL <<- cbind(lengthAvg1[5], lengthAvg2[5])
  betL <<- cbind(betL, lengthAvg3[5])
  
  betL<<-betL[my_index]
  
  
  densN <<- cbind(numberAvg1[1], numberAvg2[1])
  densN <<- cbind(densN, numberAvg3[1])
  densN<<-densN[my_index]
  
  
  
  modN <<- cbind(numberAvg1[2], numberAvg2[2])
  modN <<- cbind(modN, numberAvg3[2])
  modN<<-modN[my_index]
  
  
  sdN <<- cbind(numberAvg1[3], numberAvg2[3])
  sdN <<- cbind(sdN, numberAvg3[3])
  sdN<<-sdN[my_index]
  
  
  strN <<- cbind(numberAvg1[4], numberAvg2[4])
  strN <<- cbind(strN, numberAvg3[4])
  strN<<-strN[my_index]
  
  
  betN <<- cbind(numberAvg1[5], numberAvg2[5])
  betN <<- cbind(betN, numberAvg3[5])
  betN<<-betN[my_index]
  
}
boutLengthAndFrequencyForClassifiers<-function(){
  str1 = "frq_"
  dir<-list.dirs(recursive = F)
  print(dir)
  ave_bl<-data.frame()
  total_bl<-data.frame()
  total_all<-data.frame()
  per_fly_freq<-data.frame()
  total_freq_all<-data.frame()
  ave_bl_fly<-data.frame()
  first<-T
  for(k in 1:length(dir)){
    curr.dir<-(paste0(dir[k],'/')) 
    print(k)
    print(curr.dir)
    files<-list.files(path=paste0(curr.dir), pattern = 'scores')
    first<-T
    total.df<-data.frame()
    total_freq.df<-data.frame()
    for(j in 1:length(files)){
      file<-readMat(paste0(curr.dir,'/',files[j])) #read each mat file
      ave_bl<-data.frame()
      for (i in 1:length(file$allScores[[4]])){
        tmp.df <- data.frame(dir=dir[k], files=files[j], fly=i, value=as.numeric(file$allScores[[4]][[i]][[1]])) # convert format of data for each fly
        
        ### get bout length for each fly ###
        counter<-0
        bl_vector<-data.frame()
        first_bout<-0
        for (m in 1:length(tmp.df$value)){ # get bout length of one fly
          if ((tmp.df$value[m]==1)&(first_bout==0)){
            counter<-1
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
        ave_bl_fly<-mean(bl_vector)
        ave_bl<-rbind(ave_bl,as.numeric(colMeans(bl_vector, na.rm = T, dims = 1))) # combine average bout lengths of all flies per movie
        per_fly_freq<-rbind(per_fly_freq, as.numeric(lengths(bl_vector)/length(tmp.df$value))) # combine frequency of all flies
      }
      ave_per_movie<-colMeans(ave_bl, na.rm = T, dims = 1)
      ave_freq_movie<-colMeans(per_fly_freq, na.rm = T, dims = 1)
      if (is.numeric(ave_bl)==F){
        ave_per_movie<-data.frame(0)
      }
      total_bl <- data.frame(dir=dir[k], files=files[j], value=as.numeric(ave_per_movie)) # data frame per file
      total_freq <- data.frame(dir=dir[k], files=paste(str1,files[j]), value=as.numeric(ave_freq_movie)) # frequency per file
      total.df<-rbind(total.df, total_bl) #add to averages of all files per directory
      total_freq.df<-rbind(total_freq.df, total_freq) #frequency of all files per directory
    }
    ### add average bout length to data frame of averages per movie ###
    if (is.numeric(total_all$value)==F){
      total_all<-total.df
      total_freq_all<-total_freq.df
    }
    else{
      total_all<-cbind(total_all, total.df)
      total_freq_all<-cbind(total_freq_all, total_freq.df)
    }
    
  }
  warnings()
  write.csv(total_all, 'bout_length_scores.csv', row.names = F)
  write.csv(total_freq_all, 'frequency_scores.csv', row.names = F)
  
}
combineKineticAndClassifiersToSignature<-function(){
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
  new_frq.df<-data.frame()
  all.df<-cbind(ave_classifiers.df, ave_kinetic.df)
  #all.df<-rbind(all.df, ave_frq.df)
  
  all_freq.df<-data.frame(ave_frq.df[, c('files','value', 'value.1', 'value.2','value.3','value.4','value.5','value.6','value.7','value.8','value.9')])
  #avg_of_frq<-data.frame(files=ave_frq.df[,2], value=rowMeans(all_freq[1:9]),Variance =rowSds(all_freq[1:9]) )
  
  for (i in 2:length(ave_frq.df)){
    
    
    ave_frq.df[[i-1]]<-factor(ave_frq.df[[i-1]])
    print(levels(ave_frq.df[[i-1]]))
    avg_of_frq.df<-data.frame(file=levels(ave_frq.df[[i-1]]),   value=mean(unlist(all_freq.df[i,2:11])),Variance =sd(unlist(all_freq.df[i,2:11])) ) # create average per condition
    new_frq.df<-rbind(new.df, avg_of_frq.df) # make list of averages per condition of all features
    
    
  }
  
  for (i in 1:11){
    new_frq.df[i,]$value = mean(unlist(all_freq.df[i,2:11]))
    new_frq.df[i,]$Variance = sd(unlist(all_freq.df[i,2:11]))
    
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
  new.df<-rbind(new.df,network.df)
  
  new.df<-rbind(new.df,new_frq.df)
  
  
  
  write.csv(all.df, 'combined per movie.csv',row.names = F)
  write.csv(new.df, 'averages per condition.csv', row.names = F)
}
averagesPerMovieByFile()
importClassifierFilesAndCalculatePerFrame()

creatNetwork3popforscatter()
setwd('F:/statistic_test/MalesSingels')
#boutLengthAndFrequencyForClassifiers()
combineKineticAndClassifiersToSignature()