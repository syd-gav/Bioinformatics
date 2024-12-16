## How to Run the Makefile

**NOTE** Make sure to have the bioinformatics tooldbox downloaded (bio code) as well as the stat environment to run the R commands. Instructions found in the Biostar Handbook https://www.biostarhandbook.com . In addition, to unzip the ncbi downloades, the dataset package from ncbi is required. conda install -c bioconda ncbi-datasets-cli

### What does each of the commands do?

#### Usage

Echos the commands within the Makefile

#### All

This will run all of the following makefile commands in one go.

#### Folder

This will make an individual directory for each sample to be put into with the sample SRA number as the name of the directory

#### Sample

This will download the data files from the Sequence Read Archive and convert the data into FASTQ format with the desired number of reads. 

#### Data

This will create a directory for the reference genome to be put into, download the gtf and genome data and then unzip the downloaded ncbi_dataset file. 

#### Index 

This will take the downloaded reference genome and index it using the hisat2.mk from the bioinformatics toolbox for hisat analysis

#### Align

This will align the individual sample reads to the reference genome using the hisat2.mk from the bioinformatics toolbox

#### Count

This will take aligned samples and generate a csv file that will output the counts of each identified gene. 

#### Diff

This will run a differential expression analysis using the edger script from the bioinformatics toolbox

#### pca

This will create a pca plot from the edger output data. 

#### heatmap

This will create a heatmap from the edger output data
