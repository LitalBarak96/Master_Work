mypath<-"D:/mated_naive_rejected"
lists_files<-list.files(mypath,pattern = ".mat~",recursive = TRUE,full.names =TRUE)

#FULLPATH<-paste0(mypath,lists_files)

for(i in 1:length(FULLPATH)){
  
  unlink(lists_files[i])
}