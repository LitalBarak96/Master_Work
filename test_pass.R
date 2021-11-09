library(argparser, quietly=TRUE)

library(openxlsx)



p <- arg_parser("path of the color")

# Add command line arguments
p <- add_argument(p,"path",
                  help = "path",
                  flag = FALSE)



# Parse the command line arguments
argv <- parse_args(p)

allColorData <- read.xlsx(argv$path)
print(allData)