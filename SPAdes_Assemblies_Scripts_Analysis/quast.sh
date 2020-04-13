#!/bin/sh
#
#  load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load quast/4.6.3
#
# Path for directory for SPAdes assemblies
path=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster/assemblies

# Path for reference Salmonella Muenster for comparison of assembly analysis
pathref=/scratch/AU_BIOL-7180_GrpProject/reference_genome/ncbi-genomes-2020-03-23/GCF_001246125.1_Salmonella_enterica_CVM_N51250_v1.0_genomic.fna

# place command here
# For Do Done Loop of all SRR read assemblies on all three Khmers 21, 33, and 55
for dir in ${path}/SRR107407??
do
    quast.py -R ${pathref} -o ${dir}_quast ${dir}/K21/final_contigs.fasta ${dir}/K33/final_contigs.fasta ${dir}/K55/final_contigs.fasta
done
