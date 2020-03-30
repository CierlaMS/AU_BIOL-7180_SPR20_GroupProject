#!/bin/bash
#The pupose of this script is to mark duplicates in bam files.
file1="Necha2_core_fixed_ml.Neo9311.aln.sorted"
file2="Fol_v2_core_ml.Fsp.merged"
file3="Fol_v2_core_ml.Fop.merged" 

#source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load picard/1.79

java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $file1.bam OUTPUT= $file1.dup.bam METRICS_FILE= $file1.dup.metrics
java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $file2.bam OUTPUT= $file2.dup.bam METRICS_FILE= $file2.dup.metrics
java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/MarkDuplicates.jar INPUT= $file3.bam OUTPUT= $file3.dup.bam METRICS_FILE= $file3.dup.metrics

module load samtools
samtools flagstat $file1.dup.bam > $file1.dup.flagstat
samtools flagstat $file2.dup.bam > $file2.dup.flagstat
samtools flagstat $file3.dup.bam > $file3.dup.flagstat

exit
