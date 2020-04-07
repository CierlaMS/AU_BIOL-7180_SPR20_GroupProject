#!/bin/bash
#This script is used to index sorted or merged bam files using samtools index.
#######
##Index Sorted or Merged Bam Alignment Files
#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
declare -a merged_bams=("Sal_Ref_genome.sorted.merged.bam.gz" "WT_Ref_genome.sorted.merged.bam.gz")

###############Setup Enviroment################
module load samtools

gunzip $path/*.gz

for merged in ${merged_bams[@]}; do
    samtools index $merged
done

gzip $path/*.bam
