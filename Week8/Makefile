# Set the variables as desired

# The accession number of the genome (currently Mycoplasmoide pneumoniae M129)
ACC=GCF_910574535.1

# Total number of reads for sequencing simulation
N=60000

# Length of reads for sequencing simulation
L=100

# Directory for simulated files to be saved into
SIM=simulated

# Files for simulated reads
R1=pneumoniaeread1.fq
R2=pneumoniaeread2.fq
R3=pneumoniae-sim

# SRR number for the Illumina run being analyzed
SRR=SRR490750

# Directory for the FASTQ reads to be saved into
READS=reads

# Desired number of reads for quality analysis 
NUM=10000

# Directory for the FASTQC reports to be saved into
REP=reports

# Directory for the trimmed files to be saved into
TRIM=trimmed

# Directory for the trimmed reports to be saved into
TRIMREP=trimmed_reports

# Directory for the reference genome to be saved into
DIR=refs

# Reference genome for the alignment
REF=U00089.2

# Name of reference genome
NAME=pneumoniae

# Directory for the simulated BAM files to be saved into
BAM=simulated_bam

#Directory for the SRA BAM files to be saved into
BAM2=sra_bam

###### Do not change anthing below this ######

usage: 
	# To run the Makefile, type the following commands in the terminal
	@echo "Running all targets"
	@echo "make genome"
	@echo "make size"
	@echo "make chromosomes"
	@echo "make simulate"
	@echo "make read"
	@echo "make convert"
	@echo "make qc"
	# Run if there are both _1 and _2 fastq files
	@echo "make cut"
	# Run if there is only _1 fastq files
	@echo "make trim"
	@echo "make rerun"
	@echo "make index"
	# Run if there are both _1 and _2 fastq files from the SRA
	@echo "make align"
	# Run if there is only _1 fastq files from the SRA
	@echo "make align2"
	# Run with simulated reads
	@echo "make align3"
	# Run alignment stats on the simulated BAM file
	@echo "make stats"
	# Run alignment stats on the SRA BAM file
	@echo "make stats2"

genome:
	# To download the datasets using genome accession
	datasets download genome accession ${ACC}

	# Unzip
	unzip ncbi_dataset.zip

size:
	# To determine how large the data file of the genome is
	ls -lh ncbi_dataset/data/${ACC}/${ACC}_mpn_CV2_genomic.fna

	# To count the total number of base pairs in the genome
	grep -v '>' ncbi_dataset/data/${ACC}/${ACC}_mpn_CV2_genomic.fna | awk '{ total += length($0) } END { print total }'

chromosomes:
	# Counts the number of lines that start with > which is the start of a new chromosome
	grep -c '^>' ncbi_dataset/data/${ACC}/${ACC}_mpn_CV2_genomic.fna

	# Reads out the lines that start with > which is the name of each chromosome
	grep '^>' ncbi_dataset/data/${ACC}/${ACC}_mpn_CV2_genomic.fna

	# Identifies the individual lines that start with > and then counts the total number of base pairs after that chromosome name and before the next
	awk '/^>/ { if (seq) { print name, length(seq) } name = substr($$0, 2); seq = "" } !/^>/ { seq = seq $$0 } END { if (seq) { print name, length(seq) } }' ncbi_dataset/data/${ACC}/${ACC}_mpn_CV2_genomic.fna

simulate:
	# Make a directory for the simulated files to be put into
	mkdir ${SIM}

	# To use wgsim simulator to produce two read fastq files
	wgsim -e 0 -r 0 -R 0 -N ${N} -1 ${L} -2 ${L} ncbi_dataset/data/${ACC}/${ACC}_mpn_CV2_genomic.fna ${SIM}/${R1} ${SIM}/${R2}

	# To look at the details of the read files that are produced from the wgsim simulator
	seqkit stats ${SIM}/${R1} ${SIM}/${R2}

read:
	# Download the Sequence Read Archive data files from NCBI database
	prefetch ${SRR}

convert:
	# Make a directory for the FASTQ files to be put into
	mkdir ${READS}

	# Convert the SRA data into FASTQ format that includes desired number of reads for analysis with paired files split
	fastq-dump -X ${NUM} --outdir ${READS} --split-files ${SRR}

