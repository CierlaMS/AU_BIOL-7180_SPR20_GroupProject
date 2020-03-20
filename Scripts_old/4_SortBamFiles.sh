#!/bin/bash
#This script is used to sort reads in bam file using samtools sort to make merging step easy.
#######
##Bam Alignment Files
#
baln1="Fol_v2_core_ml.Fop9311.aln"
baln2="Fol_v2_core_ml.Fop9339.aln"
baln3="Fol_v2_core_ml.Fsp9311.aln"
baln4="Fol_v2_core_ml.Fsp9339.aln"
baln5="Necha2_core_fixed_ml.Neo9311.aln"
#
module load samtools

samtools sort -@ 4 -o $baln1.sorted.bam $baln1.bam
samtools sort -@ 4 -o $baln2.sorted.bam $baln2.bam
samtools sort -@ 4 -o $baln3.sorted.bam $baln3.bam
samtools sort -@ 4 -o $baln4.sorted.bam $baln4.bam
samtools sort -@ 4 -o $baln5.sorted.bam $baln5.bam

exit
