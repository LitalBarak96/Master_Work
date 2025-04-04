require(R.matlab)
library(base)
library(openxlsx)
library(igraph)
library(ggplot2)
library(cowplot)
library(ggpubr)
library(ggsignif)
library(nortest)
library(fmsb)
library(argparser, quietly=TRUE)
library(stringr)
library("readxl")

densL<-c()
varience<-c()
modL<-c()
sdL<-c()
strL<-c()
betL<-c()
densN<-c()
modN<-c()
sdN<-c()
strN<-c()
betN<-c()
group_name<-c()
number_of_pop =2
with_rgb = FALSE
number_of_features = 11
number_of_flies= 10
number_of_movies <-c()


rgb_2_hex <- function(r,g,b){rgb(r, g, b, maxColorValue = 1)}

if (with_rgb== TRUE){
  p <- arg_parser("chosing color")
  
  # Add command line arguments
  p <- add_argument(p,
                    c("R1", "G1", "B1","R2", "G2", "B2"),
                    help = c("red1", "green1", "blue1","red2", "green2", "blue2"),
                    flag = c(FALSE, FALSE, FALSE,FALSE, FALSE, FALSE))
  
  
  # Parse the command line arguments
  argv <- parse_args(p)}
#setting the path 

the_path = 'F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Grouped'
other_path = 'F:/all_data_of_shir/shir_ben_shushan/Shir Ben Shaanan/old/Grouped vs Single/Single'

#give the name of the group (the last name in the dir of the path)

