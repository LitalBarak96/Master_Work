
library(htmltools)
library("DESeq2")
library(ggplot2)
library(autoplotly)
library(factoextra)
library("pheatmap")
library("RColorBrewer")
library(gplots)
library(limma)
library("manhattanly")
library("ggrepel")
library(plotly)
library("heatmaply")


library(dplyr)
cts <- (read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/Salmon_TPM.csv",sep=",",row.names="gene_id"))
coldata <- read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/meta_test.csv", row.names=1)
coldata_not_factorial <- read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/meta_test.csv")


data<-data.frame(row.names=rownames(cts))

num_of_exp =8
for (i in 1:num_of_exp){
  temp.df<-data.frame()
  temp.df<-cts %>%
    select(starts_with(coldata_not_factorial[i,1]))
  
  
  data[coldata_not_factorial[i,1]]<- rowMeans(temp.df)
}

coldata$condition <- factor(coldata$condition)




#rownames(coldata) <- sub("L00", "", rownames(coldata))
all(rownames(coldata) %in% colnames(data))
all(rownames(coldata) == colnames(data))
data <- data[, rownames(coldata)]
all(rownames(coldata) == colnames(data))


library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = round(data),
                              colData = coldata,
                              design = ~ condition)
dds


featureData <- data.frame(gene=rownames(data))
mcols(dds) <- DataFrame(mcols(dds), featureData)
mcols(dds)



#removing low count genes


#check this is put the condition right
#dds$condition <- factor(dds$condition, levels = c("males","females"))

dds <- DESeq(dds)
resultsNames(dds)
res <- results(dds)

keep <- rowSums(counts(dds)) > 0
dds <- dds[keep,]

vsdata <-vst(dds,blind=FALSE)
library(autoplotly)
library(ggplot2)
autoplotly::autoplotly((plotPCA(vsdata, intgroup="condition")+geom_text(aes(label=name),vjust=2)+labs(title = "PCA: male vs. female"))
                       , data = vsdata, colour = 'Species', frame = TRUE)

#create loadings arrows
num<-ncol(data)
pca<-prcomp(data[1:num], scale. = TRUE)  
fviz_pca_ind(pca)

fviz_pca_var(pca, col.var="contrib", gradient.cols=c("#00AFBB", "#E7B800", "#FC4E07"), repel=TRUE,ggrepel.max.overlaps = Inf)

#results check
#how many genes are there:
length(res$pvalue)
#how many of them are smaller than 0.05?
sum(res$pvalue <= 0.05, na.rm=TRUE)

#making volcano plots. blue if pval<0.05, red if log2FC>=1 and pval<0.05)
with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main="Volcano plot", sub="obp69", xlim=c(-3,3), col.sub="orchid4"))
with(subset(res, pvalue<.05 ), points(log2FoldChange, -log10(pvalue), pch=20, col="blue"))
with(subset(res, pvalue<.05 & abs(log2FoldChange)>=1), points(log2FoldChange, -log10(pvalue), pch=20, col="red"))

#creating a csv file with all the values with pval<.05 & log2FoldChange>=1 from T VS NT for up regulated genes
x<-subset(res, pvalue<.05 & log2FoldChange>=1)
x<-row.names(as.data.frame(x))
write.csv(x, "D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/upregulated.csv",
          row.names = FALSE)

#creating a csv file with all the values with pval<.05 & log2FoldChange>=1 from T VS NT for down regulated genes
x<-subset(res, pvalue<.05 & log2FoldChange<=-1)
x<-row.names(as.data.frame(x))
write.csv(x, "D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/downregulated.csv",
          row.names = FALSE)



#create dataframes & heatmaps of significant results 
#finding the index of the significant genes in cts
y<-subset(res, pvalue<.05 & abs(log2FoldChange)>=1)
idx<-which(rownames(vsdata[,1]) %in% row.names(y))
#finding the genes
significant<-data[idx,]
#organize the data frame
#row.names(significant)<-significant[,1] 
#significant<-significant[,2:ncol(significant)]
#colnames(significant)<-paste(coldata$mouse, coldata$treat, sep = ", ")
#create a matrix of the genes expression and their names
mat<-as.matrix(significant)

#create heatmap of most changed genes

df <- as.data.frame(colData(dds)[,"condition"])
colnames(df)<-"condition"
row.names(df)<-colnames(mat)


library(htmltools)
library("DESeq2")
library(ggplot2)
library(autoplotly)
library(factoextra)
library("pheatmap")
library("RColorBrewer")
library(gplots)
library(limma)
library("manhattanly")
library("ggrepel")
library(plotly)
library("heatmaply")
df_num_scale = scale(mat)

pheatmap(df_num_scale, annotation_col =df,fontsize_row=1)
heatmaply(mat, scale = "column", plot_method ="plotly")


