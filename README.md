# AU_BIOL-7180_SPR20_GroupProject
This GitHub will be dedicated to organizing the efforts made by students learning biological scripting to analyzing real datasets for a class group project.
Raw read data can be found in the following directory in scratch and in the shared box folder:
/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster



FastQC was utilized for basic quality control metrics of raw MiSeq sequencing data.

BWA was used to do the following:
    Create an index for the reference genomes (script 4)
    Align the samples we have to both reference genomes (script 5)                      
        INPUT FILE: .fastq.gz    OUTPUT FILE: .aln.sam
    Convert the aligned files to an extension the BWA could use to sort and merge files based on reference genome aligned to (script 6)
        INPUT FILE: .aln.sam     OUTPUT FILE: .sorted.merged.bam
