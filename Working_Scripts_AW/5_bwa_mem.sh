#!/bin/bash

# Creating sample list
declare -a sample_list=("SRR10740748" "SRR10740747" "SRR10740746" "SRR10740745" "SRR10740744" "SRR10740743" "SRR10740742" "SRR10740741" "SRR10740740" "SRR10740739")

# Defining the reference genomes
path1=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23
ref1="Sal_Ref_genome"
path2=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster/SRR10740739_assembly
ref2="WT_2012_ref_assembly"

# Defining path to sample_list
path3=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster

# Load the BWA environment
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bwa/0.7.12

# Command loop to align both reads to the reference genomes
for sample in  ${sample_list[@]}; do
    # Align the sample to reference genome 1
    bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $path1/$ref1.fasta $path3/${sample}_1.fastq.gz $path3/${sample}_2.fastq.gz > $ref1.$sample.aln.sam
    # Align the same sequence to reference genome 2
    bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $path2/$ref2.fasta $path3/${sample}_1.fastq.gz $path3/${sample}_2.fastq.gz > $ref2.$sample.aln.sam
done

##################################################################

# Command to test script on a single file to ensure proper function
# bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $path1/$ref1.fasta $path2/${test}_1.fastq.gz $path2/${test}_2.fastq.gz >> $ref1.$test.aln.sam
