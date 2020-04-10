#!/bin/sh
#
#This script will extract SNPs from Vcf files using VCFtools
#Variables#
path=/scratch/AU_BIOL-7180_GrpProject/sorted_and_merged_bam_files_AW
#declare -a merged_bams=("Sal_Ref_genome.sorted.merged" "WT_Ref_genome.sorted.merged")
path_ref=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
path_asmRay=/home/aubcls71/AU_BIOL-7180_SPR20_GroupProject/SRR10740739_assembly
ref_NCBI="Sal_Ref_genome"
ref_WT="WT_2012_ref_assembly"
merge_NCBI="Sal_Ref_genome.sorted.merged"
merge_WT="WT_Ref_genome.sorted.merged"
# setup environment to use VCf tools
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load vcftools/0.1.14
module load gatk/4.1.4.0

#Joint Genotyping
#gatk --java-options "-Xmx4G" GenotypeGVCFs -R $path_ref/$ref_NCBI.fasta -V $path/$merge_NCBI.g.vcf.gz -O $path/$merge_NCBI.vcf.gz
#gatk --java-options "-Xmx4G" GenotypeGVCFs -R $path_asmRay/$ref_WT.fasta -V $path/$merge_WT.g.vcf.gz -O $path/$merge_WT.vcf.gz

# VCF tools commands for extracting SNP
#vcftools --vcf $path/$merge_NCBI.g.vcf.gz -ERC GVCF --remove-indels --recode --recode-INFO-all --out $path/$merge_NCBI.SNP
#vcftools --vcf $path/$merge_WT.g.vcf.gz -ERC GVCF --remove-indels --recode --recode-INFO-all --out $path/$merge_WT.SNP

#GATK commands for extracting SNP from VCF
#gatk SelectVariants -R $path_ref/$ref_NCBI.fasta --variant $path/$merge_NCBI.vcf.gz --select-type-to-include SNP --output $path/$merge_NCBI.SNPs.vcf
#gatk SelectVariants -R $path_asmRay/$ref_WT.fasta --variant $path/$merge_WT.vcf.gz --select-type-to-include SNP --output $path/$merge_WT.SNPs.vcf

#Filtering
#gatk VariantFiltration -R $path_ref/$ref_NCBI.fasta --variant $path/$merge_NCBI.SNPs.vcf -O $path/$merge_NCBI.SNPs.filtered.initial.vcf \
#--filter-expression "QD < 2.0" --filter-name "QD2" \
#--filter-expression "QUAL < 30.0" --filter-name "QUAL30" \
#--filter-expression "SOR > 3.0" --filter-name "SOR3" \
#--filter-expression "FS > 60.0" --filter-name "FS60" \
#--filter-expression "MQ < 40.0" --filter-name "MQ40" \
#--filter-expression "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8"

#gatk VariantFiltration -R $path_asmRay/$ref_WT.fasta --variant $path/$merge_WT.SNPs.vcf -O $path/$merge_WT.SNPs.filtered.initial.vcf \
#--filter-expression "QD < 2.0" --filter-name "QD2" \
#--filter-expression "QUAL < 30.0" --filter-name "QUAL30" \
#--filter-expression "SOR > 3.0" --filter-name "SOR3" \
#--filter-expression "FS > 60.0" --filter-name "FS60" \
#--filter-expression "MQ < 40.0" --filter-name "MQ40" \
#--filter-expression "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8"


# VCF tools commands for analyzing nucleotide diversity
#zcat $path/$merge_NCBI.g.vcf.gz | vcftools --vcf - --site-pi --positions $path/$merge_NCBI.SNPs.vcf --out $path/$merge_NCBI.nucleotide_diversity
#zcat $path/$merge_NCBI.SNPs.filtered.initial.vcf | vcftools --vcf - --site-pi --positions $path/$merge_NCBI.SNPs.vcf --out $path/$merge_NCBI.filt.nucleotide_diversity
#zcat $path/$merge_WT.g.vcf.gz | vcftools --vcf - --site-pi --positions $path/$merge_WT.SNPs.vcf --out $path/$merge_WT.nucleotide_diversity
#zcat $path/$merge_WT.SNPs.filtered.initial.vcf | vcftools --vcf - --site-pi --positions $path/$merge_WT.SNPs.vcf --out $path/$merge_WT.filt.nucleotide_diversity

#vcftools --gzvcf $path/$merge_NCBI.SNPs.filtered.initial.vcf --gzdiff $path/$merge_WT.SNPs.filtered.initial.vcf --diff-site --out NCBI_v_WT.vcf.filt.diff

# Run script to generate R plots
# initial_filtering_plot_MO.sh # use SNPs.filtered.initial vcf file
# Check R plots in resulting PDFs to adjust cutoff values


exit
