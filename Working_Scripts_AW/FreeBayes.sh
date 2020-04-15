#!/bin/sh
# This script runs freebayes, a variant caller, to generte vcf files.
#Variables#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
path_ref=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
path_asmRay=/home/aubcls71/AU_BIOL-7180_SPR20_GroupProject/SRR10740739_assembly
path_asmRaycontig=/home/aubcls71/TestFile
ref_NCBI="Sal_Ref_genome"
ref_WT="WT_2012_ref_assembly"
ref_WTc="WT_2012_ref_assemblyc"
merge_NCBI="Sal_Ref_genome.sorted.merged"
merge_WT="WT_Ref_genome.sorted.merged"
merge_WTc="WT_2012_ref_assemblyc.merged.sorted"
#
#  load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load freebayes/1.0.2
#
#  run freebayes
#freebayes --fasta-reference $path_ref/$ref_NCBI.fasta $path/$merge_NCBI.bam -v $path/$merge_NCBI.fb.vcf
#freebayes --fasta-reference $path_asmRay/$ref_WT.fasta $path/$merge_WT.bam -v $path/$merge_WT.fb.vf
freebayes --fasta-reference $path_asmRay/$ref_WTc.fasta $path_asmRaycontig/$merge_WTc.bam -v $path_asmRaycontig/$merge_WTc.fb.vcf
