#!/bin/sh
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load spades/3.13.0

### SPAdes will not work with a For, Do, Done Loop  ###
### with submission to queue system on ASC.         ###
### This script must be submitted for each assembly ###

# Input SRR read number for SPAdes assembly below

SRR=SRR107407?? # Replace ?? with final two digits of SRR read number

# Path to data on /scratch on ASC server
path=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster/

### SPAdes is a genome assembly program. ###

#### COMMAND LINE FOR SPAdes GOES BELOW ####

# SPAdes command
spades.py -o $SRR -1 ${path}${SRR}_1.fastq.gz -2 ${path}${SRR}_2.fastq.gz -k 21,33,55 --careful -t 16

#### Make sure the --threads argument (-t) matches the number of CPUs requested


####   submit job to class queue as "this_script_name"   ####
####       request 16 CPU, and dmc as the cluster        ####
