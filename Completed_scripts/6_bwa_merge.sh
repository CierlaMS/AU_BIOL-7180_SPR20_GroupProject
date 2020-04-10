#!/bin/bash

# This script is used to convert the files to an extension BWA can use to then sort the samples and merge them into one file based on the reference genome

# Creating sample lists for each of the reference genomes
declare -a Sal_list=("Sal_Ref_genome.SRR10740748")
                     "Sal_Ref_genome.SRR10740740"
                     "Sal_Ref_genome.SRR10740741"
                     "Sal_Ref_genome.SRR10740742"
                     "Sal_Ref_genome.SRR10740743"
                     "Sal_Ref_genome.SRR10740744"
                     "Sal_Ref_genome.SRR10740745"
                     "Sal_Ref_genome.SRR10740746"
                     "Sal_Ref_genome.SRR10740747"
                     "Sal_Ref_genome.SRR10740739")

declare -a WT_list=("WT_2012_ref_assembly.SRR10740739"
                    "WT_2012_ref_assembly.SRR10740740"
                    "WT_2012_ref_assembly.SRR10740741"
                    "WT_2012_ref_assembly.SRR10740742"
                    "WT_2012_ref_assembly.SRR10740743"
                    "WT_2012_ref_assembly.SRR10740744"
                    "WT_2012_ref_assembly.SRR10740745"
                    "WT_2012_ref_assembly.SRR10740746"
                    "WT_2012_ref_assembly.SRR10740747"
                    "WT_2012_ref_assembly.SRR10740748")

declare -a WTc_list=("WT_2012_ref_assemblyc.SRR10740739"
                    "WT_2012_ref_assemblyc.SRR10740740"
                    "WT_2012_ref_assemblyc.SRR10740741"
                    "WT_2012_ref_assemblyc.SRR10740742"
                    "WT_2012_ref_assemblyc.SRR10740743"
                    "WT_2012_ref_assemblyc.SRR10740744"
                    "WT_2012_ref_assemblyc.SRR10740745"
                     "WT_2012_ref_assembly.SRR10740746"
                    "WT_2012_ref_assemblyc.SRR10740747"
                    "WT_2012_ref_assemblyc.SRR10740748")


# Defining reference genomes for downstream file naming
ref1="Sal_Ref_genome"
ref2="WT_2012_ref_assembly"
ref3="WT_2012_ref_assemblyc"
# Defining path to sample lists
path3=/scratch/AU_BIOL-7180_GrpProject/sam_files_before_merging
# Setting up the environment
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load samtools/1.3.1


####


# Dealing with the Traditional Reference Genome
# Convert and sort files that have been aligned to the traditional reference genome
#for sample in ${Sal_list[@]}
#do
#    samtools view -bS $path3/${sample}.aln.sam > ${sample}.aln.bam
#    samtools sort -@ 4 -o ${sample}.sorted.bam ${sample}.aln.bam
#done

# Merge the sorted traditional reference samples into one file
<<<<<<< HEAD
#samtools merge -f -@ 4 Sal_Ref_genome.sorted.merged.bam Sal_Ref_genome.SRR10740739.sorted.bam Sal_Ref_genome.SRR10740740.sorted.bam Sal_Ref_genome.SRR10740741.sorted.bam Sal_Ref_genome.SRR10740742.sorted.bam Sal_Ref_genome.SRR10740743.sorted.bam Sal_Ref_genome.SRR10740744.sorted.bam Sal_Ref_genome.SRR10740745.sorted.bam Sal_Ref_genome.SRR10740746.sorted.bam Sal_Ref_genome.SRR10740747.sorted.bam Sal_Ref_genome.SRR10740748.sorted.bam
=======
# Tried a for do done loop to merge files, but it kept overwriting the file.
# Opted for a hard code to get the job done.
samtools merge -f -@ 4 Sal_Ref_genome.sorted.merged.bam Sal_Ref_genome.SRR10740739.sorted.bam Sal_Ref_genome.SRR10740740.sorted.bam Sal_Ref_genome.SRR10740741.sorted.bam Sal_Ref_genome.SRR10740742.sorted.bam Sal_Ref_genome.SRR10740743.sorted.bam Sal_Ref_genome.SRR10740744.sorted.bam Sal_Ref_genome.SRR10740745.sorted.bam Sal_Ref_genome.SRR10740746.sorted.bam Sal_Ref_genome.SRR10740747.sorted.bam Sal_Ref_genome.SRR10740748.sorted.bam
>>>>>>> cd1a334671690fed91a4a6d4b3eb861f0d8a97fd

#####


# Dealing with the 2012 WT Refernce Genome
# Convert and sort files that have been aligned to the 2012 WT reference genome
#for sample in ${WT_list[@]}
#do
#    samtools view -bS $path3/${sample}.aln.sam > ${sample}.aln.bam
#    samtools sort -@ 4 -o ${sample}.sorted.bam ${sample}.aln.bam
#done

# Merge the sorted WT reference samples into one file
#samtools merge -f -@ 4 WT_Ref_genome.sorted.merged.bam WT_2012_ref_assembly.SRR10740739.sorted.bam WT_2012_ref_assembly.SRR10740740.sorted.bam WT_2012_ref_assembly.SRR10740741.sorted.bam WT_2012_ref_assembly.SRR10740742.sorted.bam WT_2012_ref_assembly.SRR10740743.sorted.bam WT_2012_ref_assembly.SRR10740744.sorted.bam WT_2012_ref_assembly.SRR10740745.sorted.bam WT_2012_ref_assembly.SRR10740746.sorted.bam WT_2012_ref_assembly.SRR10740747.sorted.bam WT_2012_ref_assembly.SRR10740748.sorted.bam

# Dealing with the 2012 WT Reference Genome Contig File
# Convert and sort files that have been aligned to the 2012 WT reference genome
for sample in ${WTc_list[@]}
do
    samtools view -bS $path3/${sample}.aln.sam > ${sample}.aln.bam
    samtools sort -@ 4 -o ${sample}.sorted.bam ${sample}.aln.bam
done

# Merge the sorted WT reference samples into one file
samtools merge -f -@ 4 WT_Ref_genomec.sorted.merged.bam WT_2012_ref_assemblyc.SRR10740739.sorted.bam WT_2012_ref_assemblyc.SRR10740740.sorted.bam WT_2012_ref_assemblyc.SRR10740741.sorted.bam WT_2012_ref_assemblyc.SRR10740742.sorted.bam WT_2012_ref_assemblyc.SRR10740743.sorted.bam WT_2012_ref_assemblyc.SRR10740744.sorted.bam WT_2012_ref_assemblyc.SRR10740745.sorted.bam WT_2012_ref_assemblyc.SRR10740746.sorted.bam WT_2012_ref_assemblyc.SRR10740747.sorted.bam WT_2012_ref_assemblyc.SRR10740748.sorted.bam



# DONE WITH SCRIPT
#####



# Testing commands in the command line to ensure proper function
#samtools view -bS /scratch/AU_BIOL-7180_GrpProject/sam_files_before_merging/Sal_Ref_genome.SRR10740739.aln.sam > Sal_Ref_genome.SRR10740739.aln.bam
#samtools sort -@ 4 -o Sal_Ref_genome.SRR10740740.sorted.bam Sal_Ref_genome.SRR10740740.aln.bam
#samtools merge -f -@ 4 Sal_Ref_genome.sorted.merged.bam Sal_Ref_genome.SRR10740739.sorted.bam Sal_Ref_genome.SRR10740740.sorted.bam Sal_Ref_genome.SRR10740741.sorted.bam
