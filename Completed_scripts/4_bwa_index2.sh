#!/bin/bash
# This will eventually be the index for the Burrows-Wheeler Aligner
# This file is used to create the refernce genomes for the scripts

##########Reference Fasta  Files###############

# Path to reference genome 1
path1=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
# Path to reference genome 2
# path2=

ref1="Sal_Ref_genome"
# This reference is the traditional Salmonella genome
# ref2=$path2/"SRR10740739"
# This reference is the WT 2012 sample genome

module load bwa

bwa index $path1/${ref1}.fasta
# bwa index $ref2.fasta

exit
