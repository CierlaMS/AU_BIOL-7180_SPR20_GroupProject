#!/bin/sh

#FastQC is a tool used to provide an overview of basic quality control metrics for
#raw next generation sequencing data.

#This script will automate quality assessment on genomes located in path

#Path to genomes
path=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster

####################Set up the environment###################
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastqc/0.10.1

###################List Commands Here########################

#for do done loop to run fastqc on all .fastq.gz files in path directory
#If sequence files have been unzipped, remove .gz in line 15.

for file in *.fastq.gz
do
   fastqc $file;
done

exit
