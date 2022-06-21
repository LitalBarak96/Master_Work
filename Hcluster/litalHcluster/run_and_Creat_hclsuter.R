

run_and_Creat_hclsuter<-function(full_path_to_dirs,path_to_scripts){
  
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
  library(dplyr)

  
  current_dir =getwd()
  setwd(path_to_scripts)
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)

#the color and the name of the groups(even if we don't use the color)
allDirsData <- read.xlsx(full_path_to_dirs)
#to get the number of population in the comperence
num_of_pop<<-nrow(allDirsData)
#the parent dir
param_dir = tools::file_path_sans_ext(dirname((full_path_to_dirs)))





#get data frame that conatin dynamicly the path to all the sub population

dir=as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
for (i in 1:num_of_pop){
  dir[i,1]<-allDirsData$groupNameDir[i]
  dir[i,1]<-str_trim(dir[i,1], side = c("right"))
}


#find if the dirs exist "sinaty check"
dir$X1<-gsub("\\\\", "/", dir$X1)
for(i in 1:num_of_pop){
  if(dir.exists(dir[i,1])){
    print("exist!!")
  }
}

#get the subgroup names
groupsNames <- as.character(basename(allDirsData$groupNameDir))


setwd(param_dir)
## need to save the file in the perent folder
#sometimes there is dup of features with ~,this remove it
file_check_not_doubled<-as.data.frame(read.xlsx("files_for_dup.xlsx"))
all_together<-data.frame()
num_of_removed_valus<-0
for(i in 1:num_of_pop){
  full_path_avg_per_con<-paste0(dir[i,1],"\\","averages per condition.csv")
  #read the csv
  df<-as.data.frame(read.csv(full_path_avg_per_con))
  #remove the dubled ,there is ~ somehow in there
  show_remove<-anti_join(file_check_not_doubled,df , by = "file")
  if(i!=1 & num_of_removed_valus!=nrow(show_remove)){
    
    error_message<-paste(groupsNames[i],"population there are not the same number of featrues",nrow(show_remove))
    stop(error_message)
  
  }else{
    num_of_removed_valus<-nrow(show_remove)
    df<-semi_join(df, file_check_not_doubled, by = "file")
  }

  
  #styling the names 
  df$file<- str_replace(df$file, "scores_", "")
  df$file<-gsub("Aggregation", "Social Clustering", df$file)
  df$file<-gsub("Interaction_Assa", "Approach", df$file)
  df$file<- str_replace(df$file, ".mat", "")
  
  colnamedf<-data.frame()
  colnamedf<-as.data.frame(t(df$value))
  colnames(colnamedf)<-t(df$file)
  rownames(colnamedf)<-c(basename(dir[i,1]))
  all_together<-rbind(all_together,colnamedf)
}

# i did tanformation so i could show the groups and not the features statistic
all_together_transformed <- as.data.frame(t(all_together))


##all together is ready and now we creating the heatmap itself

#install.packages("pvclust")

library(pvclust)

library("pheatmap")

library(seriation)
library(dendextend)
library(svDialogs)
phtmap <- pheatmap(all_together)
row_dend <- phtmap[[1]]
#sorting by rows and alphbeticly




#result <- pvclust(all_together, method.dist="euclidian", method.hclust="average", nboot=1000, parallel=TRUE)
result <- pvclust(all_together_transformed, method.dist="euclidian", method.hclust="average", nboot=1000, parallel=TRUE)

plot(result)
pvrect(result, alpha=0.95)

change <- dlg_list(c("yes","no"), multiple = TRUE,title="change heatmap name order?",Sys.info()
)$res

if(change == "yes"){
  res<-c()
  for(i in 1:num_of_pop){
    res[i] <- dlg_list(groupsNames, multiple = TRUE,title="order for the heatmap")$res
  }
  row_dend<-rotate(row_dend,res)
  t<-pheatmap(all_together, cluster_rows =as.hclust(row_dend))
  setwd((choose.dir(caption = "Select folder for saving the heatmap")))
  ggsave(plot = t, filename = "heatmap.jpeg", units = "cm")
  jpeg(filename = "dendrogram_p_val.jpeg", width = 1200, height = 800)
  plot(result)
  pvrect(result, alpha=0.95)
  dev.off()
  
}else{
  t <- pheatmap(all_together)
  setwd((choose.dir(caption = "Select folder for saving the heatmap")))
  ggsave(plot = t, filename = "heatmap.jpeg",units = "cm")
  jpeg(filename = "dendrogram_p_val.jpeg", width = 1200, height = 800)
  plot(result)
  pvrect(result, alpha=0.95)
  dev.off()

}

# Finding distance matrix
distance_mat <- dist(all_together, method = 'euclidean')
distance_mat




}
