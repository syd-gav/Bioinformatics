## What Each Command Does in Makefile

**During my analysis, I was unable to get through the alignment step. For some reason, I kept getting the error that said "hisat2-align exited with value 141". When I looked up what this meant, it gave me that there could be a couple of different reasons.**

- incorrect reference genome index
- memory issues

**These were the two that stuck out to me as being the most probable. To test that it was not the reference genome index, I ran the example from the textbook, exactly as it was written from the makefile in the bioinformatics toolbox. When I did this, it ran through until I got the exact same error. This makes me think that it is a memory issue, however I am not sure how to fix it. I tried decreasing the CPU just in case. My computer should work with CPU = 4, however it didn't even work at 2, so I am not exactly sure what more I can do if it is a memory thing of how to get it to run all the way through.**


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
