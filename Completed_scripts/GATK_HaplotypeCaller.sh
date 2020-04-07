#!/bin/sh
#
# script to run GATK
#Variables#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
#declare -a merged_bams=("Sal_Ref_genome.sorted.merged" "WT_Ref_genome.sorted.merged")
path_ref=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
path_asmRay=/home/aubcls71/AU_BIOL-7180_SPR20_GroupProject/SRR10740739_assembly
ref_NCBI="Sal_Ref_genome"
ref_WT="WT_2012_ref_assembly"
merge_NCBI="Sal_Ref_genome.sorted.merged"
merge_WT="WT_Ref_genome.sorted.merged"
# setup to use gatk
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load gatk/4.1.4.0
# place gatk commands after this line
#gatk --java-options "-Xmx4g" HaplotypeCaller -R $path_ref/$ref_NCBI.fasta -I $path/$merge_NCBI.bam -O $path/$merge_NCBI.g.vcf.gz -ERC GVCF
gatk --java-options "-Xmx4g" HaplotypeCaller -R $path_asmRay/$ref_WT.fasta -I $path/$merge_WT.bam -O $path/$merge_WT.g.vcf.gz -ERC GVCF

exit
