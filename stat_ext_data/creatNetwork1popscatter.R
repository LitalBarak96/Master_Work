library(igraph)
library(openxlsx)
library(ggplot2)
library(cowplot)
library(ggpubr)
library(ggsignif)
library(nortest)
library(fmsb)

group_name = "MalesandFemales"

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



#from here starting the "main"




#where we choosing the files we want for analysis
xlsxFile <- choose.files()
#all data is the data from the exel in the first sheet
allData <- read.xlsx(xlsxFile)

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

xlsxName <- tools::file_path_sans_ext(basename(xlsxFile))

xlsxParts <- strsplit(xlsxName, '_')

framesString <- paste(xlsxParts[[1]][2], "-", xlsxParts[[1]][4])

lengthFolder = file.path(dirname(toString(xlsxFile)), paste("Length of interactions graphs ", framesString));

dir.create(lengthFolder, showWarnings = FALSE)

numberFolder = file.path(dirname(toString(xlsxFile)), paste("Number of interactions graphs ", framesString));

dir.create(numberFolder, showWarnings = FALSE)
#parametrs name
paramsNames <- c("Density", "Modularity", "SD Strength", "Strength", "Betweenness Centrality")
#light or dark
groupsNames <- as.character(na.omit(allData$Groups.names))
lengthAvg1 <- c()
numberAvg1 <- c()

#5 time




for (i in 1:length(paramsNames)) {
  lengthAvg1 <- c(lengthAvg1, mean(unlist(lengthParams[i,1])))
  numberAvg1 <- c(numberAvg1, mean(unlist(numberParams[i,1])))
  
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

index = index_name(group_name,groupsNames)


densL <- lengthAvg1[index]

modL <- lengthAvg1[index]

sdL <- lengthAvg1[index]

strL <- lengthAvg1[index]

betL <- lengthAvg1[index]

densN <- numberAvg1[index]

modN <- numberAvg1[index]

sdN <- numberAvg1[index]

strN <-numberAvg1[index]

betN <- numberAvg1[index]


