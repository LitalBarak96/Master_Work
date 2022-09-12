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
library(dplyr)
test = FALSE

group_name<-c()
num_of_pop<-0
colors_of_groups<<-data.frame()

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




#to debug if i want to run and see the var
if (test == TRUE){
  
  p <- arg_parser("path of the color")
  
  # Add command line arguments
  p <- add_argument(p,"path",
                    help = "path",
                    flag = FALSE)
  
  # Parse the command line arguments
  argv <- parse_args(p)
  
}

###########################################################


debbug_path_color<-"D:/EX5_6/color.xlsx"
debbug_path_param<-"D:/Assa/Elia/Ex_5/Females/params.xlsx"
#the path that have all the scripts in
path_to_scripts<-choose.dir(getwd(),"choose dir where sub scripts are located")

#sainity check # 3 trues
print("this only need to bbe true in debug mode")
file.exists(debbug_path_color)
file.exists(debbug_path_param)
file.exists(path_to_scripts)

if(test==TRUE){
  #reading from the path the color values
  dirs <- read.xlsx(argv$path)
  num_of_pop<<-nrow(dirs)
  
}else{
  #test for myself
  if(file.exists(debbug_path_color)){
    library(openxlsx)
    dirs <- as.data.frame(read.xlsx(debbug_path_color))
    num_of_pop<<-nrow(dirs)
  }else{
    stop("no such file in the test and you choose test mode")
  }

}

#the path that have all the scripts in




#creat list of dirs 
dir=as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
for (i in 1:num_of_pop){
  dir[i,1]<-dirs$groupNameDir[i]
}
#xlsxFile <<- choose.files(default = "", caption = "Select expData file")

groupsNames <<- as.character(basename(dirs$groupNameDir))

#chnage the dir values so it would be readable
dir$X1<-gsub("\\\\", "/", dir$X1)
for(i in 1:num_of_pop){
  dir[i,1]<-str_trim(dir[i,1], side = c("right"))
}


#### run the functions

setwd(path_to_scripts)
files.sources = list.files()
sapply(files.sources, source)


#### the actuall run (if the user choose to run from the start)
for (i in 1:num_of_pop){
  #for each population i get the group name the number for movies and running 
  setwd(dir[i,1])
  avg_per_fly(dir[i,1],path_to_scripts)
  importClassifierFilesAndCalculatePerFrame(dir[i,1],path_to_scripts)
  frq(dir[i,1],path_to_scripts)
}


#for (i in 1:num_of_pop){
#group_name <<- tools::file_path_sans_ext(basename((dir[i,1])))
#creatNetwork2popforscatter(dir[i,1])
#}


for(i in 1:num_of_pop){
  #for each net there is different valus 
  setwd(dir[i,1])
  combind_all(dir[i,1],path_to_scripts)
}


