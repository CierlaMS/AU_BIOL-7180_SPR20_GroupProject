#!/bin/bash
#The purpose of this script is to mark duplicates and to generate updated flagstats on merged bam files.
#######
##Index Sorted or Merged Bam Alignment Files
#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
declare -a merged_bams=("Sal_Ref_genome.sorted.merged" "WT_Ref_genome.sorted.merged")

###############Setup Enviroment################
#source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load picard/1.79

gunzip $path/*.gz

#Below is a loop for marking duplicates in merged bam files.
for merged in ${merged_bams[@]}; do
    java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $path/$merged.bam OUTPUT= $path/$merged.dup.bam METRICS_FILE= $path/$merged.dup.metrics
done

module load samtools
#Below is a loop for flagstat on marked duplicate files.
for merged in ${merged_bams[@]}; do
    samtools flagstat $path/$merged.dup.bam > $path/$merged.dup.bam.flagstat
done

gzip $path/*.bam

exit
