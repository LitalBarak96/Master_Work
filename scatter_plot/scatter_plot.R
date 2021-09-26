#this script creat the scatter plot itself from exel files that contain all the data needed

setwd('F:/statistic_test/MalesGrouped')
name1 = 'MalesGrouped '
first_pop.df<-as.data.frame(read.csv('averages per condition.csv'))

setwd('F:/statistic_test/MalesSingels')
name2 = "MalesSingels "
second_pop.df<-as.data.frame(read.csv('averages per condition.csv'))


#per_condiation$value <- as.factor(per_condiation$value)
colors2 <- as.factor(second_pop.df$Variance)

library(ggplot2)

g<-ggplot(first_pop.df, aes(x=first_pop.df$value, y=first_pop.df$file)) +
  geom_point(size=1, shape=23)+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=first_pop.df$value-first_pop.df$Variance,xmax=first_pop.df$value+first_pop.df$Variance ,y=first_pop.df$file), width=0.25)
q<-ggplot(second_pop.df, aes(x=second_pop.df$value, y=second_pop.df$file,color ="blue" )) +
  geom_point(size=1, shape=23)+theme_grey(base_size = 9)+geom_errorbar(aes(xmin=second_pop.df$value-second_pop.df$Variance,xmax=second_pop.df$value+second_pop.df$Variance ,y=second_pop.df$file), width=0.25)

grid.arrange(
  g,
  q,
  nrow = 1,
  top = paste(name1,name2)
)