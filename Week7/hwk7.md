## What the Merged Makefile Created Does

The first half of the Makefile is used to download and analyze the size and details of an organism's genome. In addition, it will use a simulator to produce fastq files from the genome, allowing the target coverage to be selected by changing the variables prior to the script. The size of these files can also be analyzed using the Makefile

The second half of the file will look at the quality of an Illumina run. It will produce a FastQC file of the raw data and then allow for cleaning of the data through trimming of poor reads in the per base sequence quality graph and then produce new cleaned FastQC files to confirm improved quality after cleaning of data. 

## Targets Used in the Merged Makefile Created with Explanations of Each

### Usage
 
This target lists out the other targets utilized in the Makefile report that can be run at each step.

### Genome

The 'Genome' target will download the genome using the NCBI accession number and unzip the file.

### Size

The 'Size' target will read out how large the data file of the genome is in bytes by detailing the list of files in the unziped directory. In addition, it will read the genome FNA file and identify the number of base pairs in the genome downloaded. 

### Chromosomes

The "Chromosomes" target will read out three different things. The first two are the number of chromosomes in the genome and the name of each of the chromosomes. The third read out is the number of base pairs in each individual chromosome rather than the genome as a whole. 

### Simulate

The "Simulate" target uses the wgsim simulator to produce fastq files at a desired coverage. It will first create two read fastq files using parameters set in the variables section, then it will read the size of the produced files. The two files will be compressed and the size reevaluated. 

### Read

The "Read" target will download the data files from the Sequence Read Archive using the SRR number provided in the variables section. 

### Convert

The "Convert" target will first create a new directory that the created fastq files will be put into. Then it will convert SRA data into fastq files at an identified number of reads into the newly created directory. In addition, if the data is paired, it will split the paired files into two. 

### QC

The "QC" target will first make a directory for the QC reports to be put into. Then it will run the fastqc command on the first read file produced from the "Convert" target prior. 

### Clean

The "Clean" target should be used if the files were paired and produced split files. It will trim the per base sequence quality data at the tail end of the graph. 

### Trim

The "Trim" target will also trim the per base sequence quality data at the tail, however is used if there are not split files produced.

### Rerun

The "Rerun" target is used to reanalyze the data following it being cleaned up. The same fastqc command as in the "QC" target will be used. 