
library(dplyr)
#i wish I have the power to do this right

Females_Grouped
Females_Mated
Females_Singles
Males_Grouped
Males_Mated
Males_Singels


anothertest<-as.data.frame(read.csv("F:/allGroups/Females_Grouped/averages per condition.csv"))

test<-as.data.frame(read.csv("F:/allGroups/Females_Grouped/averages per condition.csv"))
test<-semi_join(test, anothertest, by = "file")

colnamedf<-data.frame()
colnamedf<-as.data.frame(t(test$value))
colnames(colnamedf)<-t(test$file)
rownames(colnamedf)<-c("Females_Grouped")

#all_together<-data.frame()

all_together<-rbind(all_together,colnamedf)


#numric_together<-as.matrix(all_together)
#heatmap(numric_together, scale = "none")



library("pheatmap")
library(seriation)
library(dendextend)
phtmap <- pheatmap(all_together)
row_dend <- phtmap[[1]]
#sorting by rows and alphbeticly
row_dend <- rotate(row_dend, order = sort(rownames(all_together)[get_order(row_dend)]))

pheatmap(all_together, cluster_rows =as.hclust(row_dend))

#pheatmap(all_together,cluster_rows = FALSE,show_colnames  = T)


# Finding distance matrix
distance_mat <- dist(all_together, method = 'euclidean')
distance_mat

# Fitting Hierarchical clustering Model
# to training dataset
set.seed(240) # Setting seed
Hierar_cl <- hclust(distance_mat, method = "average")
Hierar_cl

# Plotting dendrogram
plot(Hierar_cl)

# Choosing no. of clusters
# Cutting tree by height
abline(h = 110, col = "green")

# Cutting tree by no. of clusters
fit <- cutree(Hierar_cl, k = 3 )
fit

table(fit)
rect.hclust(Hierar_cl, k = 3, border = "green")
