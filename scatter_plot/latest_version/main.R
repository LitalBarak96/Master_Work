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
num_of_pop<-0
colors_of_groups<<-data.frame()
with_rgb = TRUE

dot<<-0
xsize<<-0
font_size<<-0
width<<-0
height<<-0
type_format<<-0
number_of_flies= 10
num_of_movies =0

groupsNames <<- c()
xlsxFile<<-c()


#to debug
if (with_rgb == TRUE){
  
  p <- arg_parser("path of the color")
  
  # Add command line arguments
  p <- add_argument(p,"path",
                    help = "path",
                    flag = FALSE)
  
  # Parse the command line arguments
  argv <- parse_args(p)
  
}


creatNetwork2popforscatter<-function(current_path){
  setwd(current_path)
  group_name_dir = tools::file_path_sans_ext(dirname((current_path)))
  setwd(group_name_dir)
  #we need to make this file befor using this script
  #all data is the data from the exel in the first sheet
  allData <- read.xlsx(xlsxFile)
  if(with_rgb==TRUE){
    allColorData <- read.xlsx(argv$path)
    num_of_pop<-nrow(allColorData)
  }else{
    #test for myself
    library(openxlsx)
    allColorData <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/color.xlsx"))
    num_of_pop<<-nrow(allColorData)
  }
  
  lengthParams <- c()
  numberParams <- c()
  numberOfMovies<-c()
  for (i in 1:allData$Number.of.groups[1]) {
    cur <- (i + 1) * 2
    numberOfMovies[i]<- allData[i, 3]
    lengthParams <- cbind(lengthParams, calculateGroupParams(allData[1:numberOfMovies[i], cur], 0))
    numberParams <- cbind(numberParams, calculateGroupParams(allData[1:numberOfMovies[i], cur + 1], allData$Max.number.of.interaction[1]))
  }
  
  #parametrs name
  paramsNames <- c("Density", "Modularity", "SD Strength", "Strength", "Betweenness Centrality")
  #groupsNames <- as.character(basename(allColorData$groupNameDir))
  #6 is because there is 5 paramters
  length<-as.data.frame(lapply(structure(.Data=1:6,.Names=1:6),function(x) numeric(num_of_pop)))
  number<-as.data.frame(lapply(structure(.Data=1:6,.Names=1:6),function(x) numeric(num_of_pop)))
  
  for (i in 1:num_of_pop){ 
    lengthAvg<-paste0("lengthAvg",as.character(i))
    length[i,1]<-lengthAvg
  }
  for (i in 1:num_of_pop){ 
    numberAvg<-paste0("numberAvg",as.character(i))
    number[i,1]<-numberAvg
  }
  
  
  num<-apply(numberParams, 1, unlist)
  lengh<-apply(lengthParams, 1, unlist)
  for (j in 1:5){
    scaled_num<-scale(as.numeric(unlist(num[j])))
    scaled_len<-scale(as.numeric(unlist(lengh[j])))
    
    for(m in 1:num_of_pop){
      start =1
      if(m!=1) {
        start = (length(scaled_num)/num_of_pop)*(m-1)
      }
      numberParams[j,m]<-list(scaled_num[(start+1):((length(scaled_num)/num_of_pop)*m)])
    }
    
    for(m in 1:num_of_pop){
      start =1
      if(m!=1) {
        start = (length(scaled_len)/num_of_pop)*(m-1)
      }
      lengthParams[j,m]<-list(scaled_len[(start+1):((length(scaled_len)/num_of_pop)*m)])
    }
    
  }
  
  for (i in 1:length(paramsNames)) {
    for(j in 1:num_of_pop){
      length[j,i+1] <- mean(unlist(lengthParams[i,j]))
      number[j,i+1] <-mean(unlist(numberParams[i,j]))
      
    }
    
  }
  
  
  
  index_name <- function(input_name,groupsNames){
    
    for (i in 1:length(groupsNames)){
      if(input_name == groupsNames[i]){
        return (i)
      }
    }
  }
  
  my_index = index_name(group_name,groupsNames)
  varience<<-c(sd(unlist(lengthParams[1,my_index])),sd(unlist(lengthParams[2,my_index])),sd(unlist(lengthParams[3,my_index])),sd(unlist(lengthParams[4,my_index])),sd(unlist(lengthParams[5,my_index])),sd(unlist(numberParams[1,my_index])),sd(unlist(numberParams[2,my_index])),sd(unlist(numberParams[3,my_index])),sd(unlist(numberParams[4,my_index])),sd(unlist(numberParams[5,my_index])))
  
  densL1<-c()
  modL1<-c()
  sdL1<-c()
  strL1<-c()
  betL1<-c()
  densN1<-c()
  modN1<-c()
  sdN1<-c()
  strN1<-c()
  betN1<-c()
  
  densL1<-as.numeric(as.data.frame(t(length[2])))
  modL1<-as.numeric(as.data.frame(t(length[3])))
  sdL1<-as.numeric(as.data.frame(t(length[4])))
  strL1 <- as.numeric(as.data.frame(t(length[5])))
  betL1 <- as.numeric(as.data.frame(t(length[6])))
  densN1 <- as.numeric(as.data.frame(t(number[2])))
  modN1 <- as.numeric(as.data.frame(t(number[3])))
  sdN1 <- as.numeric(as.data.frame(t(number[4])))
  strN1 <- as.numeric(as.data.frame(t(number[5])))
  betN1 <- as.numeric(as.data.frame(t(number[6])))
  
  
  densL<<-densL1[my_index]
  modL<<-modL1[my_index]
  
  sdL<<-sdL1[my_index]
  
  strL<<-strL1[my_index]/sqrt(number_of_flies)
  
  
  betL<<-betL1[my_index]/sqrt(number_of_flies)
  
  
  densN<<-densN1[my_index]
  
  
  modN<<-modN1[my_index]
  
  
  sdN<<-sdN1[my_index]
  
  
  strN<<-strN1[my_index]/sqrt(number_of_flies)
  
  
  betN<<-betN1[my_index]/sqrt(number_of_flies)
  #the reason i do for each population the get their valus and write it in their dir
  setwd(current_path)
  names<-c("density(LOI)","modularity(LOI)","sd strength(LOI)","strength(LOI)","betweens(LOI)","density(NOI)","modularity(NOI)","sd strength(NOI)","strength(NOI)","betweens(NOI)")  
  values<-c(densL,modL,sdL,strL,betL,densN,modN,sdN,strN,betN)
  network.df<-data.frame(names,values,varience)
  View(network.df)
  colnames(network.df) <- c("file", "value","Variance")
  write.csv(network.df, 'network.csv', row.names = F)
  
}


