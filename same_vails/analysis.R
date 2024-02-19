

xlsxFile <- choose.files(default = "", caption = "Select expData_0_to_27000 file")
#all data is the data from the exel in the first sheet
allData <- read.xlsx(xlsxFile)


lengthParams <- c()
numberParams <- c()
numberOfMovies<-c()
print(dirname(xlsxFile))
setwd(dirname(xlsxFile))
for (j in 1:allData$Number.of.groups[1]) {
  cur <- (j + 1) * 2
  numberOfMovies[j]<- allData[j, 3]
  
  fileNames<-allData[1:numberOfMovies[j], cur+1]
  for (i in 1:length(fileNames)) {
    #when debuging see what is inside matfile
    matFile <- fileNames[i]
    mat <- scan(toString(matFile))
    #because the matrix is smetric and there is 100 value so it is 10
    numCol <- sqrt(length(mat))
    number_of_flies<<-numCol
    #all this just to transform to mat format?
    mat <- matrix(mat, ncol = numCol, byrow = TRUE)
    #creat the net itself
    
    plotname<-paste0(dirname(toString(matFile)),"/net_number.jpeg")
    # tiff(file=plotname,units="in",height=11,width=11,res=1000)
    # 
    # net <- graph_from_adjacency_matrix(mat, mode = "undirected", weighted = TRUE)
    # 
    # plot(net)
    # dev.off()
    
    #numberParams
  }
  

 
}





for (j in 1:allData$Number.of.groups[1]) {
  numberOfMovies[j]<- allData[j, 3]
  

  
  
}


#same_vails



j=1
cur <- (j + 1) * 2

full_mat_number<-NULL
numberOfMovies[j]<- allData[j, 3]


fileNames<-allData[1:numberOfMovies[j], cur+1]
for (i in 1:length(fileNames)) {
  #when debuging see what is inside matfile
  matFile <- fileNames[i]
  mat <- scan(toString(matFile))
  #because the matrix is smetric and there is 100 value so it is 10
  numCol <- sqrt(length(mat))
  number_of_flies<<-numCol
  #all this just to transform to mat format?
  mat <- matrix(mat, ncol = numCol, byrow = TRUE)
  mat<-as.data.frame(mat[lower.tri(mat)])
  full_mat_number<-bind_rows(mat,full_mat_number)
  #numberParams
}

colnames(full_mat_number)<-"number"

full_mat_length<-NULL


fileNames<-allData[1:numberOfMovies[j], cur]
for (i in 1:length(fileNames)) {
  matFile <- fileNames[i]
  mat <- scan(toString(matFile))
  #because the matrix is smetric and there is 100 value so it is 10
  numCol <- sqrt(length(mat))
  number_of_flies<<-numCol
  #all this just to transform to mat format?
  mat <- matrix(mat, ncol = numCol, byrow = TRUE)
  mat<-as.data.frame(mat[lower.tri(mat)])
  
  full_mat_length<-bind_rows(mat,full_mat_length)
  #numberParams
}


colnames(full_mat_length)<-"length"


#diffrent vails
j=2


cur <- (j + 1) * 2

full_mat_number_diff<-NULL
#numberOfMovies[j]<- allData[j, 3]


fileNames<-allData[1:numberOfMovies[j], cur+1]
for (i in 1:length(fileNames)) {
  #when debuging see what is inside matfile
  matFile <- fileNames[i]
  mat <- scan(toString(matFile))
  #because the matrix is smetric and there is 100 value so it is 10
  numCol <- sqrt(length(mat))
  number_of_flies<<-numCol
  #all this just to transform to mat format?
  mat <- matrix(mat, ncol = numCol, byrow = TRUE)
  mat<-as.data.frame(mat[lower.tri(mat)])
  full_mat_number_diff<-bind_rows(mat,full_mat_number_diff)
  #numberParams
}



full_mat_length_diff<-NULL


fileNames<-allData[1:numberOfMovies[j], cur]
for (i in 1:length(fileNames)) {
  #when debuging see what is inside matfile
  matFile <- fileNames[i]
  mat <- scan(toString(matFile))
  #because the matrix is smetric and there is 100 value so it is 10
  numCol <- sqrt(length(mat))
  number_of_flies<<-numCol
  #all this just to transform to mat format?
  mat <- matrix(mat, ncol = numCol, byrow = TRUE)
  mat<-as.data.frame(mat[lower.tri(mat)])
  full_mat_length_diff<-bind_rows(mat,full_mat_length_diff)
  #numberParams
}


full_mat_length_diff<-as.numeric(full_mat_length_diff$mat)
full_mat_length<-as.numeric(full_mat_length$length)


length_<-data.frame(diff = full_mat_length_diff,same =full_mat_length)

library(reshape2)

melt_data_len <- melt(length_) 


shapiro.test(length_$diff)

shapiro.test(length_$same)

#if smaller than 0.1 non normal dis > wilcoxon
stats <- wilcox.test(value~variable, melt_data_len,exact=FALSE)

#else t test


#full_mat_number-as.numeric(full_mat_number$number)
full_mat_number_diff<-as.numeric(full_mat_number_diff$`mat[lower.tri(mat)]`)

number_<-data.frame(diff = full_mat_number_diff,same =full_mat_number$number)


shapiro.test(number_$diff)

shapiro.test(number_$same)

melt_data_num <- melt(number_) 


stats <- wilcox.test(value~variable, melt_data_num,exact=FALSE)





stats <- t.test(value~variable, melt_data_num)



  # i used this packeg of dunn test because the output of the compers look almost the same
  library(dunn.test)

  
  #statistic data about each paramter density, modularity, sdStrength, strength, betweenness
  for (i in 1:length(groupsParams)) {
    shapDist <- shapiro.test(unlist(groupsParams[[i]]))
    #22.11.21 changed p value to 0.1 mean not dist norm
    if (shapDist$p.value < 0.1) {

        stats <- wilcox.test(value~variable, melt_data,exact=FALSE)

    }else{
      stats <- t.test(value~names, data)
      
    }
    
    
}




