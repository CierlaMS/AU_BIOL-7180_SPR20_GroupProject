# AU_BIOL-7180_SPR20_GroupProject
This GitHub will be dedicated to organizing the efforts made by students learning biological scripting to analyzing real datasets for a class group project.
Raw read data can be found in the following directory in scratch and in the shared box folder:
/scratch/AU_BIOL-7180_GrpProject/samples_Salmonella_muenster

## Background
Salmonella Gram-Negative Bacilli![Salmonella Gram-Negative Bacilli](https://pixnio.com/free-images/science/microscopy-images/salmonellosis-salmonella/gram-negative-bacilli-or-rod-shaped-salmonella-sp-bacteria-725x493.jpg)

## Reference Genomes and Assemblies Used
1. [Traditional NCBI Refernce: _Salmonella enterica CVM N51250 v1.0_ (SER)](https://www.ncbi.nlm.nih.gov/assembly/GCF_001246125.1)
2. Ray Assembly of WT-2012 (scaffolds): SER_ray
3. Ray Assembly of WT-2012 (contig): SER_rayc
4. SPAdes Assembly of WT-2012: SER_spades

|Reference| Genome Assembly Size|
|---|---|
| _Salmonella enterica CVM N51250 v1.0_ | 4.7 Mbp|
| SER_ray | 4.8 Mbp |
| SER_rayc | 4.8 Mbp |
| SER_spades | - Mbp |

## General Workflow

<img src="/https://github.com/asw0049/AU_BIOL-7180_SPR20_GroupProject/blob/master/Workflow.png" width="200" height="200" />

1. Obtain raw reads using SRA Toolkit fastqDump.
2. FastQC was utilized for basic quality control metrics of raw MiSeq sequencing data.[Step 2](https://github.com/asw0049/AU_BIOL-7180_SPR20_GroupProject/tree/master/fastQC)
3. Analyzed data for trimming (Step skipped)
4. BWA for aligining reads to reference genomes and assemblies.
	BWA was used to do the following:
    Create an index for the reference genomes (script 4)
    Align the samples we have to both reference genomes (script 5)                      
        INPUT FILE: .fastq.gz    OUTPUT FILE: .aln.sam
    Convert the aligned files to an extension the BWA could use to sort and merge files based on reference genome aligned to (script 6)
        INPUT FILE: .aln.sam     OUTPUT FILE: .sorted.merged.bam
5. Generate phylogeny of samples using CSIPhylogeny.
![SNP Sample Phylogeny](https://github.com/asw0049/AU_BIOL-7180_SPR20_GroupProject/blob/master/snp_tree.main_tree.svg)
   

Author contributions are listed in Contributions.md. [Contributions]
