#!/usr/bin/env sh

## load modules
module load anaconda/3-2019.07
module load R/3.3.3

##variables
vcf=Fop_merged_ml_sorted.markdup.SNPs.filtered.initial.vcf #filtered SNPs file
#vcf=Fsp_merged_ml_sorted.markdup.SNPs.filtered.initial.vcf #filtered SNPs file
#vcf=Neo_ml_sorted.markdup.SNPs.filtered.initial.vcf #filtered SNPs file

##commands
#convert VCF files to table format
python vcf2table.py ${vcf} ${vcf}_table

##plot SNPs
## View plots by downloading the resulting pdf files
# Use 10 min, 400mb, 1 core
./plotvcftable_initial.R -I ${vcf}_table -O ${vcf}_initial.pdf
#./plotvcftable_adjusted.R -I ${vcf}_table -O ${vcf}_adjusted.pdf