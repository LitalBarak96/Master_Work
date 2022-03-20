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

if(test==TRUE){
  #reading from the path the color values
  dirs <- read.xlsx(argv$path)
  num_of_pop<<-nrow(dirs)
  
}else{
  #test for myself
  library(openxlsx)
  dirs <- as.data.frame(read.xlsx("F:/allGroups/dirs.xlsx"))
  num_of_pop<<-nrow(dirs)
}

#the path that have all the scripts in
path_to_scripts<-"C:/Users/lital/OneDrive - Bar Ilan University/Lital/code/interactions_network/randfor/sub_function"




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
#  for (i in 1:num_of_pop){
#for each population i get the group name the number for movies and running 
#   setwd(dir[i,1])
#  avg_per_fly(dir[i,1],path_to_scripts)
# importClassifierFilesAndCalculatePerFrame(dir[i,1],path_to_scripts)
#frq(dir[i,1],path_to_scripts)
#}


#for (i in 1:num_of_pop){
#group_name <<- tools::file_path_sans_ext(basename((dir[i,1])))
#creatNetwork2popforscatter(dir[i,1])
#}


for(i in 1:num_of_pop){
  #for each net there is different valus 
  setwd(dir[i,1])
  combind_all(dir[i,1],path_to_scripts)
}


library("dplyr")
library("stringr")

all_features_final_male<-data.frame()
all_features_final_female<-data.frame()


#feature_names<-all_features %>%
 # select(-ends_with('~'))

for(i in 1:num_of_pop){
  if(str_detect(basename(dir[i,1]), "Males")){
    setwd(dir[i,1])
    all_features<-read.csv("combined_per_fly.csv")
    #getting the colom names - getting the feature name e.g aggregation 
    feature_names<-all_features %>%
      select(starts_with('file'))
    
    #taking the first row of it and removing the col names
    names_data_frame<-as.data.frame(t(feature_names[1,]))
    rownames(names_data_frame)<-(NULL)
    colnames(names_data_frame)<-c("feature_name")
    #replace the feature names so they won't end with .mat ending
    names_data_frame$feature_name<- str_replace(names_data_frame$feature_name ,".mat", "")
    #converting them to list
    names_in_list<-as.list(names_data_frame$feature_name)
    all_features_names<-all_features$dir
    all_features_names<-as.data.frame(all_features_names)
    colnames(all_features_names)<-c("id")
    #taking the movie name and calling it id
    
    #taking only the values
    all_features_valus<-all_features %>%
      select(starts_with('valu'))
    #putting the name of the feature as colom name to the values
    colnames(all_features_valus)<-c(names_in_list)
    
    
  #test<-all_features_valus[,!grepl("*~",names(all_features_valus))]
    #connecting the names of the movies to the value and feature name
    all_features_names<-cbind(all_features_names,all_features_valus[,!grepl("*~",names(all_features_valus))])
    all_features_names$id<-c("Males")
    all_features_final_male<-bind_rows(all_features_final_male,all_features_names)
    #putting factor on the label
    all_features_final_male$id<-as.factor(all_features_final_male$id)
  }
  
  
  
  if(str_detect(basename(dir[i,1]), "Females")){
    setwd(dir[i,1])
    all_features<-read.csv("combined_per_fly.csv")
    #getting the colom names - getting the feature name e.g aggregation 
    feature_names<-all_features %>%
      select(starts_with('file'))
    #taking the first row of it and removing the col names
    names_data_frame<-as.data.frame(t(feature_names[1,]))
    rownames(names_data_frame)<-(NULL)
    colnames(names_data_frame)<-c("feature_name")
    #replace the feature names so they won't end with .mat ending
    names_data_frame$feature_name<- str_replace(names_data_frame$feature_name ,".mat", "")
    #converting them to list
    names_in_list<-as.list(names_data_frame$feature_name)
    all_features_names<-all_features$dir
    all_features_names<-as.data.frame(all_features_names)
    colnames(all_features_names)<-c("id")
    #taking the movie name and calling it id
    
    #taking only the values
    all_features_valus<-all_features %>%
      select(starts_with('valu'))
    #putting the name of the feature as colom name to the values
    colnames(all_features_valus)<-c(names_in_list)
    
    #connecting the names of the movies to the value and feature name
    all_features_names<-cbind(all_features_names,all_features_valus)
    all_features_names$id<-c("Females")
    
    all_features_final_female<-bind_rows(all_features_final_female,all_features_names)
    #putting factor on the label
    all_features_final_female$id<-as.factor(all_features_final_female$id)
  }
  
}
all_feature_final<-rbind(all_features_final_female,all_features_final_male)
#this part was problematic for the random forest
colnames(all_feature_final) <- make.names(colnames(all_feature_final))


library(tidyverse)
library(dplyr) 
library(tidymodels)
library(class)
library(lazy)
library(logisticPCA)
library(ggplot2)
library(rARPACK)
library(e1071)
set.seed(123)



rf_mod<-rand_forest(trees = 1000)%>%set_engine("ranger")%>%set_mode("classification")

rf_fit<-rf_mod%>%fit(id ~ .,data = all_feature_final)

rf_fit





set.seed(345)
cell_folds <- vfold_cv(all_feature_final, v = 10)
cell_folds



tune_spec <- #here we are just defining the parameters for the decision tree
  decision_tree(
    cost_complexity = tune(),
    tree_depth = tune()
  ) %>% 
  set_engine("rpart") %>% 
  set_mode("classification")

tune_spec

tree_grid <- grid_regular(cost_complexity(),
                          tree_depth(),
                          levels = 5)

tree_grid

tree_grid %>% 
  count(tree_depth)




set.seed(345)

tree_wf <- workflow() %>% #defile the workflow
  add_model(tune_spec) %>%
  add_formula(id ~ .)

tree_res <- 
  tree_wf %>% 
  tune_grid(
    resamples = cell_folds,
    grid = tree_grid
  )

tree_res

tree_res %>% 
  collect_metrics()


tree_res %>%
  collect_metrics() %>%
  mutate(tree_depth = factor(tree_depth)) %>%
  ggplot(aes(cost_complexity, mean, color = tree_depth)) +
  geom_line(size = 1.5, alpha = 0.6) +
  geom_point(size = 2) +
  facet_wrap(~ .metric, scales = "free", nrow = 2) +
  scale_x_log10(labels = scales::label_number()) +
  scale_color_viridis_d(option = "plasma", begin = .9, end = 0)


best_tree <- tree_res %>%
  select_best("roc_auc") #Selecting the best tree

best_tree

final_wf <- 
  tree_wf %>% 
  finalize_workflow(best_tree)

final_wf


final_tree <- 
  final_wf %>%
  fit(data = all_feature_final) 

final_tree

library(vip)
final_tree %>% 
  pull_workflow_fit() %>% 
  vip()

final_tree %>% 
  extract_fit_parsnip() %>% 
  vip()