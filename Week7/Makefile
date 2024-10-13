Usage: 
	# To run the Makefile, type the following commands in the terminal
	@echo "Running all targets"
	@echo "make Genome"
	@echo "make Size"
	@echo "make Chromosomes"
	@echo "make Simulate"
	@echo "make Read"
	@echo "make Convert"
	@echo "make QC"
	# Run if there are both _1 and _2 fastq files
	@echo "make Clean"
	# Run if there is only _1 fastq files
	@echo "make Trim"
	@echo "make Rerun"

# Set the variables as desired

# The accession number of the genome (currently Mycoplasmoide pneumoniae M129)
ACC=GCF_910574535.1

# Total number of reads for sequencing simulation
N=60000

# Length of reads for sequencing simulation
L=100

# Files to write the reads to
R1=pneumoniaeread1.fq
R2=pneumoniaeread2.fq

# SRR number for the Illumina run being analyzed
SRR=SRR490750

# Directory for the FASTQ reads to be saved into
READS=original_reads

# Desired number of reads for quality analysis 
NUM=10000

# Directory for the FASTQC reports to be saved into
REP=original_reports

###### Do not change anthing below this ######

Genome:
	# To download the datasets using genome accession
	datasets download genome accession ${ACC}

	# Unzip
	unzip ncbi_dataset.zip

Size:
	# To determine how large the data file of the genome is
	ls -lh ncbi_dataset/data/${ACC}/${ACC}*

	# To count the total number of base pairs in the genome
	grep -v '>' ncbi_dataset/data/${ACC}/${ACC}* | awk '{ total += length($0) } END { print total }'

Chromosomes:
	# Counts the number of lines that start with > which is the start of a new chromosome
	grep -c '^>' ncbi_dataset/data/${ACC}/${ACC}*

	# Reads out the lines that start with > which is the name of each chromosome
	grep '^>' ncbi_dataset/data/${ACC}/${ACC}*

	# Identifies the individual lines that start with > and then counts the total number of base pairs after that chromosome name and before the next
	awk '/^>/ { if (seq) { print name, length(seq) } name = substr($$0, 2); seq = "" } !/^>/ { seq = seq $$0 } END { if (seq) { print name, length(seq) } }' ncbi_dataset/data/${ACC}/${ACC}*

Simulate:
	# To use wgsim simulator to produce two read fastq files at 10x
	wgsim -e 0 -r 0 -R 0 -N ${N} -1 ${L}} -2 ${L} ncbi_dataset/data/${ACC}/${ACC}* ${R1} ${R2}

	# To look at the details of the read files that are produced from the wgsim simulator
	seqkit stats ${R1} ${R2}

	# To see the size of the read files generated
	ls -lh

	# To compress the read files that were generated to smaller sizes
	gzip ${R1}
	gzip ${R2}

	# To see the size of the compressed files
	ls -lh

Read:
	# Download the Sequence Read Archive data files from NCBI database
	prefetch ${SRR}

Convert:
	# Make a directory for the FASTQ files to be put into
	mkdir ${READS}

	# Convert the SRA data into FASTQ format that includes desired number of reads for analysis with paired files split
	fastq-dump -X ${NUM} --outdir ${READS} --split-files ${SRR}

QC:
	# Go to the directory that the reads were put into
	cd ${READS}

	# Make a directory for the FASTQC files to be put into
	mkdir ${REP}

	# Run the FASTQC analysis on the first read file
	fastqc --outdir ${REP} ${READS}/${SRR}_1*

# Run if there are both _1 and _2 fastq files
Clean:
	# Trim the end of the per base sequence quality graph at the tail end
	fastp --cut_tail -i ${READS}/${SRR}_1.fastq -o ${SRR}_1.trimmed.fastq -I ${READS}/${SRR}_2.fastq -O ${SRR}_2.trimmed.fastq

# Run if there is only _1 fastq files
Trim:
	# Trim the end of the per base sequence quality graph at the tail end
	fastp --cut_tail -i ${READS}/${SRR}_1.fastq -o ${SRR}_1.trimmed.fastq

Rerun:
	# Reanalyze the trimmed reports
	fastqc ${SRR}_1.trimmed.fastq
