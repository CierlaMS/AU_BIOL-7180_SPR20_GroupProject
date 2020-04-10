#!/bin/bash
# This script will pre-process, generate, and filter raw-read data, bam files, and vcfs for biolgoical analysis.
##########Variables############################
# Creating sample list
#declare -a sample_list=("SRR10740748" "SRR10740747" "SRR10740746" "SRR10740745" "SRR10740744" "SRR10740743" "SRR10740742" "SRR10740741" "SRR10740740" "SRR10740739")

#declare -a Sal_list=("Sal_Ref_genome.SRR10740748")
#                     "Sal_Ref_genome.SRR10740740"
#                     "Sal_Ref_genome.SRR10740741"
#                     "Sal_Ref_genome.SRR10740742"
#                     "Sal_Ref_genome.SRR10740743"
#                     "Sal_Ref_genome.SRR10740744"
#                     "Sal_Ref_genome.SRR10740745"
#                     "Sal_Ref_genome.SRR10740746"
#                     "Sal_Ref_genome.SRR10740747"
#                     "Sal_Ref_genome.SRR10740739")

#declare -a WT_list=("WT_2012_ref_assembly.SRR10740739"
#                    "WT_2012_ref_assembly.SRR10740740"
#                    "WT_2012_ref_assembly.SRR10740741"
##                    "WT_2012_ref_assembly.SRR10740742"
#                     "WT_2012_ref_assembly.SRR10740743"
#                    "WT_2012_ref_assembly.SRR10740744"
#                    "WT_2012_ref_assembly.SRR10740745"
#                    "WT_2012_ref_assembly.SRR10740746"
#                     "WT_2012_ref_assembly.SRR10740747"
#                    "WT_2012_ref_assembly.SRR10740748")

#declare -a WTc_list=("WT_2012_ref_assemblyc.SRR10740739"
#                    "WT_2012_ref_assemblyc.SRR10740740"
#                    "WT_2012_ref_assemblyc.SRR10740741"
#                    "WT_2012_ref_assemblyc.SRR10740742"
#                    "WT_2012_ref_assemblyc.SRR10740743"
#                    "WT_2012_ref_assemblyc.SRR10740744"
#                    "WT_2012_ref_assemblyc.SRR10740745"
#                    "WT_2012_ref_assemblyc.SRR10740746"
#                    "WT_2012_ref_assemblyc.SRR10740747"
#                    "WT_2012_ref_assemblyc.SRR10740748")


##########Reference Fasta  Files###############

# Path to reference genome 1
path1=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
# Path to reference genome 2
path2=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster/SRR10740739_assembly
# Defining path to sample_list
path3=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster
#Path to contig assembly
path4=/scratch/AU_BIOL-7180_GrpProject/sorted_bam_files_AW
# This reference is the traditional Salmonella genome
ref1="Sal_Ref_genome"
# This reference is the WT 2012 sample genome
ref2="WT_2012_ref_assembly"
#This is the contig WT 2012 sample genome
ref3="WT_2012_ref_assemblyc"

###################Setup Environment###########################
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bwa/0.7.12
module load samtools/1.3.1
module load picard/1.79
module load gatk/4.1.4.0

# This will eventually be the index for the Burrows-Wheeler Aligner
# This file is used to create the refernce genomes for the scripts are requires BWA

#bwa index $ref3.fasta

# Command loop to align both reads to the reference genomes to store alinment as SAM file
#for sample in  ${sample_list[@]}; do
    # Align the same sequence to reference genome 3 contig fasta file
#    bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref3.fasta $path3/${sample}_1.fastq.gz $path3/${sample}_2.fastq.gz > $ref3.$sample.aln.sam
#done

#Convert SAM files to BAM file format and sort files that have been aligned to the reference genomes
#for sample in ${WTc_list[@]}
#do
#    samtools view -bS ${sample}.aln.sam > ${sample}.aln.bam
#    samtools sort -@ 4 -o ${sample}.sorted.bam ${sample}.aln.bam
#done

#Merge convereted and sorted sam files into one file
#samtools merge -f -@ 4 $ref3.merged.sorted.bam $ref3.SRR10740739.sorted.bam $ref3.SRR10740740.sorted.bam $ref3.SRR10740741.sorted.bam $ref3.SRR10740742.sorted.bam $ref3.SRR10740743.sorted.bam $ref3.SRR10740744.sorted.bam $ref3.SRR10740745.sorted.bam $ref3.SRR10740746.sorted.bam $ref3.SRR10740747.sorted.bam $ref3.SRR10740748.sorted.bam

#QUALITY CHECK STEP-This script will be used to vaildate the bam files generated from bwa for easier downstream processing in efforts to avoid potential errors and to detect trucated files using picard tools.
#Unzip bam files
#gunzip *.bam
#Loops pulls sorted bam files to be vaildated using the ValidateSamFile tool in Picard.
#for sample in ${sample_list[@]}; do
#    java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$ref3.${sample}.sorted.bam MODE=SUMMARY O=$ref3.${sample}.val.outputSummary
#done

#Recompress bam files using gzip.
#gzip *.bam

#This script is used to produce stats on sorted or merged bam files using samtools flagstat and to index sorted and merged bam files using samtools index.
#declare -a merged_bams=("Sal_Ref_genome.sorted.merged.bam" "WT_Ref_genome.sorted.merged.bam" "WT_Refc_genome.sorted.merged.bam")

#gunzip *.gz

#for merged in ${merged_bams[@]}; do
#    samtools flagstat $path/$merged > $path/$merged.flagstat
#    samtools index $path/$merged
#done
#samtools flagstat $ref3.merged.sorted.bam > $ref3.merged.sorted.flagstat
#samtools index $ref3.merged.sorted.bam

#gzip *.bam

##The purpose of this script is to mark duplicates and to generate updated flagstats on merged bam files.
#declare -a merged_bams=("Sal_Ref_genome.sorted.merged" "WT_Ref_genome.sorted.merged" "WT_Refc_genome.sorted.merged.bam")

#Below is a loop for marking duplicates in merged bam files.
#for merged in ${merged_bams[@]}; do
#    java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $path/$merged.bam OUTPUT= $path/$merged.dup.bam METRICS_FILE= $merged.dup.metrics
#done
#java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $ref3.merged.sorted.bam OUTPUT= $ref3.merged.sorted.dup.bam METRICS_FILE= $ref3.merged.sorted.dup.metrics

#Below is a loop for flagstat on marked duplicate files.
#for merged in ${merged_bams[@]}; do
#    samtools flagstat $path/$merged.dup.bam > $path/$merged.dup.bam.flagstat
#done
#samtools flagstat $ref3.merged.sorted.dup.bam > $ref3.merged.sorted.dup.flagstat
#gzip *.bam

#The purpose of this script is to create indexes and dictionaries of reference genomes for GATK.
#Below are scripts for creating dictionaries of reference genomes.
java -Xms2g -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar REFERENCE=$ref3.fasta OUTPUT=$ref3.dict

#Below is a script for indexing fasta files using faidx.
samtools faidx $ref3.fasta

#Below aare scripts to generate VCF files for SNPs
###This one uses GATK HaplotypeCaller
gatk --java-options "-Xmx4g" HaplotypeCaller -R $ref3.fasta -I $ref3.merged.sorted.bam -O $ref3.g.vcf.gz -ERC GVCF
###This one uses Mutect2
gatk Mutect2 -R $ref3.fasta -I $ref3.merged.sorted.bam -O $ref3.unfiltered.vcf
#### Clean up and organize Work
mkdir vcf_files && mv *.vcf /vcf_files
exit
