


cts <- read.csv(read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/Salmon_TPM.csv",sep=",",row.names="gene_id"))
coldata <- read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/meta_test.csv", row.names=1)
coldata$condition <- factor(coldata$condition)
rownames(coldata) <- sub("L00", "", rownames(coldata))
all(rownames(coldata) %in% colnames(cts))
all(rownames(coldata) == colnames(cts))
cts <- cts[, rownames(coldata)]
all(rownames(coldata) == colnames(cts))


library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = round(cts),
                              colData = coldata,
                              design = ~ condition)
dds


featureData <- data.frame(gene=rownames(cts))
mcols(dds) <- DataFrame(mcols(dds), featureData)
mcols(dds)



#removing low count genes
keep <- rowSums(counts(dds)) >= 2
dds <- dds[keep,]

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
