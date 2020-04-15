#!/bin/sh
#  Script to run BEDTools and obtain fastq files from bam files.
##########Vairbales###########
#path1=/home/aubcls71/Code_Review/test
##########Setup Environment###
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bedtools/2.26.0
##########Commands############
echo "Input filename: "input_file
read input_file
echo "Input path to file: "path1
read path1
echo "Input path to bam file(s): "path2
read path2
if test -f "$input_file"; then
    while read F  ; do
        echo $F
        declare -a bam_list=($F)
        for sample in ${bam_list[@]}; do
        bedtools bamtofastq -i $path2/$sample.bam -fq $sample.fq
        done
    done <$path1/$input_file
    mkdir $path1/fastq
    mv $path2/*.fq $path1/fastq/
else
    echo "$input_file not found. Aborting!!!!"
fi

exit
