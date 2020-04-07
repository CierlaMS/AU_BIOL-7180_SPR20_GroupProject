#!/bin/bash
#This scriptis used to prepare a fasta genome index file.
#######
##Reference Fasta Files
ref1=Necha2_core_fixed_ml
ref2=Fol_v2_core_ml


module load samtools
#
samtools faidx $ref1.fasta
samtools faidx $ref2.fasta
end
