library(base)

number_of_features= 58
first.df<-data.frame()
second.df<-data.frame()
third.df<-data.frame()
#insert here how many population you want 
number_of_population = 3



#for (i in 1:number_of_population){
  #xlsxFile <- choose.files()
 # all.df[[i]]<-as.data.frame(read.csv(xlsxFile))
#}

##later do the genraliztion

#choosing the files getting the name and the number of files for SE
xlsxFile <- choose.files()
xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
first.df<-as.data.frame(read.csv(xlsxFile))
name1 = xlsxName
group_name_in_first = tools::file_path_sans_ext(dirname((xlsxFile)))
number_of_movies_in_first =length(list.dirs(path=group_name_in_first, full.names=T, recursive=F ))


xlsxFile <- choose.files()
xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
second.df<-as.data.frame(read.csv(xlsxFile))
name2 = xlsxName
group_name_in_second = tools::file_path_sans_ext(dirname((xlsxFile)))
number_of_movies_in_second =length(list.dirs(path=group_name_in_second, full.names=T, recursive=F ))

xlsxFile <- choose.files()
xlsxName <- tools::file_path_sans_ext(basename(dirname(xlsxFile)))
third.df<-as.data.frame(read.csv(xlsxFile))
name3= xlsxName
group_name_in_third = tools::file_path_sans_ext(dirname((xlsxFile)))
number_of_movies_in_third =length(list.dirs(path=group_name_in_third, full.names=T, recursive=F ))
avg_all_pop.df <-data.frame()
temp.df<-data.frame()

temp.df<-data.frame(third.df[, c('file','value')])

avg_all_pop.df<-data.frame(temp.df[, c('file')])
new.df<-data.frame()


for (i in 2:length(temp.df)){
  
  
  temp.df[[i-1]]<-factor(temp.df[[i-1]])
  print(levels(temp.df[[i-1]]))
  avg_all_pop.df<-data.frame(file=levels(temp.df[[i-1]]),mean_all_pop=((third.df$value[i]+second.df$value[i]+first.df$value[i])/3)) # create average per condition
  new_avg.df<-rbind(new.df, avg_all_pop.df) # make list of averages per condition of all features
  
  
  
}

for (i in 1:number_of_features){
  new_avg.df[i,]$file = third.df$file[i]
  new_avg.df[i,]$mean_all_pop = (third.df$value[i]+second.df$value[i]+first.df$value[i])/3
  
}

first.df[,2:ncol(first.df)][1]<- (first.df[,2:ncol(first.df)][1] / new_avg.df[,2:ncol(new_avg.df)])+100

second.df[,2:ncol(second.df)][1]<- second.df[,2:ncol(second.df)][1]/ new_avg.df[,2:ncol(new_avg.df)]+100

third.df[,2:ncol(third.df)][1]<- third.df[,2:ncol(third.df)][1] /new_avg.df[,2:ncol(new_avg.df)] +100



#from SD to SE
first.df[,2:ncol(first.df)][2]<- first.df[,2:ncol(first.df)][2] / sqrt(number_of_movies_in_first)

second.df[,2:ncol(second.df)][2]<- second.df[,2:ncol(second.df)][2]/ sqrt(number_of_movies_in_second)

third.df[,2:ncol(third.df)][2]<- third.df[,2:ncol(third.df)][2] / sqrt(number_of_movies_in_third)



#this script creat the scatter plot itself from exel files that contain all the data needed

#per_condiation$value <- as.factor(per_condiation$value)
colors2 <- as.factor(third.df$Variance)

library(ggplot2)
library(gridExtra)


a<-ggplot(first.df, aes(x=first.df$value, y=first.df$file)) +
  geom_point(size=3, shape=20)+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=first.df$value-first.df$Variance,xmax=first.df$value+first.df$Variance ,y=first.df$file), width=0.25)
b<-ggplot(second.df, aes(x=second.df$value, y=second.df$file )) +
  geom_point(size=3, shape=20,color="blue")+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=second.df$value-second.df$Variance,xmax=second.df$value+second.df$Variance ,y=second.df$file), width=0.25)
c<-ggplot(third.df, aes(x=third.df$value, y=third.df$file )) +
  geom_point(size=3, shape=20,color="red")+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=third.df$value-third.df$Variance,xmax=third.df$value+third.df$Variance ,y=third.df$file), width=0.25)

grid.arrange(
  a,
  b,
  c,
  nrow = 1,
  top = paste(name1,name2,name3)
)





