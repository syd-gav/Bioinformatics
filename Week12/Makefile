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
VCF=${SRR}.vcf.gz

###### Do not change anthing below this ######

usage: 
	# To run the Makefile, type the following commands in the terminal
	@echo "Running all targets"
	@echo "make all"
	@echo "make read"
	@echo "make qc"
	@echo "make trim"
	@echo "make rerun"
	@echo "make index"
	@echo "make align"
	@echo "make stats2"
	# Need to download "bioinformatic toolbox" by command bio code for this to work
	@echo "make vcf"



all:
	make folder	
	make read
	make qc
	make trim
	make rerun
	make index
	make align
	make stats2
	make vcf

folder:
	# Make a directory for the specific sample
	mkdir ${SRR}

	# Go to the directory for that sample
	cd ${SRR}

read:
	# Download the Sequence Read Archive data files from NCBI database
	prefetch ${SRR}

	# Make a directory for the FASTQ files to be put into
	mkdir ${SRR}/${READS}

	# Convert the SRA data into FASTQ format that includes desired number of reads for analysis with paired files split
	fastq-dump -X ${NUM} --outdir ${SRR}/${READS} --split-files ${SRR}

qc:
	# Go to the directory that the reads were put into
	cd ${SRR}/${READS}

	# Make a directory for the FASTQC files to be put into
	mkdir ${SRR}/${REP}

	# Run the FASTQC analysis on the first read file
	fastqc --outdir "${SRR}/${REP}" "${SRR}/${READS}/${SRR}_1.fastq" "${SRR}/${READS}/${SRR}_2.fastq"

trim:
	# Make a directory for the trimmed files to be put into
	mkdir ${SRR}/${TRIM}

	# Trim the end of the per base sequence quality graph at the tail end
	fastp --cut_tail -i ${SRR}/${READS}/${SRR}_1.fastq -o ${SRR}/${TRIM}/${SRR}_1.trimmed.fastq -I ${SRR}/${READS}/${SRR}_2.fastq -O ${SRR}/${TRIM}/${SRR}_2.trimmed.fastq --html "${SRR}/${TRIM}" --json "${SRR}/${TRIM}"

rerun:
	# Make a directory for the trimmed reports to be put into
	mkdir ${SRR}/${TRIMREP}

	# Reanalyze the trimmed reports
	fastqc --outdir "${SRR}/${TRIMREP}" "${SRR}/${TRIM}/${SRR}_1.trimmed.fastq" "${SRR}/${TRIM}/${SRR}_2.trimmed.fastq"

index:
	# Create a directory for the reference genome to be put into
	mkdir ${SRR}/${DIR}
	
	# Download the reference genome with the GenBank accession number
	bio fetch --format fasta ${REF} > ${SRR}/${DIR}/${NAME}.fasta

	# Index the reference genome
	bwa index ${SRR}/${DIR}/${NAME}.fasta

align:
	# Make a directory for the simulated BAM files to be put into
	mkdir ${SRR}/${BAM2}

	# Align the reads to the reference genome
	bwa mem "${SRR}/${DIR}/${NAME}.fasta" "${SRR}/${TRIM}/${SRR}_1.trimmed.fastq" "${SRR}/${TRIM}/${SRR}_2.trimmed.fastq" > ${SRR}/${SRR}.sam

	# Convert the SAM file to a BAM file
	samtools view -S -b ${SRR}/${SRR}.sam > ${SRR}/${BAM2}/${SRR}.bam

	# Sort the BAM file
	samtools sort ${SRR}/${BAM2}/${SRR}.bam -o ${SRR}/${BAM2}/${SRR}.sorted.bam

	# Index the sorted BAM file
	samtools index ${SRR}/${BAM2}/${SRR}.sorted.bam


# Run alignment stats on the SRA BAM file
stats2:
	# Run alignment stats on the SRA BAM file
	samtools flagstat ${SRR}/${BAM2}/${SRR}.sorted.bam

# Call the SNPs in the resulting BAM file
vcf:
	# Bioinformatics toolbox to be downloaded
	bio code 

	# Run the variant calling on the BAM file
	make -f src/run/bcftools.mk REF=${SRR}/${DIR}/${NAME}.fasta BAM=${SRR}/${BAM2}/${SRR}.sorted.bam VCF=${SRR}/${VCF} run