vizual<-function(){
  library("readxl")
  library(openxlsx)
  temp.df<-data.frame()
  all.df<-data.frame()
  
  if(with_rgb==TRUE){
    allColorData <- read.xlsx(argv$path)
    num_of_pop<<-nrow(allColorData)
  }else{
    allColorData <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/color.xlsx"))
  }
  
  colors_of_groups<<-as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
  #rgb and start from 2 because the first colom is names
  for (i in 1:num_of_pop){
    colors_of_groups$X1[i]<-rgb_2_hex(allColorData[i,2:4])
  }
  colors_of_groups$X1<-factor(colors_of_groups$X1, levels = as.character(colors_of_groups$X1))
  
  if(with_rgb==TRUE){
    param_dir = tools::file_path_sans_ext(dirname((argv$path)))
    params<-data.frame()
    setwd(param_dir)
    params <- as.data.frame(read.xlsx("params.xlsx"))
    
  }else{
    params<-data.frame()
    params <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/params.xlsx"))
    
  }
  
  library(ggplot2)
  library(gridExtra)
  all_colors<-as.character(colors_of_groups$X1)
  #full_title = paste(name1,"vs",name2)
  all.df<-data.frame()
  order_name<-c()
  #getting the dir and fininding the avg per con itself
  path_to_avg_per_con<-allColorData$groupNameDir
  full_path_avg_per_con<-paste0(path_to_avg_per_con,"\\","averages per condition.csv")
  path_to_order_name<-paste0(((path_to_avg_per_con[1])),"\\","order.xlsx")
  order_name<-as.data.frame(read_excel(path_to_order_name))
  library(dplyr)
  
  for(i in 1:num_of_pop){
    groupName <- tools::file_path_sans_ext(basename(dirname(full_path_avg_per_con[i])))
    temp.df<-as.data.frame(read.csv(full_path_avg_per_con[i]))
    temp.df$file<-gsub("Aggregation", "Social Clustering", temp.df$file)
    name = groupName
    number_of_movies =length(list.dirs(path=dirname(full_path_avg_per_con[i]), full.names=T, recursive=F ))
    temp.df$id =name
    temp.df$Variance=temp.df$Variance/(sqrt(number_of_movies))
    temp.df$file<-tools::file_path_sans_ext(temp.df$file)
    temp.df$file<- str_replace(temp.df$file, "scores_", "")
    temp.df$file<-gsub("Aggregation", "Social Clustering", temp.df$file)
    temp.df<-semi_join(temp.df, order_name, by = "file")
    order_name<-semi_join(order_name, temp.df, by = "file")
    temp.df$file<-as.character(temp.df$file)
    order_name$file<-as.character(order_name$file)
    temp.df$file <- factor(temp.df$file, levels=order_name$file)
    all.df <- rbind(all.df, temp.df)
  }
  t <- ggplot(all.df, aes(x=value, y=file, group=id, color=id))
  t<- t+geom_point(size =dot)
  t<-t+ scale_color_manual(values = as.character(colors_of_groups$X1))
  t<-t+ geom_pointrange(mapping=aes(xmax=value+Variance, xmin=value-Variance), size=0.08)+
    xlim(-(xsize),(xsize))+theme_minimal(base_size = font_size)
  
  setwd((choose.dir(caption = "Select folder for saving the scatter plot")))
  print(t)
  if(type_format==1){
    ggsave(plot = t, filename = "scatterplot.pdf", height=height, width=width,units = "cm")
    
  }
  if(type_format==2){
    ggsave(plot = t, filename = "scatterplot.jpeg", height=height, width=width,units = "cm")

  }
  
}




