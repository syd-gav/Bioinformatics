# Set the variables as desired

# The accession number of the genome (currently Mycoplasmoide pneumoniae M129)
ACC=GCF_910574535.1

# SRR number for the Illumina run being analyzed
SRR=DRR575889

# Directory for the FASTQ reads to be saved into
READS=reads

# Desired number of reads for quality analysis 
NUM=250000

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

#Directory for the SRA BAM files to be saved into
BAM2=sra_bam

# Mapping quality for filtering
M=10

#Resulting variant VCF File (compressed)
VCF=DRR575889.vcf.gz

###### Do not change anthing below this ######

usage: 
	# To run the Makefile, type the following commands in the terminal
	@echo "Running all targets"
	@echo "make genome"
	@echo "make size"
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
	# Run alignment stats on the SRA BAM file
	@echo "make stats2"
	@echo "make vcf"

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

# Run alignment stats on the SRA BAM file
stats2:
	# Run alignment stats on the SRA BAM file
	samtools flagstat ${BAM2}/${SRR}.sorted.bam

# Call the SNPs in the resulting BAM file
vcf:
	make -f src/run/bcftools.mk REF=${DIR}/${NAME}.fasta BAM=${BAM2}/${SRR}.sorted.bam VCF=${VCF} run
