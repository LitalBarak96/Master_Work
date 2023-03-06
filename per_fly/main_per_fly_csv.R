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




#to debug if i want to run and see the var
# if (test == TRUE){
#   
#   p <- arg_parser("paths")
#   
#   # Add command line arguments
#   p <- add_argument(p,"path",
#                     help = "path",
#                     flag = FALSE)
#   
#   # Parse the command line arguments
#   argv <- parse_args(p)
#   
# }else{
#   
#   debbug_path_color<-"D:/hadar/20230305/paths.xlsx" 
# }

###########################################################

debbug_path_color<-file.choose("chooce were the file paths.xlsx exist")

#the path that have all the scripts in
path_to_scripts<-choose.dir(getwd(),"choose dir where sub scripts are located")

#sainity check # 3 trues
print("this only need to bbe true in debug mode")

#file.exists(debbug_path_color)
file.exists(path_to_scripts)


if(file.exists(debbug_path_color)){
       library(openxlsx)
       dirs <- as.data.frame(read.xlsx(debbug_path_color))
        num_of_pop<<-nrow(dirs)
     }else{
       stop("no such file, please creat using creat_pathcsv in matlab
")
     }
# if(test==TRUE){
  # #reading from the path the color values
  # dirs <- read.xlsx(argv$path)
  # num_of_pop<<-nrow(dirs)
  # 
# }else{
#   #test for myself
#   if(file.exists(debbug_path_color)){
#     library(openxlsx)
#     dirs <- as.data.frame(read.xlsx(debbug_path_color))
#     num_of_pop<<-nrow(dirs)
#   }else{
#     stop("no such file in the test and you choose test mode")
#   }
# 
# }

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
  avg_per_Fly_all_features(dir[i,1],path_to_scripts)
  #importClassifierFilesAndCalculatePerFrame(dir[i,1],path_to_scripts)
  #frq(dir[i,1],path_to_scripts)
}


#for (i in 1:num_of_pop){
#group_name <<- tools::file_path_sans_ext(basename((dir[i,1])))
#creatNetwork2popforscatter(dir[i,1])
#}
# 
# 
# for(i in 1:num_of_pop){
#   #for each net there is different valus 
#   setwd(dir[i,1])
#   combind_all(dir[i,1],path_to_scripts)
# }





library(dplyr)
library("reshape2")
library(stringr)
library(ggplot2)



plots_per_movie <- function(Data1,flynumber,path_to_plot){
  
  df_sub <- select(Data1, -contains("dir"))
  
  
  colnames(df_sub)<-gsub("^file.*", "file", colnames(df_sub))
  colnames(df_sub)<-gsub("^fly.*", "fly", colnames(df_sub))
  colnames(df_sub)<-gsub("^value.*", "value", colnames(df_sub))
  
  
  file<-df_sub[ , grepl( "file" , names( df_sub ) ) ]
  colnames(file)<-rep("file", length(file))
  file_for_main<-data.frame(x = unlist(file))
  
  
  
  
  fly<-df_sub[ , grepl( "fly" , names( df_sub ) ) ]
  colnames(fly)<-rep("fly", length(fly))
  fly_for_main<-data.frame(x = unlist(fly))
  
  
  
  value<-df_sub[ , grepl( "value" , names( df_sub ) ) ]
  colnames(value)<-rep("value", length(value))
  value_for_main<-data.frame(x = unlist(value))
  
  
  main<-NULL
  main<-cbind(file_for_main,fly_for_main)
  
  main<-cbind(main,value_for_main)
  colnames(main)<-c("file","fly","value")
  
  
  
  
  
  
  myColors <- c("#4699dd", "#4699dd", "#4699dd", "#4699dd", "#4699dd", "#4699dd", "#4699dd", "#4699dd", "#4699dd", "#4699dd")
  myColors[flynumber]<-"#ff3db7"
  
  main$file<-str_remove(main$file, ".mat")
  name_for_pic<-str_remove(Data1$dir[[1]],"./")
  
  tiff(file=paste(path_to_plot,"/",name_for_pic,".tiff",sep = ""),units="in", width=18, height=15, res=400, compression = 'lzw')
  p<-ggplot(data = main, aes(x = fly, y = value, col =  factor(fly))) + 
    geom_bar(stat = 'identity', position = 'dodge')+theme(axis.text=element_text(size=6,face="bold"),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
                                                          axis.title = element_text( size =4, face = "bold" ))+ggtitle(Data1$dir[[1]])+facet_wrap(~file,ncol= 7,scales = "free")+scale_color_manual(values=myColors)
  plot(p)
  dev.off()
  
}


for(main_dir in 1:num_of_pop){
  
  pathCsv<-paste(dir[main_dir,1],"/","averages per fly per movie.csv",sep = "")
  per_fly_data<-read.csv(pathCsv)
  
  sub_dir<-list.dirs(dir[main_dir,1],recursive = F)
  
  
  
  
  get_fly_from_user <- function(sub_dir_tmp){
    x <- list()
    for (i in 1:length(sub_dir_tmp)){
      z <- readline(paste("number of fly for movie ",sub_dir_tmp[i], ": ", sep=''))
      x[i] <- z
    }
    return(x)
  }
  
  list_of_flys<-get_fly_from_user(sub_dir)
  
  for(j in 1:length(sub_dir)){
    
    colnames(per_fly_data)<-str_replace(colnames(per_fly_data),"dir...","dir")
    Data <- subset(per_fly_data, dir1 %in% c(paste("./",basename(sub_dir[j]),sep = "")))
    plots_per_movie(Data,list_of_flys[[j]],sub_dir[j])
    
    
  }
}











