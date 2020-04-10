#!/bin/sh
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load spades/3.13.0

path=/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster

#Create a log file as the date to determine if the SPAdes program ran for each assembly
date1=$(date "+%b_%d_%Y_%k_%M")
echo "This is a logfile for Spades.sh" > $date1.txt

### SPAdes is a genome assembly program. ###

#### COMMAND LINE FOR SPAdes GOES BELOW ####

#Loop for SPAdes assembly on available fastq files

for file1 in $path/*_1.fastq.gz
do
file2=${file1/_1/_2}
pref=$(basename $file1)
pref1=${pref%_1.*}

#SPAdes command
spades.py -o $pref1 -1 $file1 -2 $file2 -k 21,33,55 --careful -t 16

#create a tar.gz file for each assembly
tar -zcvf $pref1.tar.gz ./$pref1/

#Add to the log file in order to determine if any one assembly was not completed
if [ -d "$pref1" ]
then
    echo "Completed run of spades -o $pref1 -1 $file1 -2 $file2 -k 21,33,55 --careful -t 16" >> $date1.txt
else
    exit
fi
done
exit

#### Make sure the --threads argument (-t) matches the number of CPUs requested


####   submit job to class queue as "this_script_name"   ####
####       request 16 CPU, and dmc as the cluster        ####