qc:
	# Go to the directory that the reads were put into
	cd ${READS}

	# Make a directory for the FASTQC files to be put into
	mkdir ${REP}

	# Run the FASTQC analysis on the first read file
	fastqc --outdir ${REP} ${READS}/${SRR}_1.fastq

# Run if there are both _1 and _2 fastq files
cut:
	# Make a directory for the trimmed files to be put into
	mkdir ${TRIM}

	# Trim the end of the per base sequence quality graph at the tail end
	fastp --cut_tail -i ${READS}/${SRR}_1.fastq -o ${TRIM}/${SRR}_1.trimmed.fastq -I ${READS}/${SRR}_2.fastq -O ${TRIM}/${SRR}_2.trimmed.fastq

# Run if there is only _1 fastq files
trim:
	# Make a directory for the trimmed files to be put into
	mkdir ${TRIM}

	# Trim the end of the per base sequence quality graph at the tail end
	fastp --cut_tail -i ${READS}/${SRR}_1.fastq -o ${TRIM}/${SRR}_1.trimmed.fastq

rerun:
	# Make a directory for the trimmed reports to be put into
	mkdir ${TRIMREP}

	# Reanalyze the trimmed reports
	fastqc --outdir ${TRIMREP} ${TRIM}/${SRR}_1.trimmed.fastq

index:
	# Create a directory for the reference genome to be put into
	mkdir ${DIR}
	
	# Download the reference genome with the GenBank accession number
	bio fetch --format fasta ${REF} > ${DIR}/${NAME}.fasta

	# Index the reference genome
	bwa index ${DIR}/${NAME}.fasta

# Run if there are both _1 and _2 fastq files from the SRA
align1:
	# Make a directory for the simulated BAM files to be put into
	mkdir ${BAM2}

	# Align the reads to the reference genome
	bwa mem ${DIR}/${NAME}.fasta ${TRIM}/${SRR}_1.trimmed.fastq ${TRIM}/${SRR}_2.trimmed.fastq > ${SRR}.sam

	# Convert the SAM file to a BAM file
	samtools view -S -b ${SRR}.sam > ${BAM2}/${SRR}.bam

	# Sort the BAM file
	samtools sort ${BAM2}/${SRR}.bam -o ${BAM2}/${SRR}.sorted.bam

	# Index the sorted BAM file
	samtools index ${BAM2}/${SRR}.sorted.bam

# Run if there is only _1 fastq files from the SRA
align2:
	# Make a directory for the simulated BAM files to be put into
	mkdir ${BAM2}

	# Align the reads to the reference genome
	bwa mem ${DIR}/${NAME}.fasta ${TRIM}/${SRR}_1.trimmed.fastq > ${SRR}.sam

	# Convert the SAM file to a BAM file
	samtools view -S -b ${SRR}.sam > ${BAM2}/${SRR}.bam

	# Sort the BAM file
	samtools sort ${BAM2}/${SRR}.bam -o ${BAM2}/${SRR}.sorted.bam

	# Index the sorted BAM file
	samtools index ${BAM2}/${SRR}.sorted.bam

# Run with simulated reads
align3:
	# Make a directory for the simulated BAM files to be put into
	mkdir ${BAM}
	
	# Align the reads to the reference genome
	bwa mem ${DIR}/${NAME}.fasta ${SIM}/${R1} ${SIM}/${R2} > ${R3}.sam

	# Convert the SAM file to a BAM file
	samtools view -S -b ${R3}.sam > ${BAM}/${R3}.bam

	# Sort the BAM file
	samtools sort ${BAM}/${R3}.bam -o ${BAM}/${R3}.sorted.bam

	# Index the sorted BAM file
	samtools index ${BAM}/${R3}.sorted.bam

# Run alignment stats on the simulated BAM file
stats:
	# Run alignment stats on the simulated BAM file
	samtools flagstat ${BAM}/${R3}.sorted.bam

# Run alignment stats on the SRA BAM file
stats2:
	# Run alignment stats on the SRA BAM file
	samtools flagstat ${BAM2}/${SRR}.sorted.bam
