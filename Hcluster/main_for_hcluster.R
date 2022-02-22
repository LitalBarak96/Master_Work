#path_to_scripts<-"D:/MATLAB/runAll/litalHcluster"
path_to_scripts<-"C:/Users/lital/OneDrive - Bar Ilan University/Lital/code/interactions_network/Hcluster/litalHcluster"

setwd(path_to_scripts)
files.sources = list.files()
sapply(files.sources, source)

##no need for matlab,we can choose the parent dir from here and use color.xlsx,but we need to make sure it is there
parentdir<-choose.dir(default = "","select folder of the parent expreiment")

full_path_to_dirs<-paste0(parentdir,"\\","color.xlsx")
if(!file.exists(full_path_to_dirs)){
  stop("there is no color.xlsx,please check in the parent dir or run again the scatterplot and choose keep params")

}else{
  run_and_Creat_hclsuter(full_path_to_dirs,path_to_scripts)
}