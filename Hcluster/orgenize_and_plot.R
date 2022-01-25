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
#i wish I have the power to do this right

##Females_Grouped
##Females_Mated
##Females_Singles
##Males_Grouped
##Males_Mated
##Males_Singels


with_rgb = FALSE
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

if(with_rgb == FALSE){
  debbugPath<-"F:/allGroups/dirs.xlsx"
  file.exists(debbugPath)
  allDirsData <- read.xlsx(debbugPath)
  num_of_pop<<-nrow(allDirsData)
  param_dir = tools::file_path_sans_ext(dirname((debbugPath)))
  
  
}else{
  file.exists(argv$path)
  allDirsData <- read.xlsx(argv$path)
  num_of_pop<<-nrow(allDirsData)
  param_dir = tools::file_path_sans_ext(dirname((argv$path)))

}






dir=as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
for (i in 1:num_of_pop){
  dir[i,1]<-allDirsData$groupNameDir[i]
  dir[i,1]<-str_trim(dir[i,1], side = c("right"))
}

dir$X1<-gsub("\\\\", "/", dir$X1)
for(i in 1:num_of_pop){
  if(dir.exists(dir[i,1])){
    print("exist!!")
  }
}

groupsNames <- as.character(basename(allDirsData$groupNameDir))


setwd(param_dir)
## need to save the file in the perent folder
file_check_not_doubled<-as.data.frame(read.xlsx("files_for_dup.xlsx"))
#anothertest<-as.data.frame(read.csv("F:/allGroups/Females_Grouped/averages per condition.csv"))
all_together<-data.frame()

for(i in 1:num_of_pop){
  full_path_avg_per_con<-paste0(dir[i,1],"\\","averages per condition.csv")
  df<-as.data.frame(read.csv(full_path_avg_per_con))
  
  df<-semi_join(df, file_check_not_doubled, by = "file")
  
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





#numric_together<-as.matrix(all_together)
#heatmap(numric_together, scale = "none")



library("pheatmap")
library(seriation)
library(dendextend)
library(svDialogs)
phtmap <- pheatmap(all_together)
row_dend <- phtmap[[1]]
#sorting by rows and alphbeticly

change <- dlg_list(c("yes","no"), multiple = TRUE,title="change heatmap name order?",Sys.info()
)$res

if(change == "yes"){
  res<-c()
  for(i in 1:num_of_pop){
    res[i] <- dlg_list(groupsNames, multiple = TRUE,title="order for the heatmap")$res
  }
  row_dend<-rotate(row_dend,res)
  t<-pheatmap(all_together, cluster_rows =as.hclust(row_dend))
  print(t)
}
#list_of_names<-c("Males_Grouped","Males_Mated","Males_Singels","Females_Mated","Females_Grouped","Females_Singles")


#row_dend <- rotate(row_dend, order = sort(rownames(all_together)[get_order(row_dend)]))
#row_dend<-rotate(row_dend,res)
#pheatmap(all_together, cluster_rows =as.hclust(row_dend))

#pheatmap(all_together,cluster_rows = FALSE,show_colnames  = T)


# Finding distance matrix
distance_mat <- dist(all_together, method = 'euclidean')
distance_mat

# Fitting Hierarchical clustering Model
# to training dataset
set.seed(240) # Setting seed
Hierar_cl <- hclust(distance_mat, method = "average")
Hierar_cl

# Plotting dendrogram
plot(Hierar_cl)

# Choosing no. of clusters
# Cutting tree by height
abline(h = 110, col = "green")

# Cutting tree by no. of clusters
fit <- cutree(Hierar_cl, k = 3 )
fit

table(fit)
rect.hclust(Hierar_cl, k = 3, border = "green")
