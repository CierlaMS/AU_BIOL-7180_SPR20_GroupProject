#!/bin/bash
#This script is used to merge sorted reads into a single bam file using samtools merge.
#######
##Sorted Bam Alignment Files
#
#ref1="Necha2_core_fixed_ml"
ref2="Fol_v2_core_ml"
sort1="Fol_v2_core_ml.Fop9311.aln.sorted"
sort2="Fol_v2_core_ml.Fop9339.aln.sorted"
sort3="Fol_v2_core_ml.Fsp9311.aln.sorted"
sort4="Fol_v2_core_ml.Fsp9339.aln.sorted"
#sort5="Necha2_core_fixed_ml.Neo9311.aln.sorted"
#
module load samtools

samtools merge -f -@ 4 $ref2.Fop.merged.bam $sort1.bam $sort2.bam
samtools merge -f -@ 4 $ref2.Fsp.merged.bam $sort3.bam $sort4.bam


exit
