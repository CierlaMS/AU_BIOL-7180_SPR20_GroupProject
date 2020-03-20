#!/bin/bash

####IMPORTANT: Carefully read the hpcdocs entry for GATK4: https://hpcdocs.asc.edu/content/gatk-0

#first, configure your environment to run GATK
#run this command outside the script and logout then back in again:
#conda init bash

#load modules needed for this job
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load gatk/4.1.0.0
source activate gatk
module load java/1.8.0_131

###VARIABLES######
ref1="Fol_v2_core_ml.fasta"
#ref2="Necha2_core_fixed_ml.fasta"
sample1="Fol_v2_core_ml.Fsp.merged"
#sample2="Fol_v2_core_ml.Fop.merged"
#sample3="Necha2_core_fixed_ml.Neo9311.aln.sorted"
#####


#### COMMAND LINE FOR GATK BELOW ####

#Build Bam Index
gatk --java-options "-Xmx4G" BuildBamIndex -I $sample1.dup.bam -R $ref1
#gatk --java-options "-Xmx4G" BuildBamIndex -I $sample2.dup.bam -R $ref1
#gatk --java-options "-Xmx4G" BuildBamIndex -I $sample3.dup.bam -R $ref2

#Short Variant Discovery; this step can be multithreaded if you request more cores (try 4 first, then up to 8 if needed)
gatk --java-options "-Xmx4G" HaplotypeCaller -R $ref1 -I $sample1.dup.bam --sample-ploidy 1 -O $sample1.g.vcf.gz -ERC GVCF --verbosity ERROR
#gatk --java-options "-Xmx4G" HaplotypeCaller -R $ref1 -I $sample2.dup.bam --sample-ploidy 1 -O $sample2.g.vcf.gz -ERC GVCF --verbosity ERROR
#gatk --java-options "-Xmx4G" HaplotypeCaller -R $ref2 -I $sample3.dup.bam --sample-ploidy 1 -O $sample3.g.vcf.gz -ERC GVCF --verbosity ERROR

#Joint Genotyping
gatk --java-options "-Xmx4G" GenotypeGVCFs -R $ref1 -V $sample1.g.vcf.gz -O $sample1.vcf.gz
#gatk --java-options "-Xmx4G" GenotypeGVCFs -R $ref1 -V $sample2.g.vcf.gz -O $sample2.vcf.gz
#gatk --java-options "-Xmx4G" GenotypeGVCFs -R $ref2 -V $sample3.g.vcf.gz -O $sample3.vcf.gz

#Extract only SNPs
gatk SelectVariants -R $ref1 --variant $sample1.vcf.gz --select-type-to-include SNP --output $sample1.SNPs.vcf
#gatk SelectVariants -R $ref1 --variant $sample2.vcf.gz --select-type-to-include SNP --output $sample2.SNPs.vcf
#gatk SelectVariants -R $ref2 --variant $sample3.vcf.gz --select-type-to-include SNP --output $sample3.SNPs.vcf

#Perform variant filtering
gatk VariantFiltration -R $ref1 --variant $sample1.SNPs.vcf \
--filter-expression "QD < 2.0" --filter-name "QD2" \
--filter-expression "QUAL < 30.0" --filter-name "QUAL30" \
--filter-expression "SOR > 3.0" --filter-name "SOR3" \
--filter-expression "FS > 60.0" --filter-name "FS60" \
--filter-expression "MQ < 40.0" --filter-name "MQ40" \
--filter-expression "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
--output $sample1.SNPs.filtered.vcf

#gatk VariantFiltration -R $ref1 --variant $sample2.SNPs.vcf \                                                                                                                                                        --filter-expression "QD < 2.0" --filter-name "QD2" \
#--filter-expression "QUAL < 30.0" --filter-name "QUAL30" \
#--filter-expression "SOR > 3.0" --filter-name "SOR3" \
#--filter-expression "FS > 60.0" --filter-name "FS60" \
#--filter-expression "MQ < 40.0" --filter-name "MQ40" \
#--filter-expression "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
#--output $sample2.SNPs.filtered.vcf

#gatk VariantFiltration -R $ref2 --variant $sample3.SNPs.vcf \                                                                                                                                                        --filter-expression "QD < 2.0" --filter-name "QD2" \
#--filter-expression "QUAL < 30.0" --filter-name "QUAL30" \
#--filter-expression "SOR > 3.0" --filter-name "SOR3" \
#--filter-expression "FS > 60.0" --filter-name "FS60" \
#--filter-expression "MQ < 40.0" --filter-name "MQ40" \
#--filter-expression "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
#--output $sample3.SNPs.filtered.vcf

gzip $sample1.SNPs.vcf $sample.SNPs.filtered.vcf
#gzip $sample2.SNPs.vcf $sample.SNPs.filtered.vcf
#gzip $sample3.SNPs.vcf $sample.SNPs.filtered.vcf 

#get depth statistics
module load vcftools
vcftools --gzvcf $sample1.SNPs.filtered.vcf.gz --depth --out $sample1 #output will be called $sample1.idepth
#vcftools --gzvcf $sample2.SNPs.filtered.vcf.gz --depth --out $sample2 #output will be called $sample2.idepth
#vcftools --gzvcf $sample3.SNPs.filtered.vcf.gz --depth --out $sample3 #output will be called $sample3.idepth


#print QC metrics to a file
depth1=`awk 'NR>1 {print $3}' $sample1.idepth`
#depth2=`awk 'NR>1 {print $3}' $sample2.idepth`
#depth3=`awk 'NR>1 {print $3}' $sample3.idepth`

echo Depth for $sample1 is $depth1
#echo Depth for $sample2 is $depth2
#echo Depth for $sample3 is $depth3

#deactivate GATK; not required?
#conda deactivate gatk