###########################################################

if(with_rgb==TRUE){
  allColorData <- read.xlsx(argv$path)
  num_of_pop<<-nrow(allColorData)
  
}else{
  #test for myself
  library(openxlsx)
  allColorData <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/color.xlsx"))
  num_of_pop<<-nrow(allColorData)
}


if(with_rgb=="TRUE"){
  param_dir = tools::file_path_sans_ext(dirname((argv$path)))
  setwd(param_dir)
  params<-data.frame()
  params <- as.data.frame(read.xlsx("params.xlsx"))
}else{
  params<-data.frame()
  params <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/params.xlsx"))
}

dot<<-params$dot
xsize<<-params$xsize
font_size<<-params$font
width<<-params$width
height<<-params$height
vizual_or_run<<-params$change
type_format<<-params$format

groupsNames <<- as.character(basename(allColorData$groupNameDir))

dir=as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
for (i in 1:num_of_pop){
  dir[i,1]<-allColorData$groupNameDir[i]
}


dir$X1<-gsub("\\\\", "/", dir$X1)
for(i in 1:num_of_pop){
  dir[i,1]<-str_trim(dir[i,1], side = c("right"))
}

xlsxFile <<- choose.files(default = "", caption = "Select expData file")


setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
files.sources = list.files()
sapply(files.sources, source)

if(vizual_or_run == 1){
  for (i in 1:num_of_pop){
    setwd(dir[i,1])
    group_name <<- tools::file_path_sans_ext(basename((dir[i,1])))
    num_of_movies <<-length(list.dirs(path=dir[i,1], full.names=T, recursive=F ))
    averagesPerMovieByFile(dir[i,1])
    importClassifierFilesAndCalculatePerFrame(dir[i,1])
    boutLengthAndFrequencyForClassifiers(dir[i,1])
    
  }

  for (i in 1:num_of_pop){
    netWorkStats(dir[i,1],xlsxFile)
  }
  
  
  
  stats_main(dir,groupsNames)
  #first stat than scalling
  for_Scaleing(dir)
  
  for (i in 1:num_of_pop){
    #the group name if for saving each paramter of the network in spicific var
    group_name <<- tools::file_path_sans_ext(basename((dir[i,1])))
    creatNetwork2popforscatter(dir[i,1])
  }
  
  for(i in 1:num_of_pop){
    #for each net there is different valus 
    setwd(dir[i,1])
    num_of_movies <<-length(list.dirs(path=dir[i,1], full.names=T, recursive=F ))
    combineKineticAndClassifiersToSignature(dir[i,1])
  }
  
  vizual()
  
  
  if(with_rgb==TRUE){
    # delete a file of color but not the values params 
    unlink(argv$path)
    
  }
}

if(vizual_or_run == 2){
  vizual()
}


