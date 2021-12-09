calculateNetworksParams <- function(net, folderPath, graphName, vertexSize,fileName) {
 
  current_dir =getwd()
  setwd("D:/scripts_for_adding_netwrok/scatter_plot/scatter_source")
  files.sources = list.files()
  sapply(files.sources, source)
  setwd(current_dir)
  
  print(fileName)
  vertexNumber = gorder(net)
  par(mfrow=c(1,1), mar=c(1,1,1,1))
  l <- layout_in_circle(net)
  density <- sum(E(net)$weight) / (vertexNumber * (vertexNumber - 1) / 2)
  wtc <- cluster_walktrap(net)
  modularity <- modularity(wtc)
  sdStrength <- sd(strength(net, weights = E(net)$weight))
  strength <- strength(net, weights = E(net)$weight)
  betweenness <- betweenness(net, v = V(net), directed = FALSE, weights = E(net)$weight)
  
  return(list(density, modularity, sdStrength, strength, betweenness))
}
