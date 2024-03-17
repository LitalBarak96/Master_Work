#to debug
library(argparser, quietly=TRUE)

with_rgb = TRUE
if (with_rgb == TRUE){
  
  p <- arg_parser("path of the color")
  
  # Add command line arguments
  p <- add_argument(p,"path",
                    help = "path",
                    flag = FALSE)
  
  # Parse the command line arguments
  argv <- parse_args(p)
  
}

#change the \
print(argv$path)

my_path<-"D:/EX5_6/choosen_files_colors.csv"

allColorData <- as.data.frame(read.csv(my_path))

#give each on a color for analysis in a loop 