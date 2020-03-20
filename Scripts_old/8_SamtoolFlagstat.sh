#!/bin/bash
#This script is used to produce stats on sorted or merged bam files using samtools index.
#######
##Merged Files
#
merge1="Fol_v2_core_ml.Fop.merged"
merge2="Fol_v2_core_ml.Fsp.merged"
sort5="Necha2_core_fixed_ml.Neo9311.aln.sorted"
#
module load samtools

samtools flagstat $merge1.bam > $merge1.flagstat
samtools flagstat $merge2.bam > $merge2.flagstat
samtools flagstat $sort5.bam > $sort5.flagstat


exit
