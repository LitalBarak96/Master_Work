su - ophirga
ls
fastqc 
cd ..
ls
\
fastqc -help
find fastqc
cd ..
ls
locate fastqc
cd /home/stu/ophirga/
ls
cd ..
locate ophir
locate galit
cd /home/stu/ophirga/
cd /drives/D
ls /drives/D/
cd RNA_seq
la
ls
unzip X201SC21111697-Z01-F001.zip
head X201SC21111697-Z01-F001.zip 
ls
top -icdl
jobs
top 
jobs 
top 
locate multiqc
which multiqc
/home/private/software/packages/Anacoda2.Old/bin/multiqc
cd RNA_seq/
ls
gunzip X201SC21111697-Z01-F001.gz
unzip X201SC21111697-Z01-F001.gz
ls
cd X201SC21111697-Z01-F001
ls
cd raw_data/
ls
find -name '*.gz' 
find -name '*.gz' | xargs fastqc
fastqc --help
locate fastqc
fastqc = "/home/private/software/bin/fastqc"
"/home/private/software/bin/fastqc"
find -name '*.gz' | xargs "/home/private/software/bin/fastqc"
multiqc --help
locate multiqc
"/home/private/software/packages/Anacoda2.Old/bin/multiqc" "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/" -o "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/"
"/home/private/software/packages/Anacoda2.Old/bin/multiqc" "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data" -o "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data"
"/home/private/software/packages/Anacoda2.Old/bin/multiqc"
"/home/private/software/packages/Anacoda2.Old/bin/multiqc" -help
/home/private/software/packages/Anacoda2.Old/bin/multiqc
locate TrimmomaticPE
locate Trim
locate Trimmomatic
locate STAR
STAR --help
STAR
"/home/private/software/bin/STAR"
cd RNA_seq/
ls
gunzip X201SC21111697-Z01-F001.zip
gunzip --X201SC21111697-Z01-F001.zip
gzip X201SC21111697-Z01-F001.zip
gunzip --help
gunzip X201SC21111697-Z01-F001.zip.gz
 conda activate py3.7
multiqc
find multiqc
locate multiqc
/home/private/software/packages/Anacoda2.Old/bin/multiqc
/home/private/software/packages/Anacoda2.Old/bin/multiqc --help
locate conda
ls
dgg
dG
cls
ls
clear
cd ~
 source .bashrc
 conda activate py3.7
conda --help
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
ls
sh Miniconda3-latest-Linux-x86_64.sh
sudo apt-get update
ls
locate multiqc 
cd /home/private/software/packages/miniconda3/
ls
multiqc --help
cd /home/private/software/packages/miniconda3/lib/python3.7/site-packages/
ls
multiqc 
cd ..
ls
cd /home/private/software/packages/miniconda3/
activate conda
conda
ls
miniconda3 activate py3.7
conda activate py3.7
conda activate
cd /home/private/software/packages/miniconda3/lib/python3.7
ls
cd ..
ls
conda
cd /home/private/software/packages/miniconda2/lib/python2.7/site-packages/multiqc
ls
 multiqc.py
pip  multiqc.py
--help
 multiqc.pyc 
 multiqc.pyc --help
cd ~
ls
python3
conda activate py3.7
python3
locate multiqc
which anaconda
ECHO $path
echo  $path
echo  $PATH
anaconda
conda activate
which conda
ll .\..
ll
ll .\..
uptiime
uptime
free -mh
wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
sh Anaconda3-2021.11-Linux-x86_64.sh 
ls
ll
conda activate
source "/home/stu/ophirga/.bashrc"
conda activate
pip install multiqc
multiqc
 pip install multiqc