#excatly how many movies are in the folder
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
all_z_score<-function(){
  setwd(the_path) #where is the data folder
  
  
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
  
  
  
  setwd(other_path) #where is the data folder
  ave_kinetic_Sec.df<-as.data.frame(read.csv('averages per movie.csv'))
  ave_classifiers_sec.df<-as.data.frame(read.csv('all_classifier_averages.csv'))
  
  Sec_classf.df<-data.frame(ave_classifiers_sec.df[,seq(3, length(ave_classifiers_sec.df), 3)])                         
  Sec_kinef.df<-data.frame(ave_kinetic_Sec.df[,seq(3, length(ave_kinetic_Sec.df), 3)])                         
  
  
  ave_bl_sec.df<-as.data.frame(read.csv('bout_length_scores.csv'))
  ave_frq_sec.df<-as.data.frame(read.csv('frequency_scores.csv'))
  
  
  
  
  
  # i need to do this for the 2 groupes at once 
  
  
  
  
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
  
  
  setwd(the_path) #where is the data folder
  
  write.csv(ave_classifiers_first.df, 'all_classifier_averages.csv', row.names = F)
  write.csv(ave_kinetic_first.df, 'averages per movie.csv', row.names=F)
  write.csv(ave_bl_first.df, 'bout_length_scores.csv', row.names = F)
  write.csv(ave_frq_first.df, 'frequency_scores.csv', row.names = F)
  
  
  setwd(other_path) #where is the data folder
  write.csv(ave_classifiers_sec.df, 'all_classifier_averages.csv', row.names = F)
  write.csv(ave_kinetic_Sec.df, 'averages per movie.csv', row.names=F)
  write.csv(ave_bl_sec.df, 'bout_length_scores.csv', row.names = F)
  write.csv(ave_frq_sec.df, 'frequency_scores.csv', row.names = F)
  
  
  
}
#function avg per movie of assa
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
    if (k==1)
      total_movie_ave.df<- movie_ave.df
    else 
      total_movie_ave.df<-rbind(total_movie_ave.df, movie_ave.df)
    
    ordered_ave<- col.df[order(col.df$file),]
    final.df<-rbind(final.df, ordered_ave)
  }
  write.csv(total_movie_ave.df, 'averages per movie.csv', row.names=F)

  
}
#help function for creat network
calculateNetworksParams <- function(net, folderPath, graphName, vertexSize,fileName) {
  # all
  print(fileName)
  vertexNumber = gorder(net)
  par(mfrow=c(1,1), mar=c(1,1,1,1))
  l <- layout_in_circle(net)

  # density
  density <- sum(E(net)$weight) / (vertexNumber * (vertexNumber - 1) / 2)

  
  # modularity
  #This function tries to find densely connected subgraphs
  wtc <- cluster_walktrap(net)
  modularity <- modularity(wtc)
 
  
  # strength std
  sdStrength <- sd(strength(net, weights = E(net)$weight))

  
  #individual
  
  # strength
  #Summing up the edge weights of the adjacent edges for each vertex.
  print(net)
  strength <- strength(net, weights = E(net)$weight)
  

  
  # betweenness centality 
  betweenness <- betweenness(net, v = V(net), directed = FALSE, weights = E(net)$weight)

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
#calculating each feature of the network
#calculating density, modularity, sdStrength, strength, betweenness

creatNetwork2popforscatter<-function(current_path){
  group_name_dir = tools::file_path_sans_ext(dirname((current_path)))
  setwd(group_name_dir)
  
  #where we choosing the files we want for analysis
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
  numberAvg1 <- c()
  numberAvg2 <- c()

  
  #for number param
  for (j in 1:3){
    x <- data.matrix(unlist(numberParams[j,1]))
    y<-data.matrix(unlist(numberParams[j,2]))
    #reading the value to data matrix for the scale
    #creating dataframe that combine the 2 pop together
    combined_2_group<- data.frame(group=c(rep("x", length(x[,1])), rep("y", length(y[,1]))), value=c(x[,1],y[,1]))
    #need to find combine this 2 loops cuz nrow somehow not an double
    temp_x<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(x) numeric(12)))
    temp_y<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(y) numeric(12)))
    #creat 2 diffrent data frame to separt them from eachother
    combined_2_group$value<-scale(c(x,y), center = T, scale = T)
    
    #separat each other base on the symbol they got
    a<-subset(combined_2_group, group %in% "x")
    temp_x[,1]<-a$value
    b<-subset(combined_2_group, group %in% "y")
    temp_y[,1]<-b$value
    
    #return them to each other cuz they are list 
    numberParams[j,1]<-(list(temp_x[,1]))
    numberParams[j,2]<-(list(temp_y[,1]))
    
  }
  
  
  #for length param
  for (j in 1:3){
    x <- data.matrix(unlist(lengthParams[j,1]))
    y<-data.matrix(unlist(lengthParams[j,2]))
    
    
    combined_2_group<- data.frame(group=c(rep("x", length(x[,1])), rep("y", length(y[,1]))), value=c(x[,1],y[,1]))
    #need to find combine this 2 loops cuz nrow somehow not an double
    temp_x<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(x) numeric(12)))
    temp_y<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(y) numeric(12)))
    
    combined_2_group$value<-scale(c(x,y), center = T, scale = T)
    
    a<-subset(combined_2_group, group %in% "x")
    temp_x[,1]<-a$value
    b<-subset(combined_2_group, group %in% "y")
    temp_y[,1]<-b$value
    
    lengthParams[j,1]<-(list(temp_x[,1]))
    lengthParams[j,2]<-(list(temp_y[,1]))
    
  }
  
  
  for(j in 4:5){
    x <- data.matrix(unlist(numberParams[j,1]))
    y<-data.matrix(unlist(numberParams[j,2]))
    
    combined_2_group<- data.frame(group=c(rep("x", length(x[,1])), rep("y", length(y[,1]))), value=c(x[,1],y[,1]))
    
    temp_x<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(x) numeric(120)))
    temp_y<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(x) numeric(120)))
    
    combined_2_group$value<-scale(c(x,y), center = T, scale = T)
    
    a<-subset(combined_2_group, group %in% "x")
    temp_x[,1]<-a$value
    b<-subset(combined_2_group, group %in% "y")
    temp_y[,1]<-b$value
    
    numberParams[j,1]<-(list(temp_x[,1])) 
    numberParams[j,2]<-(list(temp_y[,1])) 
    
  }
  
  #for length param
  for(j in 4:5){
    x <- data.matrix(unlist(lengthParams[j,1]))
    y<-data.matrix(unlist(lengthParams[j,2]))
    
    combined_2_group<- data.frame(group=c(rep("x", length(x[,1])), rep("y", length(y[,1]))), value=c(x[,1],y[,1]))
    
    temp_x<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(x) numeric(120)))
    temp_y<-as.data.frame(lapply(structure(.Data=1:2,.Names=1:2),function(x) numeric(120)))
    
    combined_2_group$value<-scale(c(x,y), center = T, scale = T)
    
    a<-subset(combined_2_group, group %in% "x")
    temp_x[,1]<-a$value
    b<-subset(combined_2_group, group %in% "y")
    temp_y[,1]<-b$value
    
    lengthParams[j,1]<-(list(temp_x[,1])) 
    lengthParams[j,2]<-(list(temp_y[,1])) 
    
  }
  
  
  #Put in avg values
  for (i in 1:length(paramsNames)) {
    lengthAvg1 <- c(lengthAvg1, mean(unlist(lengthParams[i,1])))
    lengthAvg2 <- c(lengthAvg2, mean(unlist(lengthParams[i,2])))
    numberAvg1 <- c(numberAvg1, mean(unlist(numberParams[i,1])))
    numberAvg2 <- c(numberAvg2, mean(unlist(numberParams[i,2])))

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
  densL<<-densL[my_index]
  
  #density,mudilarity,sd strength,strength,bewtweenss SE
  varience<<-c(sd(unlist(lengthParams[1,my_index])),sd(unlist(lengthParams[2,my_index])),sd(unlist(lengthParams[3,my_index])),sd(unlist(lengthParams[4,my_index])),sd(unlist(lengthParams[5,my_index])),sd(unlist(numberParams[1,my_index])),sd(unlist(numberParams[2,my_index])),sd(unlist(numberParams[3,my_index])),sd(unlist(numberParams[4,my_index])),sd(unlist(numberParams[5,my_index])))

  modL <<- cbind(lengthAvg1[2], lengthAvg2[2])
  modL<<-modL[my_index]
  
  
  sdL <<- cbind(lengthAvg1[3], lengthAvg2[3])
  sdL<<-sdL[my_index]
  
  
  
  strL <<- cbind(lengthAvg1[4], lengthAvg2[4])
  strL<<-strL[my_index]
  
  
  betL <<- cbind(lengthAvg1[5], lengthAvg2[5])
  
  betL<<-betL[my_index]
  
  
  densN <<- cbind(numberAvg1[1], numberAvg2[1])
  densN<<-densN[my_index]
  
  
  
  modN <<- cbind(numberAvg1[2], numberAvg2[2])
  modN<<-modN[my_index]
  
  
  sdN <<- cbind(numberAvg1[3], numberAvg2[3])
  sdN<<-sdN[my_index]
  
  
  strN <<- cbind(numberAvg1[4], numberAvg2[4])
  strN<<-strN[my_index]
  
  
  betN <<- cbind(numberAvg1[5], numberAvg2[5])
  betN<<-betN[my_index]
  
  
  setwd(current_path)
  names<-c("density(LOI)","modularity(LOI)","sd strength(LOI)","strength(LOI)","betweens(LOI)","density(NOI)","modularity(NOI)","sd strength(NOI)","strength(NOI)","betweens(NOI)")  
  values<-c(densL,modL,sdL,strL,betL,densN,modN,sdN,strN,betN)
  network.df<-data.frame(names,values,varience)
  colnames(network.df) <- c("file", "value","Variance")
  write.csv(network.df, 'network.csv', row.names = F)
  
  
}
boutLengthAndFrequencyForClassifiers<-function(){
  str1 = "frequency"
  str2 = "bout length"
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
        #ave_bl_fly<-mean(bl_vector)
        ave_bl<-rbind(ave_bl,as.numeric(colMeans(bl_vector, na.rm = T, dims = 1))) # combine average bout lengths of all flies per movie
        per_fly_freq<-rbind(per_fly_freq, as.numeric(lengths(bl_vector)/length(tmp.df$value))) # combine frequency of all flies
      }
      ave_per_movie<-mean(colMeans(ave_bl, na.rm = T, dims = 1))
      ave_freq_movie<-colMeans(per_fly_freq, na.rm = T, dims = 1)
      if (is.numeric(mean(ave_bl))==F){
        ave_per_movie<-data.frame(0)
      }
      total_bl <- data.frame(dir=dir[k], files=paste(str2,files[j]), value=as.numeric(ave_per_movie)) # data frame per file
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
  #remove all the na
  total_all[is.na(total_all)] <- 0
  write.csv(total_all, 'bout_length_scores.csv', row.names = F)
  write.csv(total_freq_all, 'frequency_scores.csv', row.names = F)
  
}
#creat the final csv for creating the scatter plot ,calculating the var in here
combineKineticAndClassifiersToSignature<-function(){
  all.df<-data.frame()
  bl_frq.df<-data.frame()
  all_bl.df<-data.frame()
  all_freq.df<-data.frame()
  ave_kinetic.df<-data.frame()
  network.df<-data.frame()
  ave_frq.df<-data.frame()
  ave_classifiers.df<-data.frame()
  ave_bl.df<-data.frame()
  avg_of_bl.df<-data.frame()
  avg_of_frq.df<-data.frame()
  tmp_new.df<-data.frame()
  
  ave_kinetic.df<-as.data.frame(read.csv('averages per movie.csv'))
  ave_classifiers.df<-as.data.frame(read.csv('all_classifier_averages.csv'))
  ave_bl.df<-as.data.frame(read.csv('bout_length_scores.csv'))
  ave_frq.df<-as.data.frame(read.csv('frequency_scores.csv'))
  network.df<-as.data.frame(read.csv('network.csv'))
  
  new.df<-data.frame()
  new_frq.df<-data.frame()
  new_bl.df<-data.frame()
  new_nt.df<-data.frame()
  all.df<-cbind(ave_classifiers.df, ave_kinetic.df)
  
  
  #bout length
  all_bl.df<-data.frame(ave_bl.df[,seq(3, number_of_movies*3, 3)])                         
  for (i in 2:length(ave_bl.df)){
    
    ave_bl.df[[i-1]]<-factor(ave_bl.df[[i-1]])
    print(levels(ave_bl.df[[i-1]]))
    avg_of_bl.df<-data.frame(file=levels(ave_bl.df[[i-1]]),   value=mean(unlist(all_bl.df[i,])),Variance =sd(unlist(all_bl.df[i,]))) # create average per condition
    new_bl.df<-rbind(new.df, avg_of_bl.df) # make list of averages per condition of all features
    
    
  }
  
  for (i in 1:number_of_features){
    new_bl.df[i,]$value = mean(unlist(all_bl.df[i,1:number_of_movies]))
    new_bl.df[i,]$Variance = sd(unlist(all_bl.df[i,1:number_of_movies]))
    
  }
  
  
  
  
  #the data frame is look as pairs of 3 of values and we needed the third each time
  all_freq.df<-data.frame(ave_frq.df[,seq(3, number_of_movies*3, 3)])
  
  for (i in 2:length(ave_frq.df)){
    ave_frq.df[[i-1]]<-factor(ave_frq.df[[i-1]])
    print(levels(ave_frq.df[[i-1]]))
    #the real mean value is calculated down,for some reason it is not worknig here but I kept it beacuse I wamted the value colom
    avg_of_frq.df<-data.frame(file=levels(ave_frq.df[[i-1]]),   value=mean(unlist(all_freq.df[i,2:number_of_movies])),Variance =sd(unlist(all_freq.df[i,2:number_of_movies]))) # create average per condition
    new_frq.df<-rbind(new.df, avg_of_frq.df) # make list of averages per condition of all features
    #bind to the end each time
    
  }
  
  #11 features of non network related features(frequancy features from jaaba)
  for (i in 1:number_of_features){
    new_frq.df[i,]$value = mean(unlist(all_freq.df[i,1:number_of_movies]))
    new_frq.df[i,]$Variance = sd(unlist(all_freq.df[i,1:number_of_movies]))
    
  }
  
  
  for (k in 1:length(all.df)){
    
    if (is.numeric(all.df[[k[1]]])){
      all.df[[k-1]]<-factor(all.df[[k-1]])
      print(levels(all.df[[k-1]]))
      tmp_new.df<-data.frame(file=levels(all.df[[k-1]]), value=mean(all.df[[k]]), Variance=sd(all.df[[k]])) # create average per condition
      new.df<-rbind(new.df, tmp_new.df) # make list of averages per condition of all features
    }
  }
  #network don't need to be proccesed 
  new.df<-rbind(new.df,network.df)
  new.df<-rbind(new.df,new_frq.df)
  new.df<-rbind(new.df,new_bl.df)
  
  
  write.csv(all.df, 'combined per movie.csv',row.names = F)
  write.csv(new.df, 'averages per condition.csv', row.names = F)
  
}

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


