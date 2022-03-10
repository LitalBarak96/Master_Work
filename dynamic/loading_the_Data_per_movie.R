
  #install.packages('R.matlab')
  library(R.matlab)
  current_dir ="F:/GroupedvsSingle/Grouped"
  setwd(current_dir)
  
  dir<-list.dirs(recursive = F)
  print(dir)
  
#meanwhile ii am doing iit undiirected 
  
 # for(l in 1:length(dir)){
   
  df <- (readMat(paste0(dir[1], '/','Allinteraction.mat'))) # read each MAT file
  test<-matrix(df[["new.interactionFrameMatrix"]],nrow = 10, ncol = 10)
  test1<-as.data.frame(test)

  
  f <- function(x) {
    if(is.list(x)) lapply(x, f)
    else ifelse(length(x) == 0, 0, x)
  }
  #test1[i,j] <- lapply(test1[i,j], function(x)x[lengths(x) == 0] <- 0)
  
  
  #REMOVE 0 (MEAN NO INTERACTION)
  for(i in 1:ncol(test1)){
    for(j in 1:nrow(test1)){
      if(length(unlist(test1[i,j])) == 0){
        test1[i,j] <- lapply(test1[i,j], function(x)x[lengths(x) == 0] <- 0)
      }
    }
  }
  
  test1<-na.omit(test1)
  #test1[(unlist(test1)) == 0] <- NULL
  
  

  #net <- graph_from_adjacency_matrix(test2, mode = "undirected", weighted = FALSE)
  
    #ordered_ave<- col.df[order(col.df$file),]
    #final.df<-rbind(final.df, ordered_ave)
  
  #test1[][test1[] == "NULL"] <- 0
  colnames(test1)<-c("1","2","3","4","5","6","7","8","9","10")
  rownames(test1)<-c("1","2","3","4","5","6","7","8","9","10")
  nodes<-c("1","2","3","4","5","6","7","8","9","10")
  nodes<-as.data.frame(nodes)
  #other <- do.call(unlist, test1)
  all<-data.frame()
  
  number_of_flys<-10
  for(i in 1:number_of_flys){
    for(j in 1:number_of_flys){
      if(length(unlist(test[i,j]))!=0){
        temp_num_frames<-unlist(test1[i,j])
        #tobind<-c(colnames(test1[i]),rownames(test1[j,]),test1[i,j])
        tobind<-c(colnames(test1[i]),rownames(test1[j,]))
        tobind<-as.data.frame(t(tobind))
        
        seq_inter<- temp_num_frames[diff(temp_num_frames)>120]
        if(length(seq_inter)> 0){
          num_of_seq_iter<-length(seq_inter)
          current_iindex<-1
          for(k in 1:num_of_seq_iter){
            tobind<-c(colnames(test1[i]),rownames(test1[j,]))
            tobind<-as.data.frame(t(tobind))
            
            index<-which(temp_num_frames == seq_inter[k])
            tt_temp_num_frames<-as.data.frame(temp_num_frames)
            temp_all_inter<-tt_temp_num_frames[current_iindex:index,]
            current_iindex<-index+1
            tobind<-cbind(tobind,temp_all_inter[1])
            tobind<-cbind(tobind,temp_all_inter[length(temp_all_inter)])
            colnames(tobind)<-c("tail","head","onset","terminus")
            
            all<-rbind(all,tobind)
        }
        
        }else{
          tobind<-cbind(tobind,temp_num_frames[1])
          tobind<-cbind(tobind,temp_num_frames[length(temp_num_frames)])
          colnames(tobind)<-c("tail","head","onset","terminus")
          all<-rbind(all,tobind)
          
        }
       # tobind<-tobind[rep(seq_len(nrow(tobind)), each = num_of_seq_iter), ]
        #tobind<-cbind(tobind,temp_num_frames)
        print(colnames(test1[i]))
        print("and")
        print(rownames(test1[j,]))
        print(" ")
        print(length(temp_num_frames))
        
      }
        
    }
  }
  
  colnames(all)<-c("tail","head","onset","terminus")
  
  all["head"] <- as.numeric(unlist(all["head"]))
  all["tail"] <- as.numeric(unlist(all["tail"]))
  
  #all["head"]=as.matrix(all["head"], matrix.type="edgelist")[,1]
  #tail=as.matrix(net3, matrix.type="edgelist")[,2])
 #seq_inter<- temp_num_frames[diff(temp_num_frames)>120]
 #num_of_seq_iter<-length(seq_inter)
 #current_iindex<-1
 #for(i in 1:num_of_seq_iter){
  # index<-which(temp_num_frames == seq_inter[i])
   #tt_temp_num_frames<-as.data.frame(temp_num_frames)
   #temp_all_inter<-tt_temp_num_frames[current_iindex:index,]
   #current_iindex<-index
   
 #}
  links<-all[1:2]
  
  final<-data.frame(onset=all["onset"], terminus=all["terminus"], 
                    head=as.matrix(all["head"]),
                    tail=as.matrix(all["tail"]))
  duration<-final[2]-final[1]
  colnames(duration)<-"duration"
  
  final<-cbind(final,duration)
  
  network.extract(as.list(final), at=1)
  library("igraph")
  library(network)
  net <- graph_from_data_frame(d=links, vertices=unique(nodes), directed=FALSE) 
  net <- simplify(net, remove.multiple =T, remove.loops = T)
  
  net3 <- network((links), vertex.attr=(nodes), matrix.type="edgelist", 
                  loops=TRUE, multiple=FALSE,hyper=F)
  net3
#need to remember romove the 0 
  plot(net3)
 
  
  
  vs <- data.frame(onset=0, terminus=27001, vertex.id=1:10)
  es <- data.frame(onset=all["onset"], terminus=all["terminus"], 
                   head=as.matrix(net3, matrix.type="edgelist")[,1],
                   tail=as.matrix(net3, matrix.type="edgelist")[,2])
  head(vs)
  head(es)
  library(ndtv)
  
  is.multiplex(net3) 
  net3.dyn <- networkDynamic(base.net=net3, edge.spells=es, vertex.spells=vs)
  
  
  compute.animation(net3.dyn, animation.mode = "kamadakawai",
                    slice.par=list(start=0, end=27001, interval=10, 
                                   aggregate.dur=10, rule='any'))
  
  
  plot( network.extract(net3, at=1) )
  
  g<-as.network.matrix(test1,matrix.type="adjacency")
  
  render.d3movie(net3,displaylabels=FALSE)
  
  filmstrip(net3.dyn, displaylabels=F, mfrow=c(1, 5),
            slice.par=list(start=0, end=27001, interval=10,
                           aggregate.dur=10, rule='any'))
  
  
  render.d3movie(short.stergm.sim,displaylabels=TRUE)
  
  library(ndtv)
  render.d3movie(net3.dyn, usearrows = F, 
                 displaylabelnet3s = F, label=net3 %v% "media",
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
  
  
  
  
  ###################
  
  
  