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


avg_all_pop.df <-data.frame()
temp.df<-data.frame()

temp.df<-data.frame(first.df[, c('file','value')])

avg_all_pop.df<-data.frame(temp.df[, c('file')])
new.df<-data.frame()


for (i in 2:length(temp.df)){
  
  
  temp.df[[i-1]]<-factor(temp.df[[i-1]])
  print(levels(temp.df[[i-1]]))
  #for 3 pop add the third to it 
  avg_all_pop.df<-data.frame(file=levels(temp.df[[i-1]]),mean_all_pop=((first.df$value[i]+second.df$value[i])/number_of_pop)) # create average per condition
  new_avg.df<-rbind(new.df, avg_all_pop.df) # make list of averages per condition of all features
  new_avg_var.df<-rbind(new.df, avg_all_pop.df)
  
  
}

for (i in 1:number_of_features){
  new_avg.df[i,]$file = first.df$file[i]
  #for 3 pop add the third to it 
  new_avg.df[i,]$mean_all_pop = ((first.df$value[i]+second.df$value[i])/number_of_pop)
  
}
#avg for varience
for (i in 1:number_of_features){
  new_avg_var.df[i,]$file = first.df$file[i]
  #for 3 pop add the third to it 
  new_avg_var.df[i,]$mean_all_pop = ((first.df$Variance[i]+second.df$Variance[i])/number_of_pop)

}
#from SD to SE calculation
#created new avg for the var and normelizied it
first.df[,2:ncol(first.df)][1]<- (first.df[,2:ncol(first.df)][1] / new_avg.df[,2:ncol(new_avg.df)])
first.df[,2:ncol(first.df)][2]<- (first.df[,2:ncol(first.df)][2] / new_avg_var.df[,2:ncol(new_avg_var.df)])

second.df[,2:ncol(second.df)][1]<- second.df[,2:ncol(second.df)][1]/ new_avg.df[,2:ncol(new_avg.df)]
second.df[,2:ncol(second.df)][2]<- (second.df[,2:ncol(second.df)][2] / new_avg_var.df[,2:ncol(new_avg_var.df)])

if(number_of_pop == 3){
  third.df[,2:ncol(third.df)][1]<- third.df[,2:ncol(third.df)][1] /new_avg.df[,2:ncol(new_avg.df)]
  third.df[,2:ncol(third.df)][2]<- (third.df[,2:ncol(third.df)][2] / new_avg_var.df[,2:ncol(new_avg_var.df)])
  
}








#this script creat the scatter plot itself from exel files that contain all the data needed

#per_condiation$value <- as.factor(per_condiation$value)
colors2 <- as.factor(first.df$Variance)

library(ggplot2)
library(gridExtra)




first.df$id <- "df1"  # or any other description you want
second.df$id <- "df2"


df.all <- rbind(first.df, second.df)

p = ggplot(df.all, aes(x=value, y=file, group=id, color=id)) + 
  geom_point(data = first.df, col = "red")+geom_point(data = second.df, col = "blue")+
  geom_pointrange(aes(xmax=value+Variance, xmin=value-Variance), size=0.1, colour = "black") + 
  theme_classic()
plot(p)









#a<-ggplot(first.df, aes(x=first.df$value, y=first.df$file)) +
 # geom_point(size=3, shape=20,color="green")+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=first.df$value-first.df$Variance,xmax=first.df$value+first.df$Variance ,y=first.df$file), width=0.25)
#b<-ggplot(second.df, aes(x=second.df$value, y=second.df$file )) +
 # geom_point(size=3, shape=20,color="yellow")+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=second.df$value-second.df$Variance,xmax=second.df$value+second.df$Variance ,y=second.df$file), width=0.25)



#if(number_of_pop == 3){
 # c<-ggplot(third.df, aes(x=third.df$value, y=third.df$file )) +
  #  geom_point(size=3, shape=20,color="red")+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=third.df$value-third.df$Variance,xmax=third.df$value+third.df$Variance ,y=third.df$file), width=0.25)
#}



#if (number_of_pop ==3){grid.arrange(
 # a,
  #b,
  #c,
  #nrow = 1,
  #top = paste(name1,name2,name3)
#)
#}

#if (number_of_pop ==2){grid.arrange(
 # a,
  #b,
  #nrow = 1,
  #top = paste(name1,name2)
#)
#}





