library("readxl")
library(openxlsx)
temp.df<-data.frame()
all.df<-data.frame()

if(with_rgb==TRUE){
  allColorData <- read.xlsx(argv$path)
  num_of_pop<<-nrow(allColorData)
}else{
  allColorData <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/color.xlsx"))
}

colors_of_groups<<-as.data.frame(lapply(structure(.Data=1:1,.Names=1:1),function(x) numeric(num_of_pop)))
#rgb and start from 2 because the first colom is names
for (i in 1:num_of_pop){
  colors_of_groups$X1[i]<-rgb_2_hex(allColorData[i,2:4])
}
colors_of_groups$X1<-factor(colors_of_groups$X1, levels = as.character(colors_of_groups$X1))

if(with_rgb==TRUE){
  param_dir = tools::file_path_sans_ext(dirname((argv$path)))
  params<-data.frame()
  setwd(param_dir)
  params <- as.data.frame(read.xlsx("params.xlsx"))
  
}else{
  params<-data.frame()
  params <- as.data.frame(read.xlsx("D:/male_And_female_2/Males/params.xlsx"))
  
}

library(ggplot2)
library(gridExtra)
all_colors<-as.character(colors_of_groups$X1)
#full_title = paste(name1,"vs",name2)
all.df<-data.frame()
order_name<-c()
path_to_avg_per_con<-allColorData$groupNameDir
full_path_avg_per_con<-paste0(path_to_avg_per_con,"\\","averages per condition.csv")
path_to_order_name<-paste0(((path_to_avg_per_con[1])),"\\","order.xlsx")
order_name<-as.data.frame(read_excel(path_to_order_name))
library(dplyr)

for(i in 1:num_of_pop){
  groupName <- tools::file_path_sans_ext(basename(dirname(full_path_avg_per_con[i])))
  temp.df<-as.data.frame(read.csv(full_path_avg_per_con[i]))
  temp.df$file<-gsub("Aggregation", "Social Clustering", temp.df$file)
  name = groupName
  number_of_movies =length(list.dirs(path=dirname(full_path_avg_per_con[i]), full.names=T, recursive=F ))
  temp.df$id =name
  temp.df$Variance=temp.df$Variance/(sqrt(number_of_movies))
  temp.df$file<-tools::file_path_sans_ext(temp.df$file)
  temp.df$file<- str_replace(temp.df$file, "scores_", "")
  temp.df$file<-gsub("Aggregation", "Social Clustering", temp.df$file)
  temp.df<-semi_join(temp.df, order_name, by = "file")
  order_name<-semi_join(order_name, temp.df, by = "file")
  temp.df$file<-as.character(temp.df$file)
  order_name$file<-as.character(order_name$file)
  temp.df$file <- factor(temp.df$file, levels=order_name$file)
  all.df <- rbind(all.df, temp.df)
}
t <- ggplot(all.df, aes(x=value, y=file, group=id, color=id))
t<- t+geom_point(size =dot)
t<-t+ scale_color_manual(values = as.character(colors_of_groups$X1))
t<-t+ geom_pointrange(mapping=aes(xmax=value+Variance, xmin=value-Variance), size=0.08)+
  xlim(-(xsize),(xsize))+theme_minimal(base_size = font_size)

setwd((choose.dir(caption = "Select folder for saving the scatter plot")))
print(t)
ggsave(plot = t, filename = "scatterplot.pdf", height=height, width=width)
