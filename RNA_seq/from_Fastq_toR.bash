code for RNA seq in unix

FASTQ
#example to spicific fastqc
 cd /mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data/Mali_1 
 fastqc Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_2.fq.gz
 
fastqc Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz

FASTQ_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
read1="Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}	
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}	
TrimmomaticPE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
done



FASTQ
  cd FASTQ_Generation_2021-06-09_00_56_28Z-425879454 
 fastqc N831_L001-ds.ad41ba4446b24ff0823c9da24345d56f/1_S1_L001_R2_001.fastq.gz
#creat script that loop thorgh the folder
 #!/usr/bin/env bash
 #change to9 the dir that have the files
find -name '*.gz' | xargs fastqc

FASTQC

MULTIQC
we need first to install python 
sudo apt install python3-pip
pip3 --version
and than install 
pip install multiqc

#another mission is to upodate the version of fastqc to run noveseq
###
i need to run fastqc first on eveything
cd ~
 source .bashrc
 conda activate py3.7
multiqc "/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data" -o "/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data"


#STAR
/mnt/c/Users/lital/STAR-2.7.9a/bin/Linux_x86_64/STAR

OUT_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/STAR";
Genom_ref="/mnt/d/RNA_seq/dm6_databases/dm6.fa";
GTF_ref="/mnt/d/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf";
READ_len=147;
STAR_prog="/mnt/c/Users/lital/STAR-2.7.9a/bin/Linux_x86_64/STAR"
$STAR_prog --runThreadN 4 --runMode genomeGenerate --genomeDir $OUT_DIR --genomeFastaFiles $Genom_ref --sjdbGTFfile $GTF_ref --sjdbOverhang $READ_len


STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $OUT_DIR --genomeFastaFiles $Genom_ref --sjdbGTFfile $GTF_ref --sjdbOverhang $READ_len
nohup STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $OUT_DIR --genomeFastaFiles $Genom_ref --sjdbGTFfile $GTF_ref --sjdbOverhang $READ_len
 &



OUT_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/STAR";
STAR_prog="/mnt/c/Users/lital/STAR-2.7.9a/bin/Linux_x86_64/STAR"

for i in 1 2 3 4 5 6; 
do read1=$(find /mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz"); 
read2=$(find /mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz");
$STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1,$read2


done


OUT_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/STAR";
STAR_prog="/mnt/c/Users/lital/STAR-2.7.9a/bin/Linux_x86_64/STAR"

for i in 1 2 3 4 5 6; 
do read1=$(find /mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz"|paste -d,  -s); 
read2=$(find /mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz");
echo $read1


done




#Trimmomatic

TrimmomaticPE
TrimmomaticPE -phred33 Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_2.fq.gz  out_1.fastq out_1.unpaired.fastq out_2.fastq out_2.unpaired.fastq ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100

TrimmomaticPE -phred33 Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_2.fq.gz  out_1.fastq out_1.unpaired.fastq out_2.fastq out_2.unpaired.fastq ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100


#test run for trimmomatic

FASTQ_DIR="/mnt/d/RNA_seq/new_data/X201SC21111697-Z01-F001/raw_data";
for f in $(ls -d Mali_*| sort -u)
do
way=${f}
read1=$(find $way -type f -name "*L4_1*.fq.gz");
read2=$(find $way -type f -name "*L4_2*.fq.gz");
echo "unpaired.${read1}"
done




FASTQ_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data";
for f in $(ls -d Mali_*| sort -u)
do
way=${f}
read1=$(find $way -type f -name "*L4_1.fq.gz");
read2=${read1//_L4_1.fq.gz/_L4_2.fq.gz}
R1paired=${read1//.fq/_paired.fq}

echo "do something to and also to $R1paired"
done



#test

$ for R1 in *R1*
> do
>    R2=${R1//R1_001_small.fastq/R2_001_small.fastq}
>    echo "do something to $R1 and also to $R2"
 done

FASTQ_DIR="/mnt/d/RNA_seq/new_data/X201SC21111697-Z01-F001/raw_data";
for f in $(ls *.fastq.gz |  ls -d Mali_*| sort -u)
do
cd ${f}
echo > file1.txt
cd $FASTQ_DIR
done
SALMON

#the real script to run

FASTQ_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u)
do
way=${f}
read1=$(find $way -type f -name "*L4_1*.fq.gz");
read2=$(find $way -type f -name "*L4_2*.fq.gz");
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}	
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}	
TrimmomaticPE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
done







#to creat the salmon index with the dm6 (flys)
salmon_1.5.2 index -t dm6_cds_genes.fa.gz -i salmon_index



zcat dm6_cds_genes.fa.gz |sed 's/dm6_ncbiRefSeqCurated_//' > dm6_cds_genes.fa
ls | while read -r sample; do echo "Analyzing sample - $sample"; echo "${sample}/"$(find $sample -type f -name "*R1*.fastq.gz") ;done




#i can run it 
#i need to pay attention to the names
#runnig the salmon
 SALMON_INDEX="/mnt/d/RNA_seq/dm6_databases/salmon_index/";
 SALMON_GTF="/mnt/d/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf";
 FASTQ_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/raw_data";
 OUT_DIR="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/SALMON_1.5.2/";

 mkdir -p $OUT_DIR;
 ls $FASTQ_DIR | while read -r sample;
 do way=${FASTQ_DIR}"/"${sample};
 echo "Analyzing sample - $sample "; echo "$way"; 
 read1=$(find $way -type f -name "*L4_1_paired*.fq.gz");
 read2=$(find $way -type f -name "*L4_2_paired*.fq.gz");
 echo $read1; echo $read2; OUT_PATH=${OUT_DIR}"/"${sample}"/";
 mkdir -p $OUT_PATH; echo "Create output to $OUT_PATH";  ~/salmon-1.5.2_linux_x86_64/bin/salmon quant -i $SALMON_INDEX -l A -1 $read1 -2 $read2 -o $OUT_PATH -g  $SALMON_GTF -p 8 --validateMappings;
 echo "finished SALMON";
 echo ""; 
 done


#sample to creat barcode after i did salmon
file_dir="/mnt/d/RNA_seq/new_data/new/X201SC21111697-Z01-F001/SALMON_1.5.2"; 
out_dir=${file_dir}"/summery/";
 mkdir -p $out_dir;
 touch ${out_dir}"samples.txt"; 
 echo "Run" > ${out_dir}"samples.txt";
 find $file_dir -name "quant.sf" | while read -r file_path; do 
	filename=$(basename $file_path); 
	echo $file_path;
	new_name=$(basename $(dirname $file_path) |cut -d '-' -f1)".sf"; 
	echo $new_name;
	cp $file_path ${out_dir}${new_name}; 
	echo $new_name >> ${out_dir}"samples.txt";
 done 
 
 # after this we run the r script of roni