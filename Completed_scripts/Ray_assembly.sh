#!/bin/sh
#This script will be used to generate an assembly for the wildtype sample taken from the calf of interest in 2012.
###############Variables################################
path=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster
sample_2012="SRR10740739"
###############Setup Environment########################
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module purge
module load ray/2.3.1
###############Commands#################################
gunzip $path/${sample_2012}_1.fastq.gz
gunzip $path/${sample_2012}_2.fastq.gz
srun --mpi=pmi2 Ray -k 21 -p $path/${sample_2012}_1.fastq $path/${sample_2012}_2.fastq -o $path/${sample_2012}_assembly
exit
