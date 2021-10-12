library(igraph)
library(openxlsx)
library(ggplot2)
library(cowplot)
library(ggpubr)
library(ggsignif)
library(nortest)
library(fmsb)
library(argparser, quietly=TRUE)
#global varible
number_of_flies = 0
with_rgb = TRUE
#from rgb to hex
rgb_2_hex <- function(r,g,b){rgb(r, g, b, maxColorValue = 1)}



#enough of it
if (with_rgb == TRUE){
  #reciving arguments from matlab as the number of populations we want to change the color *3 for the rgb
  p <- arg_parser("chosing color")
  
  # Add command line arguments
  p <- add_argument(p,
                    c("R1", "G1", "B1","R2", "G2", "B2","R3", "G3", "B3"),
                    help = c("red1", "green1", "blue1","red2", "green2", "blue2","red3", "green3", "blue3"),
                    flag = c(FALSE, FALSE, FALSE,FALSE, FALSE, FALSE,FALSE, FALSE, FALSE))
  
  
  
  # Parse the command line arguments
  argv <- parse_args(p)
  
}




#calculating density, modularity, sdStrength, strength, betweenness
calculateNetworksParams <- function(net, folderPath, graphName, vertexSize,fileName) {
  # all
  vertexNumber = gorder(net)
  par(mfrow=c(1,1), mar=c(1,1,1,1))
  l <- layout_in_circle(net)
  jpeg(file.path(folderPath, paste("network ", graphName, ".jpg", sep = "")))
  plot(net, layout = l)
  dev.off()
  
  # density
  density <- sum(E(net)$weight) / (vertexNumber * (vertexNumber - 1) / 2)
  #print(paste("density = ", density))
  x <- c(1 - density, density)
  labels <- c("","Density")
  jpeg(file.path(folderPath, paste("density ", graphName, ".jpg", sep = "")))
  pie(x, labels)
  dev.off()
  
  # modularity
  #This function tries to find densely connected subgraphs
  wtc <- cluster_walktrap(net)
  modularity <- modularity(wtc)
  #print(paste("modularity = ", modularity))
  jpeg(file.path(folderPath, paste("modularity ", graphName, ".jpg", sep = "")))
  plot(wtc, net)
  dev.off()
  
  # strength std
  sdStrength <- sd(strength(net, weights = E(net)$weight))
  #print(paste("sd strength = ", sdStrength))
  
  
  #individual
  
  # strength
  #Summing up the edge weights of the adjacent edges for each vertex.
  #this part it the part that show if the network not staurtated in 10 % 
  max_interaction <- 0.9*((number_of_flies*(number_of_flies-1))/2)
  #print(net)
  a<-E(net)
  b<-length(a)
  if (b <max_interaction){
    all.df<-data.frame(file_name = fileName)
    message("unsaturted network the number of connection is ")
    message(b)
    message("the address is ")
    message(fileName)
    write.csv(all.df, 'unsaturted_network.csv',row.names = F)
    
  }
  strength <- strength(net, weights = E(net)$weight)
  
  #print("strength: ")
  #print(strength)
  jpeg(file.path(folderPath, paste("strength ", graphName, ".jpg", sep = "")))
  plot(net, vertex.size=strength*vertexSize, layout = l)
  dev.off()
  
  # betweenness centality 
  betweenness <- betweenness(net, v = V(net), directed = FALSE, weights = E(net)$weight)
  #print("betweenness: ")
  #print(betweenness)
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
    number_of_flies<<-numCol
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

plotParamData <- function(groupsNames, groupsParams, graphFolder, graphTitle) {
  numOfFlies = length(groupsParams[[1]][[1]])
  names = c()
  numbers = c()
  colors =c()
  for (i in 1:length(groupsNames)) {
    names = c(names, rep(groupsNames[i], length(unlist(groupsParams[i]))))
    numbers = c(numbers, rnorm(ceiling(length(unlist(groupsParams[i]))/numOfFlies)))
  }
  value = rapply(groupsParams, c)
  data = data.frame(names, value)
  data$names <- as.character(data$names)
  data$names <- factor(data$names, levels=unique(data$names))
  #this part creat graph and chosing the color from the parser
  
  #testName = getStatisticTest(groupsParams[[1]], groupsParams[[2]])
  #g <- qplot(x = names, y = value, data = data, geom = c("boxplot"), fill = names, ylab = graphTitle) + geom_jitter(width = 0.2, height = 0) + geom_signif(comparisons = list(groupsNames), test = testName, map_signif_level = TRUE)
  #ggsave(filename = file.path(graphFolder, paste(graphTitle, " ", testName, ".jpg", sep = "")), g, width = 13, height = 9, units = "cm")
  g <- qplot(x = names, y = value, data = data, geom = c("boxplot"),  fill=names , ylab = graphTitle, outlier.shape = NA)+theme_grey(base_size = 8) 
  if(with_rgb == TRUE){  g <- g + scale_fill_manual(values=c(rgb_2_hex(argv$R1,argv$G1,argv$B1), rgb_2_hex(argv$R2,argv$G2,argv$B2), rgb_2_hex(argv$R3,argv$G3,argv$B3)))
  }
  else{
    g <- g + scale_fill_manual(values=c("#00FF00","#4DB3E6","#37004D"))
  }
  #
  #to see without the dots just comment this lines below
  #to plot in diffrent way the strenght ans betweenes
  if (numOfFlies > 1) {
   colors = rep(numbers, each = numOfFlies)
    g <- g + geom_jitter(width = 0.2, height = 0, aes(color = as.factor(colors[1:nrow(data)]))) + scale_colour_hue()
  } else {
    g <- g + geom_jitter(width = 0.2, height = 0)
  }

  g<-g + scale_y_log10()
  name_of_y = paste(graphTitle," In Log Scale")
  g<-g + labs(y = name_of_y) 
  g <- g + theme(legend.position="none")
  
  statsData <- getStatisticData(groupsParams, names, value, data)
  g <- addStatsToGraph(statsData, g, value, names, data)
  ggsave(filename = file.path(graphFolder, paste(graphTitle, " ", statsData[[2]], ".jpg", sep = "")), g, width = 10, height = 9, units = "cm")
}

getStatisticTest <- function(x, y) {
  dataX <- shapiro.test(unlist(x))
  if (dataX$p.value < 0.05)
    return("wilcox.test")
  dataY <- shapiro.test(unlist(y))
  if (dataY$p.value < 0.05)
    return("wilcox.test")
  return("t.test")
}

getStatisticData <- function(groupsParams, names, value, data) {
  #statistic data about each paramter density, modularity, sdStrength, strength, betweenness
  for (i in 1:length(groupsParams)) {
    shapDist <- shapiro.test(unlist(groupsParams[[i]]))
    if (shapDist$p.value < 0.05) {
      if (length(groupsParams) < 3) {
        stats <- wilcox.test(value~names, data)
        return(list(stats, "Wilcoxen"))
      } else {
        kruskal.test(value~names, data)
        stats <- pairwise.wilcox.test(data$value, data$names, p.adjust.method = 'fdr')
        return(list(stats, "Kruskal"))
      }
    }
  }
  if (length(groupsParams) < 3) {
    stats <- t.test(value~names, data)
    return(list(stats, "T Test"))
  } else {
    aov.res <- aov(value~names, data)
    summary(aov.res)
    stats <- TukeyHSD(aov.res)
    return(list(stats, "Anova"))
  }
}

addStatsToGraph <- function(statsData, g, value, names, data) {
  aov.res <- aov(value~names, data)
  templet <- TukeyHSD(aov.res)
  if (statsData[2] == "Wilcoxen" || statsData[2] == "T Test") {
    templet$names[,4] <- statsData[[1]]$p.value
  } else if (statsData[2] == "Kruskal") {
    size <- dim(statsData[[1]]$p.value)
    k = 1
    for (i in 1:size[1]) {
      for (j in i:size[2]) {
        templet$names[k,4] <- statsData[[1]]$p.value[j,i]
        row.names(templet$names)[k] <- paste(row.names(statsData[[1]]$p.value)[j], "-", colnames(statsData[[1]]$p.value)[i], sep = "")
        k = k + 1
      }
    }
  } else if (statsData[2] == "Anova") {
    templet <- statsData[[1]]
  }
  my_anova <- data.frame(cbind(templet$names, make_contrast_coord(length(levels(data$names)))))
  my_anova$astks <- pval_to_asterisks(my_anova$p.adj)
  
  tiny_anova <- my_anova[my_anova$p.adj < 0.05,]
  tiny_anova <- tiny_anova[order(tiny_anova$len, decreasing = FALSE),]
  if (max(value) <= 1) {
    lowest.y <- max(value) + 0.1
    highest.y <- lowest.y + (nrow(tiny_anova) * 0.3)
  } else {
    lowest.y <- max(value) + 0.5
    highest.y <- lowest.y + nrow(tiny_anova)
  }
  margin.y <- 0.1
  actual.ys <- seq(lowest.y, highest.y, length.out = nrow(tiny_anova))
  tiny_anova$ys <- actual.ys
  bp_ask <- g + annotate("segment", x = tiny_anova$str, y = tiny_anova$ys, xend = tiny_anova$end, yend = tiny_anova$ys, colour = "black", size = 0.65)
  bp_ask <- bp_ask + annotate("text", x = tiny_anova$ave, y = (tiny_anova$ys + (margin.y/nrow(tiny_anova))) , xend = tiny_anova$end, yend = tiny_anova$ys, label = tiny_anova$astks, size = 5)
  return(bp_ask)
}

make_contrast_coord <- function(n) {
  tmp <- do.call(rbind,lapply(1:n, (function(i){
    do.call(rbind,lapply(1:n, (function(j){
      if(j > i) {
        c(i,j)
      }
    })))
  })))
  tmp <- data.frame(tmp)
  colnames(tmp) <- c("str", "end")
  tmp$ave <- apply(tmp, 1, mean)
  tmp$len <- apply(tmp, 1, (function(vct){ max(vct) - min(vct) }))
  return(tmp)
}

pval_to_asterisks <- function(p_vals) {
  astk <- sapply(as.numeric(as.character(p_vals)), (function(pv){
    if (pv >= 0 & pv < 0.001) {
      "***"
    } else if (pv >= 0 & pv < 0.01) {
      "**"
    }  else if (pv >= 0 & pv < 0.05) {
      "*"
    } else {
      NA
    }
  }))
  return(astk)
}

createRadarPlot <- function(data, paramsNames, graphFolder, maxValues, groupName, color) {
  data <- as.data.frame(t(data))
  colnames(data) <- paramsNames
  data <- rbind(rep(0,length(paramsNames)) , data)
  data <- rbind(maxValues , data)
  jpeg(file.path(graphFolder, paste("Radar Plot ", groupName, ".jpg", sep = "")))
  radarchart( data  , axistype=1, pfcol=color)
  dev.off()
}


#from here starting the "main"




#where we choosing the files we want for analysis
xlsxFile <- choose.files()
#all data is the data from the exel in the first sheet
allData <- read.xlsx(xlsxFile)

lengthParams <- c()
numberParams <- c()
numberOfMovies<-c()
print(dirname(xlsxFile))
setwd(dirname(xlsxFile))
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
lengthAvg2 <- c()
lengthAvg3<- c()
numberAvg1 <- c()
numberAvg2 <- c()
numberAvg3<-c()
#5 time




for (i in 1:length(paramsNames)) {
  #the whole row i of lengthParams/numberParams,the param looking right now
  plotParamData(groupsNames, lengthParams[i,], lengthFolder, paramsNames[i])
  plotParamData(groupsNames, numberParams[i,], numberFolder, paramsNames[i])
  #make this part generic to the number of participents
  #doing mean on each of the couple of groupes (light and dark) for all of the params (density, modularity, sdStrength, strength, betweenness)
  lengthAvg1 <- c(lengthAvg1, mean(unlist(lengthParams[i,1])))
  lengthAvg2 <- c(lengthAvg2, mean(unlist(lengthParams[i,2])))
  lengthAvg3 <- c(lengthAvg3, mean(unlist(lengthParams[i,3])))
  numberAvg1 <- c(numberAvg1, mean(unlist(numberParams[i,1])))
  numberAvg2 <- c(numberAvg2, mean(unlist(numberParams[i,2])))
  numberAvg3 <- c(numberAvg3, mean(unlist(numberParams[i,3])))
}


lengthMaxValues <- c(0.2,0.25,0.6,1.5,5)
numberMaxValues <- c(0.4,0.2,0.85,3.5,4)




if(with_rgb == TRUE){
  createRadarPlot(lengthAvg1, paramsNames, lengthFolder, lengthMaxValues, groupsNames[1], rgb(argv$R1,argv$G1,argv$B1))
  createRadarPlot(lengthAvg2, paramsNames, lengthFolder, lengthMaxValues, groupsNames[2], rgb(argv$R2,argv$G2,argv$B2))
  createRadarPlot(lengthAvg3, paramsNames, lengthFolder, lengthMaxValues, groupsNames[3], rgb(argv$R3,argv$G3,argv$B3))
  createRadarPlot(numberAvg1, paramsNames, numberFolder, numberMaxValues, groupsNames[1], rgb(argv$R1,argv$G1,argv$B1))
  createRadarPlot(numberAvg2, paramsNames, numberFolder, numberMaxValues, groupsNames[2], rgb(argv$R2,argv$G2,argv$B2))
  createRadarPlot(numberAvg3, paramsNames, numberFolder, numberMaxValues, groupsNames[3], rgb(argv$R3,argv$G3,argv$B3))
  
  
}

#saving the varibles


densL <- cbind(lengthAvg1[1], lengthAvg2[1])
densL <- cbind(densL, lengthAvg3[1])

modL <- cbind(lengthAvg1[2], lengthAvg2[2])
modL <- cbind(modL, lengthAvg3[2])

sdL <- cbind(lengthAvg1[3], lengthAvg2[3])
sdL <- cbind(sdL, lengthAvg3[3])

strL <- cbind(lengthAvg1[4], lengthAvg2[4])
strL <- cbind(strL, lengthAvg3[4])

betL <- cbind(lengthAvg1[5], lengthAvg2[5])
betL <- cbind(betL, lengthAvg3[5])

densN <- cbind(numberAvg1[1], numberAvg2[1])
densN <- cbind(densN, numberAvg3[1])

modN <- cbind(numberAvg1[2], numberAvg2[2])
modN <- cbind(modN, numberAvg3[2])

sdN <- cbind(numberAvg1[3], numberAvg2[3])
sdN <- cbind(sdN, numberAvg3[3])

strN <- cbind(numberAvg1[4], numberAvg2[4])
strN <- cbind(strN, numberAvg3[4])

betN <- cbind(numberAvg1[5], numberAvg2[5])
betN <- cbind(betN, numberAvg3[5])