multiqc "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data" -o "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data"
conda deactivate
locate Trimmomatic
which Trimmomatic
which rimmomatic
which trimmomatic
which Trimmomatic-PE
which TrimmomaticPE
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u); do way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; don
matrix raw_data]$ for f in $(ls -d Mali_*| sort -u); do way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u); do way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100;  clear; TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar"; FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data"; cd $FASTQ_DIR; for f in $(ls -d Mali_*| sort -u); do way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:TruSeq-All_Bili_adaptors.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR ="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
for f in $(ls -d Mali_*| sort -u); do way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); echo "unpaired.${read1}"; done
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; rm $R1paired; rm $R1unpaired ; rm $R2paired ; rm $R2unpaired ; done
ls
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR ="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; rm $R1paired; rm $R1unpaired ; rm $R2paired ; rm $R2unpaired ; done
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR ="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; echo $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR ="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; echo $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired; done
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR ="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; echo $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired; done
ls Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -6 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; rm $R1paired; rm $R1unpaired ; rm $R2paired ; rm $R2unpaired ; done
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -threads -2 -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; rm $R1paired; rm $R1unpaired ; rm $R2paired ; rm $R2unpaired ; done
ls
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
java -jar $TrimmomaticPE -phred33 Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_2.fq.gz  out_1.fastq out_1.unpaired.fastq out_2.fastq out_2.unpaired.fastq ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
java -jar $TrimmomaticPE PE -phred33 Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_1.fq.gz Mali_1/Mali_1_FKDL210333053-1a_HLF7TDSX2_L4_2.fq.gz  out_1.fastq out_1.unpaired.fastq out_2.fastq out_2.unpaired.fastq ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100; done
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; rm $R1paired; rm $R1unpaired ; rm $R2paired ; rm $R2unpaired ; done
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
cd $FASTQ_DIR
nohup for f in $(ls -d Mali_*| sort -u); 
do 
way=${f};
read1=$(find $way -type f -name "*L4_1*.fq.gz");
read2=$(find $way -type f -name "*L4_2*.fq.gz");
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
ps ux
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
cd $FASTQ_DIR
for f in $(ls -d Mali_*| sort -u);  do  way=${f}; read1=$(find $way -type f -name "*L4_1*.fq.gz"); read2=$(find $way -type f -name "*L4_2*.fq.gz"); R1paired=${read1//.fq/_paired.fq}; R1unpaired=${read1//.fq/_unpaired.fq}; R2paired=${read2//.fq/_paired.fq}; R2unpaired=${read2//.fq/_unpaired.fq}; rm $R1paired; rm $R1unpaired ; rm $R2paired ; rm $R2unpaired ; done
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/run.txt" &
ps ux
which STAR
bwa
hisat
cd ~
ls
locate STAR
locate STAR |head
locate STAR-2.7.9
locate STAR-2.7
"/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
"/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR" --help
OUT_DIR="/home/stu/ophirga/STAR/";
Genom_ref="/home/stu/ophirga/RNA_seq/dm6_databases/dm6.fa";
GTF_ref="/home/stu/ophirga/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf";
READ_len=147;
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
$STAR_prog --runThreadN 4 --runMode genomeGenerate --genomeDir $OUT_DIR --genomeFastaFiles $Genom_ref --sjdbGTFfile $GTF_ref --sjdbOverhang $READ_len
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1,$read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); echo $read1,$read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); echo $read1; echo $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); echo $read1; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesCommand zcat --readFilesIn $read1,$read2 > message.txt; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn  <(gunzip -c $read1,$read2) > message.txt; done
gunzip /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1_paired.fq.gz 
ls
gunzip --help
gunzip -l --help
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn  <(gunzip -c $read1 $read2) > message.txt; done
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn  <(gunzip -l $read1 $read2) > message.txt; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); gunzip -c $read1 $read2; done
gunzip --help
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); gunzip  $read1 $read2; done
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq.gz");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); gunzip $read1 $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq");  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1,$read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"); echo $read1 $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"|paste -d, -s); echo $read1,$read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq.gz"|paste -d, -s); echo $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); echo $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); echo $read1,$read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); echo $read1 $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1 $read2; done
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1 $read2; done
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s);echo  $read1 $read2; done
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1 $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); $STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1 $read2; done
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); echo $read1 $read2; done
for i in 1 2 3 4 5 6;  do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s);  read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_2_paired.fq"|paste -d, -s); echo $read1; done
for i in 1 2 3 4 5 6;  do find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s done; for i in 1 2 3 4 5 6;  do echo ( find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s) done
for i in 1 2 3 4 5 6;  do find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s done; for i in 1 2 3 4 5 6;  do echo | find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s; done; for i in 1 2 3 4 5 6;  do find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"|paste -d, -s done; for i in 1 2 3 4 5 6;  do find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_L${i}_1_paired.fq"; done; for i in 1 2 3 4 5 6; 
 read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s)
 read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s) echo $read1
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
do read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1 $read2
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1 $read2
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
echo $read1 
echo $read2
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
echo $read1 $read2
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
echo $read1,$read2
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1,$read2
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR"
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --runThreadN 4 --genomeDir $OUT_DIR --readFilesIn $read1,$read2
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" >/dev/null 2>&1 &
ps ux
pkill -u `whoami`
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" >/dev/null 2>&1 &
ps ux
ps ux |less
ps ux
ps ux |less
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" >/dev/null 2>&1 &
ps ux
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR";
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --genomeDir $OUT_DIR -readFilesIn $read1,$read2 --runThreadN 6 --outSAMtype BAM SortedByCoordinate --outFileNamePrefix X201SC21111697
$STAR_prog --genomeDir $OUT_DIR -readFilesIn $read1,$read2 --runThreadN 6 --outSAMtype BAM SortedByCoordinate
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR";
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --genomeDir $OUT_DIR -readFilesIn $read1,$read2 --runThreadN 6 
cd "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/"

