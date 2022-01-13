
library(dplyr)
#i wish I have the power to do this right

Females_Grouped
Females_Mated
Females_Singles
Males_Grouped
Males_Mated
Males_Singels

anothertest<-as.data.frame(read.csv("F:/allGroups/Females_Grouped/averages per condition.csv"))

test<-as.data.frame(read.csv("F:/allGroups/Males_Singels/averages per condition.csv"))
test<-semi_join(test, anothertest, by = "file")

colnamedf<-data.frame()
colnamedf<-as.data.frame(t(test$value))
colnames(colnamedf)<-t(test$file)
rownames(colnamedf)<-c("Males_Singels")


#all_together<-data.frame()

all_together<-rbind(all_together,colnamedf)



numric_together<-as.matrix(all_together)
heatmap(numric_together, scale = "none")

library("pheatmap")
pheatmap(all_together, cutree_rows = 3)

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
