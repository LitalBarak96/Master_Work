
library(dplyr)
cts <- (read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/Salmon_TPM.csv",sep=",",row.names="gene_id"))
coldata <- read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/meta_test.csv", row.names=1)
coldata_not_factorial <- read.csv("D:/RNA_seq/20210608GalitOphir-270838574/SALMON_1.5.2/summery/DEseq/meta_test.csv")

#rownames(coldata) <- sub("L00", "", rownames(coldata))

data<-data.frame(row.names=rownames(cts))

num_of_exp =8
for (i in 1:num_of_exp){
  temp.df<-data.frame()
  temp.df<-cts %>%
    select(starts_with(coldata_not_factorial[i,1]))
  
  
  data[coldata_not_factorial[i,1]]<- rowMeans(temp.df)
}
}

coldata$condition <- factor(coldata$condition)
