
  #install.packages('R.matlab')
  library(R.matlab)
  current_dir ="F:/GroupedvsSingle/Grouped"
  setwd(current_dir)
  
  dir<-list.dirs(recursive = F)
  print(dir)
  
#meanwhile ii am doing iit undiirected 
  
  for(k in 1:length(dir)){
   
  df <- (readMat(paste0(dir[1], '/','Allinteraction.mat'))) # read each MAT file
  test<-matrix(df[["new.interactionFrameMatrix"]],nrow = 10, ncol = 10)
  test1<-as.data.frame(test)
  test2<-as.matrix(test1)
  
  

  #net <- graph_from_adjacency_matrix(test2, mode = "undirected", weighted = FALSE)
  
    #ordered_ave<- col.df[order(col.df$file),]
    #final.df<-rbind(final.df, ordered_ave)
  }
  
  #test1[][test1[] == "NULL"] <- 0
  colnames(test1)<-c("fly1","fly2","fly3","fly4","fly5","fly6","fly7","fly8","fly9","fly10")
  rownames(test1)<-c("fly1","fly2","fly3","fly4","fly5","fly6","fly7","fly8","fly9","fly10")
  nodes<-c("fly1","fly2","fly3","fly4","fly5","fly6","fly7","fly8","fly9","fly10")
  nodes<-as.data.frame(nodes)
  #other <- do.call(unlist, test1)
  all<-data.frame()
  
  number_of_flys<-10
  for(i in 1:number_of_flys){
    for(j in 1:number_of_flys){
      if(test1[i,j] !="NULL"){
        temp_num_frames<-unlist(test1[i,j])
        #tobind<-c(colnames(test1[i]),rownames(test1[j,]),test1[i,j])
        tobind<-c(colnames(test1[i]),rownames(test1[j,]))
        tobind<-as.data.frame(t(tobind))
        tobind<-tobind[rep(seq_len(nrow(tobind)), each = length(temp_num_frames)), ]
        tobind<-cbind(tobind,temp_num_frames)
        all<-rbind(all,tobind)
        
        print(colnames(test1[i]))
        print("and")
        print(rownames(test1[j,]))
        print(" ")
        print(length(temp_num_frames))
        
      }
        
    }
  }
  
  colnames(all)<-c("from","to","frames")
  
  
  temp_num_frames[diff(temp_num_frames)>120]
  
  links<-all[1:2]
  
  library("igraph")
  
  net <- graph_from_data_frame(d=links, vertices=nodes, directed=FALSE) 
  net <- simplify(net, remove.multiple = F, remove.loops = T)
  
  net3 <- network(links, vertex.attr=nodes, matrix.type="edgelist", 
                  loops=T, multiple=T, ignore.eval = F,directed=FALSE)
  net3
#need to remember romove the 0 
  plot(net3)
 
  
  
  vs <- data.frame(onset=0, terminus=27000, vertex.id=1:10)
  es <- data.frame(onset=0, terminus=27000, 
                   head=as.matrix(net3, matrix.type="edgelist")[,1],
                   tail=as.matrix(net3, matrix.type="edgelist")[,2])
  head(vs)
  head(es)
  library(networkDynamic)
  net3.dyn <- networkDynamic(base.net=net3, edge.spells=es, vertex.spells=vs)