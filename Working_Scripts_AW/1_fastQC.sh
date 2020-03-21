#!/bin/sh
####################Set up the environment###################
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastqc/0.10.1
####################Variables################################
#file1=SRR822934
file2=SRR822931
###################List Commands Here########################
#fastqc $file1.fastq
fastqc $file2.trim.fastq

exit
