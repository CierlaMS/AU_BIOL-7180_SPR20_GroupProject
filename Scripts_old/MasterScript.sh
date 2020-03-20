#!/bin/bash
#master SNP script
path=/scratch/ashley_AU/pea_fastq/Step4_AW/Step4_multiline

$path/2_BwaMem.sh
$path/3_Sam2BamConvert.sh
$path/4_SortBamFiles.sh
$path/5_MergeSortedBamFiles.sh
$path/6_IndexMergedSortFiles.sh
$path/SamFileValidation.sh #will validate bam files or sam files
$path/SamtoolFlagstat.sh
#$path/MarkDuplicates.sh #also produces a flagstat file for marked duplicates
$path/MarkDuplicatesGATK.sh
$path/6_GATK_variant_calling_example.sh
exit
