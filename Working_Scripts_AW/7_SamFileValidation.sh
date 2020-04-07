#!/bin/bash
###File name example: Sal_Ref_genome.SRR10740739.sorted.bam.gz or WT_2012_ref_assembly.SRR10740739.sorted.bam.gz
path=/scratch/AU_BIOL-7180_GrpProject/sorted_bam_files_AW
declare -a sample_list=("SRR10740748" "SRR10740747" "SRR10740746" "SRR10740745" "SRR10740744" "SRR10740743" "SRR10740742" "SRR10740741" "SRR10740740" "SRR10740739")

#############Setup Environment###########

module load picard/1.79

############Commands#####################
gunzip $path/*.gz

for sample in ${sample_list[@]}; do
    java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$path/Sal_Ref_genome.$sample.sorted.bam MODE=SUMMARY O=$path/Sal_Ref_genome.$sample.val.outputSummary
done


for sample in ${sample_list[@]}; do
    java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$path/WT_2012_ref_assembly.$sample.sorted.bam MODE=SUMMARY O=$path/WT_2012_ref_assembly.$sample.val.outputSummary
done

gzip $path/*.bam

exit
