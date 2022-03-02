
##========================================================##
##                                                        ##
##   Network Visualization with R                         ##
##   Sunbelt 2021 Workshop                                 ##
##   www.kateto.net/sunbelt2021                            ##
##                                                        ##
##   Katherine (Katya) Ognyanova                          ##
##   Web: kateto.net | Email: katya@ognyanova.net         ##
##   GitHub: kateto  | Twitter: @Ognyanova                ##
##                                                        ##
##========================================================##



# ================ Introduction ================ 


# Download the workshop materials: bit.ly/sunbelt-2021
# Online tutorial: kateto.net/sunbelt2021


# CONTENTS
#
#   1. Working with colors in R plots
#   2. Reading in the network data
#   3. Network plots in 'igraph'
#   4. Plotting two-mode networks
#   5. Plotting multiplex networks
#   6. Beyond igraph: Statnet & ggraph 
#   7. Simple plot animations in R
#   8. Interactive JavaScript networks 
#   9. Interactive and dynamic networks with ndtv-d3
#  10. Plotting networks on a geographic map


# KEY PACKAGES
# Install those now if you do not have the latest versions. 
# (please do NOT load them yet!)

# install.packages("igraph") 
# install.packages("network") 
# install.packages("sna")
# install.packages("visNetwork")
# install.packages("threejs")
# install.packages("ndtv")


# OPTIONAL PACKAGES
# Install those if you  would like to run through all of the
# examples below (those are not critical and can be skipped).

# install.packages("png")
# install.packages("ggraph")
# install.packages("networkD3")
# install.packages("animation")
# install.packages("maps")
# install.packages("geosphere")




# ================ 1. Colors in R plots ================ 


#  -------~~ Colors --------


# In most R functions, you can use named colors, hex, or rgb values:
setwd("C:/Users/lital/OneDrive - Bar Ilan University/Lital/code/interactions_network/dynamic/Data files")

# Load the 'igraph' library:
library("igraph")


# -------~~ DATASET 1: edgelist  --------

# Read in the data:
nodes <- read.csv("TESTNODES.csv", header=T, as.is=T)
links <- read.csv("TESTEDGES.csv", header=T, as.is=T)

net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 
net <- simplify(net, remove.multiple = F, remove.loops = T) 

net3 <- network(links, vertex.attr=nodes, matrix.type="edgelist", 
                loops=T, multiple=F, ignore.eval = F)
net3



net3
plot(net3)

vs <- data.frame(onset=0, terminus=50, vertex.id=1:17)
es <- data.frame(onset=1:49, terminus=50, 
                 head=as.matrix(net3, matrix.type="edgelist")[,1],
                 tail=as.matrix(net3, matrix.type="edgelist")[,2])
head(vs)
head(es)

net3.dyn <- networkDynamic(base.net=net3, edge.spells=es, vertex.spells=vs)


# Plot the network (all elements present at any time point): 
plot(net3.dyn)


# Plot static images showing network evolution:


compute.animation(net3.dyn, animation.mode = "kamadakawai",
                  slice.par=list(start=0, end=49, interval=10, 
                                 aggregate.dur=10, rule='any'))

# Show time evolution through static images at different time points:
filmstrip(net3.dyn, displaylabels=F, mfrow=c(2, 3),
          slice.par=list(start=0, end=49, interval=10, 
                         aggregate.dur=10, rule='any'))

# We can pre-compute the animation coordinates (otherwise they get calculated when 
# you generate the animation). Here 'animation.mode' is the layout algorithm - 
# one of "kamadakawai", "MDSJ", "Graphviz"and "useAttribute" (user-generated).

# Here 'slice.par' is a list of parameters controlling how the network visualization 
# moves through time. The parameter 'interval' is the time step between layouts, 
# 'aggregate.dur' is the period shown in each layout, 'rule' is the rule for 
# displaying elements (e.g. 'any': active at any point during that period, 
# 'all': active during the entire period, etc.)


# Let's make an actual animation: 

compute.animation(net3.dyn, animation.mode = "kamadakawai",
                  slice.par=list(start=0, end=50, interval=1, 
                                 aggregate.dur=1, rule='any'))


render.d3movie(net3.dyn, usearrows = F, 
               displaylabels = F, label=net3 %v% "media",
               bg="#ffffff", vertex.border="#333333",
               vertex.cex = degree(net3)/2,  
               vertex.col = net3.dyn %v% "col",
               edge.lwd = (net3.dyn %e% "weight")/3, 
               edge.col = '#55555599',
               vertex.tooltip = paste("<b>Name:</b>", (net3.dyn %v% "media") , "<br>",
                                      "<b>Type:</b>", (net3.dyn %v% "type.label")),
               edge.tooltip = paste("<b>Edge type:</b>", (net3.dyn %e% "type"), "<br>", 
                                    "<b>Edge weight:</b>", (net3.dyn %e% "weight" ) ),
               launchBrowser=T, filename="Media-Network-Dynamic.html",
               render.par=list(tween.frames = 30, show.time = F),
               plot.par=list(mar=c(0,0,0,0)) )


# In addition to dynamic nodes and edges, 'ndtv' takes dynamic attributes.
# We could have added those to the 'es' and 'vs' data frames above.
# However, the plotting function can also evaluate parameters
# and generate dynamic arguments on the fly. For example,
# function(slice) { do some calculations with slice } will perform operations
# on the current time slice network, letting us change parameters dynamically.

# See the node size below:

compute.animation(net3.dyn, animation.mode = "kamadakawai",
                  slice.par=list(start=0, end=50, interval=4, 
                                 aggregate.dur=1, rule='any'))


render.d3movie(net3.dyn, usearrows = F, 
               displaylabels = F, label=net3 %v% "media",
               bg="#000000", vertex.border="#dddddd",
               vertex.cex = function(slice){ degree(slice)/2.5 },  
               vertex.col = net3.dyn %v% "col",
               edge.lwd = (net3.dyn %e% "weight")/3, 
               edge.col = '#55555599',
               vertex.tooltip = paste("<b>Name:</b>", (net3.dyn %v% "media") , "<br>",
                                      "<b>Type:</b>", (net3.dyn %v% "type.label")),
               edge.tooltip = paste("<b>Edge type:</b>", (net3.dyn %e% "type"), "<br>", 
                                    "<b>Edge weight:</b>", (net3.dyn %e% "weight" ) ),
               launchBrowser=T, filename="Media-Network-even-more-Dynamic.html",
               render.par=list(tween.frames = 25, show.time = F) )

detach("package:ndtv")
detach("package:sna")
detach("package:networkDynamic")
detach("package:network")

