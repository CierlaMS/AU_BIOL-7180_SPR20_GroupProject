#!/bin/sh

#copy files from /scratch directory
##must run next line before hand or remove "#" in next line to run initially
#cp /scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster/*_1.fastq.gz

#unzip all gz copied from /scratch directory
##must run next line before hand or remove "#" in next line to run initially
#gunzip ./*_1.fastq.gz

####################Set up the environment###################
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastqc/0.10.1
####################Variables################################
#file1=SRR822934
#file1=SRR10740739_1
###################List Commands Here########################
#fastqc $file1.fastq
#fastqc $file2.trim.fastq

#for do done loop to run fastqc on all .fastqc files in current directory

for file in *.fastq
do
   fastqc $file;
done

exit
