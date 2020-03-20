#!/bin/bash
bam1="Fol_v2_core_ml.Fop9311.aln"
bam2="Fol_v2_core_ml.Fop9339.aln"
bam3="Fol_v2_core_ml.Fsp9311.aln"
bam4="Fol_v2_core_ml.Fsp9339.aln"
bam5="Necha2_core_fixed_ml.Neo9311.aln"

module load picard/1.79

java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$bam1.bam MODE=SUMMARY O=$bam1.val.outputSummary
java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$bam2.bam MODE=SUMMARY O=$bam2.val.outputSummary
java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$bam3.bam MODE=SUMMARY O=$bam3.val.outputSummary
java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$bam4.bam MODE=SUMMARY O=$bam4.val.outputSummary
java -Xmx4g -jar /opt/asn/apps/picard_1.79/picard-tools-1.79/ValidateSamFile.jar I=$bam5.bam MODE=SUMMARY O=$bam5.val.outputSummary

exit
