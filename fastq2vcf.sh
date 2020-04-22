#!/bin/bash
# This script will pre-process, generate, and filter raw-read data, bam files, and vcfs for biolgoical analysis.
##########Variables############################
# Setup Variables
#Input filename of file with sample list
input_file=sample_list2.txt
#Input name of fasta formatted reference with .fasta (example: Salmonella)
ref=covid-19_MT039887.1
#Enter the ploidy of your organism (example: Enter 1 for haploid)
ploidy=2
#Date variable for logfile
dateum=$(date +%Y-%m-%d)

##########Reference Fasta  Files###############
#input_file is provided from user input and should contain an list (tab or space-dilimited) of SRR numbers
#ref is provided by the user and is the basename of the fasta formatted reference file
#ploidy is provided by teh user and will be called in the variant caller if statement to generate VCFs with the appropriate ploidy arguments

###################Setup Environment###########################
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bwa/0.7.12
module load samtools/1.3.1
module load picard/1.79
module load gatk/4.1.4.0
module load freebayes/1.0.2
module load sra
##################Active Script################################

if test -f "$input_file"; then
    while read F  ; do
        echo $F
        declare -a sample_list=($F)
########This will eventually be the index for the Burrows-Wheeler Align and is used to create the refernce genomes for the scripts are requires BWA
        for sample in ${sample_list[@]}; do
            bwa index $ref.fasta
        done
        echo "$(date) ---$(ref) Reference file is indexed." >> fastq2vcf.$ref.$dateum.log &&
########Uses fastq-dump to retrieve raw read fastq files and split them based on paired-end data in compressed formats.
        for sample in ${sample_list[@]}; do
            fastq-dump -X 30 --split-files -gzip $sample
        done
        echo "$(date) ---$(ref) fastq files are downloaded." >> fastq2vcf.$ref.$dateum.log &&

########Command loop to align both reads to the reference genomes to store alinment as SAM file
        for sample in ${sample_list[@]}; do
            bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref.fasta ${sample}_1.fastq.gz ${sample}_2.fastq.gz > $ref.$sample.all.sam
        done
        echo "$(date) ---$(ref) SAM files are generated." >> fastq2vcf.$ref.$dateum.log &&

########Convert SAM files to BAM file format and sort files that have been aligned to the reference genomes
        for sample in ${sample_list[@]}; do
            samtools view -@ 4 -Sb $ref.$sample.all.sam > $ref.$sample.aln.bam
            samtools sort -@ 4 -o $ref.$sample.sorted.bam $ref.$sample.aln.bam
        done
        echo "$(date) ---$(ref) SAM files are converted to BAM file format and sorted." >> fastq2vcf.$ref.$dateum.log &&

########Merge converted and sorted bam files into one file
        samtools merge -@ 4 $ref.merged.sorted.bam *.sorted.bam
        gzip *.bam
        echo "$(date) ---$(ref) BAM files are now merged and $ref.merged.sorted.bam is now generated." >> fastq2vcf.$ref.$dateum.log &&

#######QUALITY CHECK STEP-This script will be used to vaildate the bam files generated from bwa for easier downstream processing in efforts to avoid potential errors and to detect trucated files using picard tools.
        gunzip *.gz
        #Loops pulls sorted bam files to be vaildated using the ValidateSamFile tool in Picard.
        for sample in ${sample_list[@]}; do
            java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$ref.${sample}.sorted.bam MODE=SUMMARY O=$ref.${sample}.val.outputSummary
        done
        gzip *.bam
        echo "$(date) ---$(ref) BAM validation completed." >> fastq2vcf.$ref.$dateum.log &&

#######This script is used to produce stats on sorted or merged bam files using samtools flagstat and to index sorted and merged bam files using samtools index.
        gunzip *.gz
        samtools flagstat $ref.merged.sorted.bam > $ref.merged.sorted.flagstat
        samtools index $ref.merged.sorted.bam
        gzip *.bam
        echo "$(date) ---$(ref) Flagstats are and indexing is completed for $ref.merged.sorted.bam." >> fastq2vcf.$ref.$dateum.log &&

