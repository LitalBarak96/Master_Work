
#install.packages("igraph")
#install.packages("network")
#install.packages("sna")
#install.packages("ggraph")
#install.packages("visNetwork")
#install.packages("threejs")
#install.packages("networkD3")
#install.packages("ndtv")

setwd("C:/Users/lital/OneDrive - Bar Ilan University/Lital/code/interactions_network/dynamic/Data files")
library('network')
net3 <- network(links, vertex.attr=nodes, matrix.type="edgelist",
                loops=T, multiple=F, ignore.eval = F)