

debbug_path_color<-"D:/RejectedvsMatedvsNaive/color.xlsx"
debbug_path_param<-"D:/RejectedvsMatedvsNaive/params.xlsx"
#the path that have all the scripts in
#path_to_scripts<-"D:/MATLAB/runAll/scatterPlot/scatter_source"

#sainity check # 3 trues
print("this only need to bbe true in debug mode")
file.exists(debbug_path_color)
file.exists(debbug_path_param)
#file.exists(path_to_scripts)


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

dot<-params$dot
xsize<-params$xsize
font_size<-params$font
width<-params$width
height<-params$height
vizual_or_run<-params$change
type_format<-params$format
toDelete<-params$deleted

#choose the expData file for the network values
xlsxFile <<- choose.files(default = "", caption = "Select expData file")

#to read the group names in the wanted order
groupsNames <<- as.character(basename(allColorData$groupNameDir))
##test to prevent error of calculating
#GET THE ORDER OF NAMES THAT WANTED WITH THE CALCULATION OF NETWORK
xlsxFileRead<-read_excel(xlsxFile)

namesOfGroupsFromxlsx<-data.frame()
namesOfGroupsFromxlsx<-as.data.frame(colnames(xlsxFileRead))

#from the 4th place until how many pop they are is 
namesOfGroupsFromxlsx<-as.data.frame(namesOfGroupsFromxlsx[4:(3+num_of_pop*2),1])

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





















scaleing<-function(csv_file_name,dir,path_to_scripts){
  csv_file_name<-"combined_per_fly.csv"
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  
  #dir<-"D:/RejectedvsMatedvsNaive/Mated/"
  temp<-data.frame()
  setwd(dirs[1,1])
  comb<-as.data.frame(read.csv(csv_file_name))
  num_of_movies<-length(list.dirs(path=dirs[1,1], recursive=F ))
  v <- rep(tools::file_path_sans_ext(basename(((dirs[1,1])))), 78)
  library("dplyr") # or library("tidyverse")
  comb <- cbind(id = v,comb)
  for(i in 2:num_of_pop){
    setwd(dirs[i,1])
    temp<-as.data.frame(read.csv(csv_file_name))
    num_of_movies<-length(list.dirs(path=dirs[i,1], recursive=F ))
    
    if(tools::file_path_sans_ext(basename(((dirs[i,1])))) == "Naive"){
      v <- rep(tools::file_path_sans_ext(basename(((dirs[i,1])))), 72)
      temp <- cbind(id = v,temp)
      comb<-bind_rows(comb,temp)
    }
    if(tools::file_path_sans_ext(basename(((dirs[i,1])))) == "Rejected"){
      v <- rep(tools::file_path_sans_ext(basename(((dirs[i,1])))), 80)
      temp <- cbind(id = v,temp)
      comb<-bind_rows(comb,temp)
    }

  }
  
  comb$id <- as.factor(comb$id)
  library(dplyr)
  
  scaled<-comb %>%
    mutate_if(str_detect(colnames(.), "values"), scale)
  
  
  splited<-split(scaled, scaled$id)
  
  
  

    for(i in 1:num_of_pop){
      setwd(dirs[i,1])
      bb<-as.data.frame(splited[i])
      bb<-select(bb, -ends_with("id"))
      write.csv(bb, "combined_per_fly_scaled.csv", row.names = F,col.names = F)
    }
    
  
}