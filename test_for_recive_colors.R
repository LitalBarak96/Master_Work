library(argparser, quietly=TRUE)
# # create parser object
# parser <- ArgumentParser()
# 
# # specify our desired options 
# # by default ArgumentParser will add an help option 
# parser$add_argument("-c", "--colors", action="store_true", default=c(),
#                     help="Store list of colors")
# 
# args <- parser$parse_args()
rgb_2_hex <- function(r,g,b){rgb(r, g, b, maxColorValue = 1)}
# Create a parser
p <- arg_parser("chosing color")

# Add command line arguments
p <- add_argument(p,
                  c("R1", "G1", "B1","R2", "G2", "B2","R3", "G3", "B3"),
                  help = c("red1", "green1", "blue1","red2", "green2", "blue2","red3", "green3", "blue3"),
                  flag = c(FALSE, FALSE, FALSE,FALSE, FALSE, FALSE,FALSE, FALSE, FALSE))


# Parse the command line arguments
argv <- parse_args(p)
y<-rgb_2_hex(argv$R1,argv$G1,argv$B1)
print(y)











