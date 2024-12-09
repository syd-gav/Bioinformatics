## What Each Command Does in Makefile

**Note:** Make sure that you have the bioinformatics toolbox downloaded (bio cod) as well as the environment set up to run R commands. Instructions found in the Biostar Handbook https://www.biostarhandbook.com  

### Design

This is run to ensure that the design.csv file is present in the directory before running the code. 

### Folder

This will make a directory for each of the samples that the code is run for to make clean output of the data. 

### Sample

This will download the individual sample Sequence Read Archive data files using the SRR number provided from the project. It will then convert to FASTQ format with desired reads. 

### Data

This will download the reference genome into three different formats: fasta, fastq and gtf. 

### Index

This indexes the reference genome with the hisat2 program. 

### Align

This will run the allignment of the samples to the reference genome, using hisat2. 

### Count

This will run the counts of the samples and put the values into csv format. 
