#!/bin/bash
#This scriptis used to prepare a fasta genome reference file for creating the .dict ditionary file needed for GATK. BEFORE you being, you MUST cp the reference.fna file to reference.fa for it to work. Picard seemd overly sensitive to file type extenions and will not recognize .fna as a .fa fasta file althoughth the contents are identical.
#######
##Reference Fasta Files
ref1=Necha2_core_fixed_ml
ref2=Fol_v2_core_ml

module load picard/1.79
#
java -Xms2g -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar REFERENCE=$ref1.fasta OUTPUT=$ref1.dict
java -Xms2g -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar REFERENCE=$ref2.fasta OUTPUT=$ref2.dict
end
