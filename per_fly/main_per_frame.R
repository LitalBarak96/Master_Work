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
#test = TRUE

group_name<-c()
num_of_pop<-0
colors_of_groups<<-data.frame()


groupsNames <<- c()
xlsxFile<<-c()


###########################################################

debbug_path_color<-file.choose("chooce were the file paths.xlsx exist")

#the path that have all the scripts in

#sainity check # 3 trues
print("this only need to bbe true in debug mode")

file.exists(debbug_path_color)


if(file.exists(debbug_path_color)){
  library(openxlsx)
  dirs <- as.data.frame(read.xlsx(debbug_path_color))
  num_of_pop<<-nrow(dirs)
}else{
  stop("no such file, please creat using creat_pathcsv in matlab
")
}

path_to_scripts<-"C:/dev/interactions_network/per_fly/sub_function/"

setwd(path_to_scripts)
files.sources = list.files()
sapply(files.sources, source)


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




#### the actuall run (if the user choose to run from the start)
for (i in 1:num_of_pop){
  per_frame(dir[i,1],path_to_scripts)
}





