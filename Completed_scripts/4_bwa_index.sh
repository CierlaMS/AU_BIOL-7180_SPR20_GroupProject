#!/bin/bash
# This will eventually be the index for the Burrows-Wheeler Aligner
# This file is used to create the refernce genomes for the scripts

##########Reference Fasta  Files###############

# Path to reference genome 1
path1=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
# Path to reference genome 2
path2=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster/SRR10740739_assembly

ref1="Sal_Ref_genome"
# This reference is the traditional Salmonella genome
ref2="WT_2012_ref_assembly"
# This reference is the WT 2012 sample genome

module load bwa

bwa index $path1/${ref1}.fasta
bwa index $path2/${ref2}.fasta

exit
