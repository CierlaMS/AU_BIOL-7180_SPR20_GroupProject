#!/bin/sh
#
# script to run GATK
#Variables#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
path_ref=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
path_asmRay=/home/aubcls71/AU_BIOL-7180_SPR20_GroupProject/SRR10740739_assembly
path_asmRaycontig=/home/aubcls71/TestFile
path2=/scratch/AU_BIOL-7180_GrpProject/VCF_files
ref_NCBI="Sal_Ref_genome"
ref_WT="WT_2012_ref_assembly"
ref_WTc="WT_2012_ref_assemblyc"
merge_NCBI="Sal_Ref_genome.sorted.merged"
merge_WT="WT_Ref_genome.sorted.merged"
merge_WTc="WT_2012_ref_assemblyc.merged.sorted"

# setup to use gatk and freebayes
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load gatk/4.1.4.0
#module load freebayes/1.0.2
# place gatk commands after this line
#gatk --java-options "-Xmx4g" HaplotypeCaller -R $path_ref/$ref_NCBI.fasta -I $path/$merge_NCBI.bam -ploidy 1 -O $path2/$merge_NCBI.g.p.vcf.gz -ERC GVCF
#gatk --java-options "-Xmx4g" HaplotypeCaller -R $path_asmRay/$ref_WT.fasta -I $path/$merge_WT.bam -ploidy 1 -O $path2/$merge_WT.g.p.vcf.gz -ERC GVCF
gatk --java-options "-Xmx4g" HaplotypeCaller -R $path_asmRay/$ref_WTc.fasta -I $path_asmRaycontig/$merge_WTc.bam -ploidy 1 -O $path2/$merge_WTc.g.p.vcf.gz -ERC GVCF
#
#  run freebayes
#freebayes --fasta-reference $path_ref/$ref_NCBI.fasta $path/$merge_NCBI.bam --ploidy 1 -v $path2/$merge_NCBI.fb.p.vcf
#freebayes --fasta-reference $path_asmRay/$ref_WT.fasta $path/$merge_WT.bam --ploidy 1 -v $path2/$merge_WT.fb.p.vcf
#freebayes --fasta-reference $path_asmRay/$ref_WTc.fasta $path_asmRaycontig/$merge_WTc.bam --ploidy 1 -v $path2/$merge_WTc.fb.p.vcf

exit
