#this script creat the scatter plot itself from exel files that contain all the data needed

setwd('F:/statistic_test/MalesGrouped') #where is the data folders
per_condiation <- read.csv(file = 'averages per condition.csv')
#per_condiation$value <- as.factor(per_condiation$value)
#per_condiation$Variance <- as.factor(per_condiation$Variance)

library(ggplot2)
# Basic scatter plot
ggplot(per_condiation, aes(x=value, y=file)) +
  geom_point(size=1, shape=23)+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=value-Variance,xmax=value+Variance ,y=file), width=0.25)

