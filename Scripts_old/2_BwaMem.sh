
#!/bin/sh
#Reference genomes and Samples List
path=/scratch/ashley_AU/pea_fastq/Step4_AW/Step4_multiline/paired_fastq
ref1="Necha2_core_fixed_ml"
ref2="Fol_v2_core_ml"
sam0=$path/Fop_9311_GGCTAC_R1.fastq
sam1=$path/Fop_9311_GGCTAC_R2.fastq
sam2=$path/Fop_9339_CGTACG_R1.fastq
sam3=$path/Fop_9339_CGTACG_R2.fastq
sam4=$path/Fsp_9311_TGACCA_R1.fastq
sam5=$path/Fsp_9311_TGACCA_R2.fastq
sam6=$path/Fsp_9339_GTTTCG_R1.fastq
sam7=$path/Fsp_9339_GTTTCG_R2.fastq
sam8=$path/Neo_9311_TTAGGC_R1.fastq
sam9=$path/Neo_9311_TTAGGC_R2.fastq
#header=$(cat $1 | head -n 1)
#id=$(echo $header | head -n 1 | cut -f 1-4 -d":" | sed 's/@//' | sed 's/:/_/g')
#sm=$(echo $header | head -n 1 | grep -Eo "[ATGCN]+$")
#echo "Read Group @RG\tID:$id\tSM:$id"_"$sm\tLB:$id"_"$sm\tPL:ILLUMINA"

#
# load the BWA environment
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bwa/0.7.12
############
#bwa commands
#Use the -R option to retain readgroups, you need this to run haplotype caller on GATK downstream to produce VCFs to call SNPs. Use the -M option to be able to run Picard Mark duplicates tool which is also under GATK.
############
#Fop
bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref2.fasta $sam0 $sam1 > $ref2.Fop9311.aln.sam
bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref2.fasta $sam2 $sam3 > $ref2.Fop9339.aln.sam

#Fsp 
bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref2.fasta $sam4 $sam5 > $ref2.Fsp9311.aln.sam
bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref2.fasta $sam6 $sam7 > $ref2.Fsp9339.aln.sam

#Neo
bwa mem -M -t 4 -R "@RG\tID:foo\tSM:bar" $ref1.fasta $sam8 $sam9 > $ref1.Neo9311.aln.sam


exit
