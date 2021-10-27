library(base)
library(NISTunits)
library(argparser, quietly=TRUE)

rgb_2_hex <- function(r,g,b){rgb(r, g, b, maxColorValue = 1)}

p <- arg_parser("chosing color")

# Add command line arguments
p <- add_argument(p,
                  c("R1", "G1", "B1","R2", "G2", "B2"),
                  help = c("red1", "green1", "blue1","red2", "green2", "blue2"),
                  flag = c(FALSE, FALSE, FALSE,FALSE, FALSE, FALSE))


# Parse the command line arguments
argv <- parse_args(p)


first.df<-data.frame()
second.df<-data.frame()
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




library(ggplot2)
library(gridExtra)
a<-rgb_2_hex(argv$R1,argv$G1,argv$B1)
b<-rgb_2_hex(argv$R2,argv$G2,argv$B2)


print(a)
print(b)


first.df$id <- name1  # or any other description you want
second.df$id <- name2



first.df$Variance=first.df$Variance/(sqrt(number_of_movies_in_first))
second.df$Variance=second.df$Variance/(sqrt(number_of_movies_in_second))

full_title = paste(name1,"vs",name2)
df.all <- rbind(first.df, second.df)

t <- ggplot(df.all, aes(x=value, y=file, group=id, color=id)) + 
  geom_point(data = first.df, colour  = a,size =1)+geom_point(data = second.df, colour  = b,size =1)+scale_color_identity()+
  geom_pointrange(data=df.all,mapping=aes(xmax=value+Variance, xmin=value-Variance), size=0.08)+scale_colour_manual(values=c(a, b))+
  xlim(-3,3)+ggtitle(full_title)+theme_minimal()


#scale_fill_manual(values=c(rgb_2_hex(argv$R1,argv$G1,argv$B1), rgb_2_hex(argv$R2,argv$G2,argv$B2)))+
print(t)
ggsave(file="test4.pdf")








