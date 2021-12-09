rgb_2_hex <- function(r,g,b){
  
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  return(rgb(r, g, b, maxColorValue = 1))}
