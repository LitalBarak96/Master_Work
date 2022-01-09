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
library(progress)

num_of_pop<-0
colors_of_groups<<-data.frame()
with_rgb = FALSE

dot<<-0
xsize<<-0
font_size<<-0
width<<-0
height<<-0
type_format<<-0
num_of_movies =0

groupsNames <<- c()
xlsxFile<<-c()


#to debug if i want to run and see the var
if (with_rgb == TRUE){
  
  p <- arg_parser("path of the color")
  
  # Add command line arguments
  p <- add_argument(p,"path",
                    help = "path",
                    flag = FALSE)
  
  # Parse the command line arguments
  argv <- parse_args(p)
  
}

rgb_2_hex <- function(r,g,b){
  return(rgb(r, g, b, maxColorValue = 1))}



vizual<-function(){
  library("readxl")
  library(openxlsx)
  temp.df<-data.frame()
  all.df<-data.frame()
  
  if(with_rgb==TRUE){
    allColorData <- read.xlsx(argv$path)
    num_of_pop<<-nrow(allColorData)
  }else{
    allColorData <- as.data.frame(read.xlsx(debbug_path_color))
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
    params <- as.data.frame(read.xlsx(debbug_path_param))
    
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
  #when I will want to creat in certin order or only spcific features
  #path_to_order_name<-paste0(((path_to_avg_per_con[1])),"\\","order.xlsx")
  #to change for spcific just change here to path_to_order_name
  #order_name<-as.data.frame(read_excel(full_path_avg_per_con[1]))
  order_name<-as.data.frame(read.csv(full_path_avg_per_con[1]))
  
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



#EXTRACTION AND USER INPUT TO LIST OF DIRS
############################################################################################################


debbug_path_color<-"C:/Users/lital/OneDrive - Bar Ilan University/Lital/data/GroupedvsSingle/color.xlsx"
debbug_path_param<-"C:/Users/lital/OneDrive - Bar Ilan University/Lital/data/GroupedvsSingle/params.xlsx"
#the path that have all the scripts in
path_to_scripts<-"C:/Users/lital/OneDrive - Bar Ilan University/Lital/code/interactions_network/scatter_plot/scatter_source"

#sainity check # 3 trues
file.exists(debbug_path_color)
file.exists(debbug_path_param)
file.exists(path_to_scripts)


if(with_rgb==TRUE){
  #reading from the path the color values
  #check if exist
  file.exists(argv$path)
  allColorData <- read.xlsx(argv$path)
  num_of_pop<<-nrow(allColorData)
  #reading the params from the exel
  param_dir = tools::file_path_sans_ext(dirname((argv$path)))
  setwd(param_dir)
  params<-data.frame()
  params <- as.data.frame(read.xlsx("params.xlsx"))
  
}else{
  #test for myself
  library(openxlsx)
  allColorData <- as.data.frame(read.xlsx(debbug_path_color))
  num_of_pop<<-nrow(allColorData)
  params<-data.frame()
  params <- as.data.frame(read.xlsx(debbug_path_param))
}

dot<<-params$dot
xsize<<-params$xsize
font_size<<-params$font
width<<-params$width
height<<-params$height
vizual_or_run<<-params$change
type_format<<-params$format


#choose the expData file for the network values
xlsxFile <<- choose.files(default = "", caption = "Select expData file")

#to read the group names in the wanted order
groupsNames <<- as.character(basename(allColorData$groupNameDir))

#creat list of dirs 
dir=as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
for (i in 1:num_of_pop){
  dir[i,1]<-allColorData$groupNameDir[i]
  dir[i,1]<-str_trim(dir[i,1], side = c("right"))
}

dir$X1<-gsub("\\\\", "/", dir$X1)
for(i in 1:num_of_pop){
  if(dir.exists(dir[i,1])){
    print("exist!!")
  }
}

#TEST NEED TO BE TRUE
nrow(dir) == num_of_pop

setwd(path_to_scripts)
files.sources = list.files()
sapply(files.sources, source)
####BAR GRAPH


number_of_operation<-(5*num_of_pop)+4
current_index<-1

pb <- winProgressBar(title = "Windows progress bar", # Window title
                     label = "Percentage completed", # Window label
                     min = 0,      # Minimum value of the bar
                     max = number_of_operation, # Maximum value of the bar
                     initial = 0,  # Initial value of the bar
                     width = 300L) # Width of the window 


#COMPUTATION
#####################################################################################

#### the actuall run (if the user choose to run from the start)
if(vizual_or_run == 1){
  #CALCULATING THE PARAMS FOR ALL THE POPULATION TOGETHER
  Listedparams<-calculating_netWorkParams_all_Groups(dir[1,1],path_to_scripts,xlsxFile,argv,debbug_path_color)
  lengthParams<- as.data.frame(Listedparams[1])
  numberParams<- as.data.frame(Listedparams[2])
  current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)

  for (i in 1:num_of_pop){
    #for each population i get the group name the number for movies and running 
    setwd(dir[i,1])
    averagesPerMovieByFile(dir[i,1],path_to_scripts)
    current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
    importClassifierFilesAndCalculatePerFrame(dir[i,1],path_to_scripts)
    current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
    boutLengthAndFrequencyForClassifiers(dir[i,1],path_to_scripts)
    current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
    netWorkParamsCalcuPerGroup(dir[i,1],i,path_to_scripts,lengthParams,numberParams,xlsxFile,num_of_pop,FALSE)
    current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
  }

##############################################
#STATS
mainStat(dir,xlsxFile,path_to_scripts,groupsNames,lengthParams,numberParams,num_of_pop)
current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
  
####
#SCALE

  #first stat than scalling
  #doing scaleing and for the other features that are not network it override the data in the csv file
  #to be the scaled data
  mainScale(dir,xlsxFile,path_to_scripts,groupsNames,lengthParams,numberParams,num_of_pop)
  current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
  

  
  for(i in 1:num_of_pop){
    #for each net there is different valus 
    setwd(dir[i,1])
    combineKineticAndClassifiersToSignature(dir[i,1],path_to_scripts)
    current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
    
  }
  
  vizual()
  current_index<- windowBar(current_index,pb,number_of_operation,path_to_scripts)
  close(pb)
  
  
  if(with_rgb==TRUE){
    # delete a file of color but not the values params 
    unlink(argv$path)
    
  }
}

if(vizual_or_run == 2){
  vizual()
}


