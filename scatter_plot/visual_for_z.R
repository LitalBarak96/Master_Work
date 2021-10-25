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




library(ggplot2)
library(gridExtra)




first.df$id <- name1  # or any other description you want
second.df$id <- name2

full_title = paste(name1," is red ",name2," is blue ")
df.all <- rbind(first.df, second.df)

p = ggplot(df.all, aes(x=value, y=file, group=id, color=id)) + 
  geom_point(data = first.df, col = "red")+geom_point(data = second.df, col = "blue")+
  geom_pointrange(aes(xmax=value+Variance, xmin=value-Variance), size=0.1, colour = "black") + 
  theme()+xlim(-5,5)+ggtitle(full_title)




plot(p)









