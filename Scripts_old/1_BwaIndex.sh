#!/bin/bash
#This script is used to index fasta files using bwa.
#######
##Reference Fasta  Files
#
ref1="Necha2_core_fixed_ml"
ref2="Fol_v2_core_ml"
#
module load bwa

bwa index $ref1.fasta
bwa index $ref2.fasta

exit
