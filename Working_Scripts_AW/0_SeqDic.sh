#!/bin/bash
#The pupose of this script is to create indexes and dictionatries of rederence genomes for GATK.
#######
##Index Sorted or Merged Bam Alignment Files
#
path_ref=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
path_asmRay=/home/aubcls71/AU_BIOL-7180_SPR20_GroupProject/SRR10740739_assembly
ref_NCBI="Sal_Ref_genome"
ref_WT="WT_2012_ref_assembly"


###############Setup Enviroment################
#source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load picard/1.79

#Below are scripts for creating dictionaries of reference genomes.
java -Xms2g -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar REFERENCE=$path_ref/$ref_NCBI.fasta OUTPUT=$path_ref/$ref_NCBI.dict
java -Xms2g -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar REFERENCE=$path_asmRay/$ref_WT.fasta OUTPUT=$path_asmRay/$ref_WT.dict

module load samtools
#Below is a script for indexing fasta files using faidx.
samtools faidx $path_ref/$ref_NCBI.fasta
samtools faidx $path_asmRay/$ref_WT.fasta

exit
