#!/bin/bash
#This script is used to produce stats on sorted or merged bam files using samtools flagstat..
#######
##Index Sorted or Merged Bam Alignment Files
#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
declare -a merged_bams=("Sal_Ref_genome.sorted.merged.bam" "WT_Ref_genome.sorted.merged.bam")

###############Setup Enviroment################
module load samtools

gunzip $path/*.gz

for merged in ${merged_bams[@]}; do
    samtools flagstat $path/$merged > $path/$merged.flagstat
done

gzip $path/*.bam

exit
