#!/bin/bash
#This script will be used to trim poor qulaity fastq files and should be used before running alignments and is part of the quality check step.
#Trimmomatic works with FASTQ files (using phred + 33 or phred + 64 quality scores,
#depending on the Illumina pipeline used). Files compressed using either gzip or bzip2 are
#supported, and are identified by use of „.gz‟ or „.bz2�ensions. 
#####################Variables############################
file1=SRR822931
##########  load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load anaconda/3-2018.12
########## commands go here
java -jar /opt/asn/apps/anaconda_3-2018.12/share/trimmomatic/trimmomatic.jar SE -phred33 -trimlog $file1.trimlog $file1.fastq $file1.trim.fastq SLIDINGWINDOW:4:20 MINLEN:36
#
exit
