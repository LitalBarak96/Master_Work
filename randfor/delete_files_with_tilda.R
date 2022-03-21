path<-"F:/allGroups/Females_Grouped"
setwd(path)
dir<-list.dirs(recursive = F)
full_path<-paste0(dir,"/*~")
unlink(full_path)