$STAR_prog --genomeDir $OUT_DIR -readFilesIn $read1,$read2 --runThreadN 6 
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR";
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
echo $read1
ps ux
echo $read2
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
read1="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
echo $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired
echo $R1paired
echo $R1unpaired
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
read1="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
 ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runSpcificTrim.txt" &
 ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runSpcificTrim.txt" &
 ps ux
jobs
ps
ps ux
gunzip "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1_paired.fq.gz"
gunzip /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1_paired.fq.gz
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
read1="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
 ps ux
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
read1="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
gunzip /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1_paired.fq.gz
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runSpcificTrim.txt" &
ps ux
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
read1="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runSpcificTrim.txt" &
ps ux
TrimmomaticPE="/home/private/software/packages/Trimmomatic-0.39/trimmomatic-0.39.jar";
FASTQ_DIR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data";
ADAPTOR="/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/TruSeq-All_Bili_adaptors.fa"
read1="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1.fq.gz";
read2="Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2.fq.gz";
R1paired=${read1//.fq/_paired.fq}
R1unpaired=${read1//.fq/_unpaired.fq}
R2paired=${read2//.fq/_paired.fq}
R2unpaired=${read2//.fq/_unpaired.fq}
java -jar $TrimmomaticPE PE -phred33 $read1 $read2 $R1paired $R1unpaired $R2paired $R2unpaired ILLUMINACLIP:$ADAPTOR:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:100
ps ux|less
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runSpcificTrim.txt" &
ps ux|less
ps ux
ps ux|less
ps ux
gunzip /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_2_paired.fq.gz
gunzip /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/Mali_3/Mali_3_FKDL210333055-1a_HLF7TDSX2_L4_1_paired.fq.gz
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runSpcificTrim.txt" &
ps ux
locate htseq
 python -m HTSeq.scripts.count --help
/home/private/software/packages/Anacoda2/bin/htseq-count --help
which featureCounts
locate featureCounts

head /home/stu/ophirga/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR";
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --genomeDir $OUT_DIR -readFilesIn $read1,$read2 --runThreadN 6 --outSAMtype BAM SortedByCoordinate --outFileNamePrefix X201SC21111697 --outReadsUnmapped Fastx[B
OUT_DIR="/home/stu/ophirga/STAR/";
STAR_prog="/home/private/software/packages/STAR-2.7.3a/bin/Linux_x86_64/STAR";
read1=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_1_paired.fq"|paste -d, -s); 
read2=$(find /home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data -type f -name "*_2_paired.fq"|paste -d, -s);
$STAR_prog --genomeDir $OUT_DIR --readFilesIn $read1,$read2 --runThreadN 6 --outSAMtype BAM SortedByCoordinate --outFileNamePrefix X201SC21111697--outReadsUnmapped Fastx
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
GTF_FILE="/home/stu/ophirga/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf"
HTSEQ="/home/private/software/packages/Anacoda2/bin/htseq-count"
$HTSEQ -f bam /home/stu/ophirga/X201SC21111697Aligned.sortedByCoord.out.bam $GTF_FILE > X201SC21111697-output_basename.counts
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
GTF_FILE="/home/stu/ophirga/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf"
HTSEQ="/home/private/software/packages/Anacoda2/bin/htseq-count"
$HTSEQ -f bam /home/stu/ophirga/X201SC21111697Aligned.sortedByCoord.out.bam $GTF_FILE > X201SC21111697-output_basename.counts
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runHtseq.txt" &
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
kill -9 20330
ps ux
]$ kill -9 20330
]$ pkill -9 20330
pkill -u `whoami`
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runHtseq.txt" &
ps ux
nohup sh "/home/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runStar.txt" &
ps ux
locate samtools
/home/private/software/bin/samtools --help
/home/private/software/bin/samtools index /home/stu/ophirga/X201SC21111697LastAligned.sortedByCoord.out.bam
me/stu/ophirga/RNA_seq/X201SC21111697-Z01-F001/raw_data/runHtseq.txt" &





GTF_FILE="/home/stu/ophirga/RNA_seq/dm6_databases/dm6.ncbiRefSeq.gtf"
HTSEQ="/home/private/software/packages/Anacoda2/bin/htseq-count"
$HTSEQ -f bam /home/stu/ophirga/X201SC21111697LastAligned.sortedByCoord.out.bam $GTF_FILE > LastX201SC21111697-output_basename.counts
