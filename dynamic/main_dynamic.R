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

print(argv$path)