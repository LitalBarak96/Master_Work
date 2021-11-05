library(stringr)
library("readxl")
library(dplyr)
with_rgb = FALSE
first.df<-data.frame()
second.df<-data.frame()

number_of_flies=10
if(number_of_pop ==3 ){
  third.df<-data.frame()
  
}

#choosing the files getting the name and the number of files for SE
#pop 1
xlsxFile <- choose.files()
xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
first.df<-as.data.frame(read.csv(xlsxFile))
name1 = xlsxName
group_name_in_first = tools::file_path_sans_ext(dirname((xlsxFile)))
number_of_movies_in_first =length(list.dirs(path=group_name_in_first, full.names=T, recursive=F ))



#pop 2
xlsxFile <- choose.files()
xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
second.df<-as.data.frame(read.csv(xlsxFile))
name2 = xlsxName
group_name_in_second = tools::file_path_sans_ext(dirname((xlsxFile)))
number_of_movies_in_second =length(list.dirs(path=group_name_in_second, full.names=T, recursive=F ))
if(number_of_pop == 3){
  #Pop 3
  xlsxFile <- choose.files()
  xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
  third.df<-as.data.frame(read.csv(xlsxFile))
  name3= xlsxName
  group_name_in_third = tools::file_path_sans_ext(dirname((xlsxFile)))
  number_of_movies_in_third =length(list.dirs(path=group_name_in_third, full.names=T, recursive=F ))
}




library(ggplot2)
library(gridExtra)
if (with_rgb == TRUE){
  a<-rgb_2_hex(argv$R1,argv$G1,argv$B1)
  b<-rgb_2_hex(argv$R2,argv$G2,argv$B2)
}else{
  a<-"#4DB3E6"
  b<-"#37004D"
}


first.df$id <- name1  # or any other description you want
second.df$id <- name2



first.df$Variance=first.df$Variance/(sqrt(number_of_movies_in_first*number_of_flies))
second.df$Variance=second.df$Variance/(sqrt(number_of_movies_in_second*number_of_flies))



full_title = paste(name1,"vs",name2)
first.df$file<-tools::file_path_sans_ext(first.df$file)
first.df$file<- str_replace(first.df$file, "scores_", "")

second.df$file<-tools::file_path_sans_ext(second.df$file)
second.df$file<- str_replace(second.df$file, "scores_", "")

order.df <- (read_excel(file.choose()))
#test1 <- data.frame(matrix(ncol = 4, nrow = 52))
#colnames(test1) <- c('file','value','Variance','id')
#for (i in 1:nrow(order.df)){
  #for(j in 1:nrow(first.df)){
    #if(order.df[i,]==first.df[j,]$file){
     # test1[i,]<-first.df[j,]
      
    #}
   # else{
      
  #  }
    
 # }
  
  
#}
#test1 <- na.omit(test1) 
#rownames(test1) <-1:nrow(test1)

#test<-filter(first.df, file %in% c("Stop", "Walk"))


#order.df$file<-as.character(order.df$file)
#order.df$file <- factor(order.df$file, levels=unique(order.df$file))

#first.df$file<-as.character(first.df$file)
#first.df$file <- factor(first.df$file, levels=unique(first.df$file))


test1<-filter(first.df, file %in% order.df$file)
test2<-filter(second.df, file %in% order.df$file)


#the problem filter don't keep the order
#test2 <- data.frame(matrix(ncol = 4, nrow = 52))
#colnames(test2) <- c('file','value','Variance','id')

#for (i in 1:nrow(order.df)){
 # for(j in 1:nrow(second.df)){
  #  if(order.df[i,]==second.df[j,]$file){
   #   test2[i,]<-second.df[j,]
      
    #}
    #else{
      
  #  }
    
#  }
  
  
#}

#test2<- na.omit(test2) 
#rownames(test2) <-1:nrow(test2)

df.all <- rbind(test1, test2)
test1$file<-as.character(test1$file)
test2$file<-as.character(test2$file)

test1$file <- factor(test1$file, levels=unique(test1$file))
test2$file <- factor(test2$file, levels=unique(test2$file))

df.all <- rbind(test1, test2)


t <- ggplot(df.all, aes(x=value, y=file, group=id, color=id)) + 
  geom_point(data = test1, colour  = a,size =1)+geom_point(data = test2, colour  = b,size =1)+scale_color_identity()+
  geom_pointrange(data=df.all,mapping=aes(xmax=value+Variance, xmin=value-Variance), size=0.08)+scale_colour_manual(values=c(a, b))+
  xlim(-3,3)+ggtitle(full_title)+theme_minimal()


setwd((choose.dir(default = "", caption = "Select folder for saving the scatter plot")))
print(t)
ggsave(plot = t, filename = "scatterplot.pdf", height=12, width=12)