vizual<-function(){
  
  first.df<-data.frame()
  second.df<-data.frame()
  
  
  if(number_of_pop ==3 ){
    third.df<-data.frame()
    
  }
  #choosing the files getting the name and the number of files for SE
  #pop 1
  xlsxFile <- choose.files()
  xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
  first.df<-as.data.frame(read.csv(xlsxFile))
  name1 = xlsxName
  group_name_in_first = tools::file_path_sans_ext(dirname((xlsxFile)))
  number_of_movies_in_first =length(list.dirs(path=group_name_in_first, full.names=T, recursive=F ))
  
  
  
  #pop 2
  xlsxFile <- choose.files()
  xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
  second.df<-as.data.frame(read.csv(xlsxFile))
  name2 = xlsxName
  group_name_in_second = tools::file_path_sans_ext(dirname((xlsxFile)))
  number_of_movies_in_second =length(list.dirs(path=group_name_in_second, full.names=T, recursive=F ))
  if(number_of_pop == 3){
    #Pop 3
    xlsxFile <- choose.files()
    xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
    third.df<-as.data.frame(read.csv(xlsxFile))
    name3= xlsxName
    group_name_in_third = tools::file_path_sans_ext(dirname((xlsxFile)))
    number_of_movies_in_third =length(list.dirs(path=group_name_in_third, full.names=T, recursive=F ))
  }
  
  
  
  
  library(ggplot2)
  library(gridExtra)
  if (with_rgb == TRUE){
    a<-rgb_2_hex(argv$R1,argv$G1,argv$B1)
    b<-rgb_2_hex(argv$R2,argv$G2,argv$B2)
  }
  
  else{
    a<-"#4DB3E6"
    b<-"#37004D"
  }
  
  
  first.df$id <- name1  # or any other description you want
  second.df$id <- name2
  
  
  
  first.df$Variance=first.df$Variance/(sqrt(number_of_movies_in_first*number_of_flies))
  second.df$Variance=second.df$Variance/(sqrt(number_of_movies_in_second*number_of_flies))
  
  
  
  full_title = paste(name1,"vs",name2)
  first.df$file<-tools::file_path_sans_ext(first.df$file)
  first.df$file<- str_replace(first.df$file, "scores_", "")
  
  second.df$file<-tools::file_path_sans_ext(second.df$file)
  second.df$file<- str_replace(second.df$file, "scores_", "")
  
  order.df <- as.data.frame(read_excel(file.choose()))
  test1 <- data.frame(matrix(ncol = 4, nrow = 57))
  colnames(test1) <- c('file','value','Variance','id')
  for (i in 1:nrow(order.df)){
    for(j in 1:nrow(first.df)){
      if(order.df[i,]==first.df[j,]$file){
        test1[i,]<-first.df[j,]
        
      }
      else{
        
      }
      
    }
    
    
  }
  test1 <- na.omit(test1) 
  rownames(test1) <-1:nrow(test1)
  
  
  
  
  
  test2 <- data.frame(matrix(ncol = 4, nrow = 57))
  colnames(test2) <- c('file','value','Variance','id')
  
  for (i in 1:nrow(order.df)){
    for(j in 1:nrow(second.df)){
      if(order.df[i,]==second.df[j,]$file){
        test2[i,]<-second.df[j,]
        
      }
      else{
        
      }
      
    }
    
    
  }
  
  test2<- na.omit(test2) 
  rownames(test2) <-1:nrow(test2)
  
  df.all <- rbind(test1, test2)
  test1$file<-as.character(test1$file)
  test2$file<-as.character(test2$file)
  
  test1$file <- factor(test1$file, levels=unique(test1$file))
  test2$file <- factor(test2$file, levels=unique(test2$file))
  
  df.all <- rbind(test1, test2)

  
  t <- ggplot(df.all, aes(x=value, y=file, group=id, color=id)) + 
    geom_point(data = test1, colour  = a,size =1)+geom_point(data = test2, colour  = b,size =1)+scale_color_identity()+
    geom_pointrange(data=df.all,mapping=aes(xmax=value+Variance, xmin=value-Variance), size=0.08)+scale_colour_manual(values=c(a, b))+
    xlim(-3,3)+ggtitle(full_title)+theme_minimal()
  
  setwd((choose.dir(default = "", caption = "Select folder for saving the scatter plot")))
  print(t)
  ggsave(plot = t, filename = "scatterplot.pdf", height=15, width=15)
  
}

#at first we need to do false for each group and change the other path and then normelize_z need to 
#be true 

for (i in 1:number_of_pop){
  if (i ==1 ){
    the_path_test =the_path
  }
  if(i==2){
    the_path_test =other_path
    
  }
  setwd(the_path_test)
  group_name <<- tools::file_path_sans_ext(basename((the_path_test)))
  number_of_movies <<-length(list.dirs(path=the_path_test, full.names=T, recursive=F ))
  averagesPerMovieByFile()
  setwd(the_path_test)
  importClassifierFilesAndCalculatePerFrame()
  setwd(the_path_test)
  creatNetwork2popforscatter(the_path_test)
  setwd(the_path_test)
  boutLengthAndFrequencyForClassifiers()
  
}


  all_z_score()
  setwd(the_path)
  number_of_movies <<-length(list.dirs(path=the_path, full.names=T, recursive=F ))
  combineKineticAndClassifiersToSignature()
  setwd(other_path)
  number_of_movies <<-length(list.dirs(path=other_path, full.names=T, recursive=F ))
  combineKineticAndClassifiersToSignature()
  vizual()
