#!/bin/bash
#This script is used to index sorted or merged bam files using samtools index.
#######
##Index Sorted or Merged Bam Alignment Files
#
#ref1="Necha2_core_fixed_ml"
#ref2="Fol_v2_core_ml"
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files
merge1="Sal_Ref_genome.sorted.merged"
merge2="WT_Ref_genome.sorted.merged"
###############Setup Enviroment################
module load samtools


samtools index $merge1.bam
samtools index $merge2.bam


exit
