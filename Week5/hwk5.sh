# This script can be used to answer the questions for Homework 5

# Set the variables as desired

# The accession number of the genome
AN=GCF_000200735.1

# Total number of reads
Tot=60000

# Length of reads
Leg=100

# Files to write the reads to
R1=haemofelisread1.fq
R2=haemofelisread2.fq

###### Do not change anthing below this ######

# To download the datasets using genome accession
datasets download genome accession ${AN}

# Unzip the file
unzip ncbi_dataset.zip

# To determine how large the data file of the genome is
ls -lh ncbi_dataset/data/${AN}/${AN}*

# To count the total number of base pairs in the genome
grep -v '>' ncbi_dataset/data/${AN}/${AN}* | awk '{ total += length($0) } END { print total }'

# Counts the number of lines that start with > which is the start of a new chromosome
grep -c '^>' ncbi_dataset/data/${AN}/${AN}*

# Reads out the lines that start with > which is the name of each chromosome
grep '^>' ncbi_dataset/data/${AN}/${AN}*

# Identifies the individual lines that start with > and then counts the total number of base pairs after that chromosome name and before the next
awk '/^>/ { if (seq) { print name, length(seq) } name = substr($0, 2); seq = "" } !/^>/ { seq = seq $0 } END { if (seq) { print name, length(seq) } }' ncbi_dataset/data/${AN}/${AN}*

# To use wgsim simulator to produce two read fastq files at 10x
wgsim -e 0 -r 0 -R 0 -N ${Tot} -1 ${Leg} -2 ${Leg} ncbi_dataset/data/${AN}/${AN}* ${R1} ${R2}

# To look at the details of the read files that are produced from the wgsim simulator
seqkit stats ${R1} ${R2}

# To see the size of the read files generated
ls -lh

# To compress the read files that were generated to smaller sizes
gzip ${R1}
gzip ${R2}

# To see the size of the compressed files
ls -lh
