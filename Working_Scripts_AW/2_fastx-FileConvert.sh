#!/bin/sh
#This script converts fastq red files into fasta files for downstream bioinformtics applications
##Variables##############
file1=SRR822934
file2=SRR822931

############## Setup environment############
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastx/0.0.14
############## Commands below ##############

#Convert Fastq to Fasta
fastq_to_fasta -vnz -i $file1.fastq -o $file1.fasta
fastq_to_fasta -vnz -i $file2.fastq -o $file2.fasta
fastq_to_fasta -vnz -i $file2.trim.fastq -o $file2.trim.fasta

#Run Quality Stats on Generated Fasta File
fastx_quality_stats -$file1.fasta
fastx_quality_stats -$file2.fasta
fastx_quality_stats -$file2.trim.fasta

#Plot Stats
#usr/local/bin/fastx_qulity_boxplot_graph.sh  
