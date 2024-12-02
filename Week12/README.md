## How to Run the Makefile

### What does each of the commands do?

#### Usage

Echos the commands within the Makefile

#### All

This will run all of the following makefile commands in one go.

#### Folder

This will make an individual directory for each sample to be put into with the sample SRA number as the name of the directory

#### Read

This will command will download the sample data that will be analyzed against the reference genome and will take that data to fastq format.

#### QC

Quality control analysis will be run on the sample data fastq file that was downloaded.

#### Trim 

This will trim the tail-end, to correct for the per base sequence quality.

#### Rerun

This will rerun the quality control analysis on the trimmed sample report. 

#### Index

The index code will download the reference genome with the GenBank accession number, convert it to fasta format and index the genome.

#### Align

Both will align the reads to the reference genome, convert and sort BAM resulting BAM files and then using samtools to index the sorted BAM file.

#### Stats2

This will run and spit out the alignment stats on the sample BAM file.

#### vcf

In order for this command to be run, the "Bioinformatics Toolbox" from the AI Powered Bioinformatics Course needs to be downloaded. 

```
bio code
```
Once this is downloaded the variants can be called from the sample BAM file to then be analyzed with IGV. 
