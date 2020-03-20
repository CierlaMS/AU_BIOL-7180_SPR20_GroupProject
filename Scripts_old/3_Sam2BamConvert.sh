#!/bin/bash
#This script is used to convert a sam file to a bam file using samtools view.
#######
##Sam Alignment Files
#
saln1="Fol_v2_core_ml.Fop9311.aln"
saln2="Fol_v2_core_ml.Fop9339.aln"
saln3="Fol_v2_core_ml.Fsp9311.aln"
saln4="Fol_v2_core_ml.Fsp9339.aln"
saln5="Necha2_core_fixed_ml.Neo9311.aln"
#
module load samtools

samtools view -bS $saln1.sam > $saln1.bam
samtools view -bS $saln2.sam > $saln2.bam
samtools view -bS $saln3.sam > $saln3.bam
samtools view -bS $saln4.sam > $saln4.bam
samtools view -bS $saln5.sam > $saln5.bam

exit

