#!/bin/bash

####IMPORTANT: Carefully read the hpcdocs entry for GATK4: https://hpcdocs.asc.edu/content/gatk-0

#load modules needed for this job
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load gatk/4.1.0.0
source activate gatk

###VARIABLES######
ref1="Necha2_core_fixed_ml"
ref2="Fol_v2_core_ml"
file1="Necha2_core_fixed_ml.Neo9311.aln.sorted"
file2="Fol_v2_core_ml.Fsp.merged"
file3="Fol_v2_core_ml.Fop.merged"
#####

gatk --java-options "-Xmx1G" MarkDuplicates -R $ref1.fasta -I $file1.bam -M $file1.dup.metrics -O $file1.dup.bam 
gatk --java-options "-Xmx1G" MarkDuplicates -R $ref1.fasta -I $file2.bam -M $file2.dup.metrics -O $file2.dup.bam 
gatk --java-options "-Xmx1G" MarkDuplicates -R $ref2.fasta -I $file3.bam -M $file3.dup.metrics -O $file3.dup.bam 

module load samtools
samtools flagstat $file1.dup.bam > $file1.dupGatk.flagstat
samtools flagstat $file2.dup.bam > $file2.dupGatk.flagstat
samtools flagstat $file3.dup.bam > $file3.dupGatk.flagstat


exit