#######The purpose of this script is to mark duplicates and to generate updated flagstats on merged bam files.
        gunzip *.gz
        java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $ref.merged.sorted.bam OUTPUT= $ref.merged.sorted.dup.bam METRICS_FILE= $ref.merged.sorted.dup.metrics
        samtools flagstat $ref.merged.sorted.dup.bam > $ref.merged.sorted.dup.flagstat
        gzip *.dup.bam
        gzip *.bam
        echo "$(date) ---$(ref) Duplicates are marked for BAM file and updated flagstats for marked duplicates are now generated." >> fastq2vcf.$ref.$dateum.log &&

#######The purpose of this script is to create indexes and dictionaries of reference genomes for GATK.
        java -Xms2g -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/CreateSequenceDictionary.jar REFERENCE=$ref.fasta OUTPUT=$ref.dict
        echo "$(date) ---$(ref) Dictionaries and indexes are generated for $ref.fasta." >> fastq2vcf.$ref.$dateum.log &&

#######Below is a script for indexing fasta files using faidx.
        samtools faidx $ref.fasta
        echo "$(date) ---$(ref) Index for $(ref).fasta is now generated." >> fastq2vcf.$ref.$dateum.log &&

#######Below are scripts to generate VCF files for SNPs
        gunzip $ref.merged.sorted.bam
        if [[ $ploidy == 1 ]]; then
            #IF ploidy = 1, FreeBayes will be enabled.
            freebayes --fasta-reference $ref.fasta $ref.merged.sorted.bam --ploidy 1 -v $ref.merged.sorted.fb.vcf
            bcftools stats $ref.merged.sorted.fb.vcf > $ref.merged.sorted.fb.vchk
            echo "$(date) ---$(ref) --- FreeBayes VCFs generated for organism with ploidy = $(ploidy)." >> fastq2vcf.$ref.$dateum.log
        else
            #This one uses GATK HaplotypeCaller for ploidy not equal to 1.
            gatk --java-options "-Xmx4g" HaplotypeCaller -R $ref.fasta -I $ref.merged.sorted.bam -ploidy $ploidy -O $ref.merged.sorted.g.vcf.gz -ERC GVCF
            bcftools stats $ref.merged.sorted.g.vcf.gz > $ref.merged.sorted.g.vchk
            echo "$(date) ---$(ref) --- GATK HaplotypeCaller VCF files generated with ploidy = $(ploidy)." >> fastq2vcf.$ref.$dateum.log
        fi
####### Clean up and organize Work
        mkdir ${ref}_fastq_files
        mv *.fastq ${ref}_fastq_files/
        mkdir ${ref}_vcf_files
        mv *.vcf.* *.vcf *.vchk ${ref}_vcf_files/
        mkdir ${ref}_sam_files
        mv *.sam ${ref}_sam_files/
        mkdir ${ref}_bam_files
        mv *.bam *.bam.* ${ref}_bam_files/
        mkdir ${ref}_other_files
        mv *.outputSummary *.metrics *.flagstat ${ref}_other_files/
    done <$input_file
else
    echo "$input_file not found. Aborting!!!!"
fi

#######Attempt to save storage space by removing SAM files as they will not be called any longer in this script.
#read -p "Would you like to remove your sam files to save space on your system?: "reply
#case $reply in
#    Y|YES|y|yes) echo "SAM files deleted." >> fastq2vcf.$ref.$dateum.log
#                rm -r ${ref}_sam_files ;;
#    N|NO|n|no) echo "SAM files still stored and not deleted. Listing all files." >> fastq2vcf.$ref.$dateum.log
#                ls -al ;;
#    Q|q)        exit 0 ;;
#    *) echo "Invalid choice!"; exit 1 ;;
#esac
exit
