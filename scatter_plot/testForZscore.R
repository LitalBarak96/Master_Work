library(base)
library(NISTunits)


number_of_features= 60
first.df<-data.frame()
second.df<-data.frame()
new_avg_var.df<-data.frame()
number_of_pop = 2


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


temp1.df<-data.frame(value=first.df[, c('value')])
temp2.df<-data.frame(value=second.df[, c('value')])


X <- data.matrix(temp1.df)
Y<-data.matrix(temp2.df)


df <- data.frame(group=c(rep('X', length(X)), rep('Y', length(Y))), value=c(X,Y))
# calculate z-scores and append to data frame
df$z.score <- scale(c(X,Y), center = T, scale = T)
df

library(plyr) # for ddply functiom
# calculate mean, sd and se for each group:
m <- ddply(df, ~group, summarize, mean=mean(z.score), sd=sd(z.score), se=sd(z.score)/sqrt(length(z.score)))
m



















