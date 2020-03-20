#!/bin/bash
#This script is used to index sorted or merged bam files using samtools index.
#######
##Index Sorted or Merged Bam Alignment Files
#
#ref1="Necha2_core_fixed_ml"
#ref2="Fol_v2_core_ml"
merge1="Fol_v2_core_ml.Fop.merged"
merge2="Fol_v2_core_ml.Fsp.merged"
sort5="Necha2_core_fixed_ml.Neo9311.aln.sorted"
#
module load samtools

samtools index $merge1.bam
samtools index $merge2.bam
samtools index $sort5.bam


exit
