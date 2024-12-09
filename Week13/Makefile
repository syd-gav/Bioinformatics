# Designed using the Biostar Handbook: https://www.biostarhandbook.com
# 
# This code will perform RNA-seq analysis using the hisat2 aligner
#
# You will need to download the bioinformatics toolbox: bio code

# Variables

# The design file
DESIGN = design.csv

# The sample SRR number
SRR = ERR9928774

# Directory for reads to be put into
READS = reads

# Desired number of reads
NUM=250000

# Directory for the reference genome to be put into
DIR = ref

# The reference GenBank genome accession number
REF = U00089.2

# The accession number of the genome (currently Mycoplasmoide pneumoniae M129)
ACC=GCF_910574535.1

# The name of the reference genome
NAME = pneumoniae

# Flags passed to parallel.
FLAGS = --eta --lb --header : --colsep ,

# Number of CPUS to use
NCPU = 4

# The counts in tab delimited format.
COUNTS_TXT = res/counts-hisat.txt

# Final combinted counts in CSV format.
COUNTS = res/counts-hisat.csv

##### Do not change anything below this ######

usage:
	@echo "# To run the Makefile, type the following commands in the terminal"
	@echo: "# data uses the ncbi_dataset package to download the genome and gtf files, download if needed: conda install -c bioconda ncbi-datasets-cli"
	@echo "make design"
	@echo "make all"
	@echo "make folder"
	@echo "make sample"
	@echo "make data"
	@echo "make index"
	@echo "make align"
	@echo "make count"


#run all targets
all: design folder sample data index align count

# visualize the design file
design:
	@ls -lh ${DESIGN}

# For each sample, make a directory for clean output
folder:
	# Make a directory for the specific sample
	mkdir ${SRR}

	# Go to the directory for that sample
	cd ${SRR}

# Download the individual sample data and convert to fastq format
sample:
	# Download the Sequence Read Archive data files from NCBI database
	prefetch ${SRR}

	# Make a directory for the FASTQ files to be put into
	mkdir ${SRR}/${READS}

	# Convert the SRA data into FASTQ format
	fastq-dump -X ${NUM} --outdir ${SRR}/${READS} --split-files ${SRR}


# Download the data and make fastq, fasta and gtf files
data:
	# Create a directory for the reference genome to be put into
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
	fi

	# Download the reference genome with the GenBank accession number
	if [ ! -f "${DIR}/${NAME}.fasta" ]; then \
		bio fetch --format fasta ${REF} > ${DIR}/${NAME}.fasta; \
	fi
	
	# To download the datasets using genome accession
	if [ ! -d "${DIR}/ncbi_dataset" ]; then \
		datasets download genome accession ${ACC}; \
	fi

	# Unzip
	if [ ! -d "${DIR}/ncbi_dataset" ]; then \
		unzip ncbi_dataset.zip -d ${DIR}; \
	fi

	# Download gtf format using NCBI accession number
	if [ ! -f "${DIR}/${NAME}.gtf" ]; then \
		datasets download genome accession ${ACC} --filename ${DIR}/${NAME}.gtf; \
	fi

# Generate the HISAT2 index
index:
	make -f src/run/hisat2.mk index REF=${DIR}/${NAME}.fasta

# Run the alignment
align: 
		make -f src/run/hisat2.mk \
		NCPU=${NCPU} \
		REF=${DIR}/${NAME}.fasta \
		R1=${SRR}/reads/${SRR}_1.fastq \
		BAM=bam/${SRR}.bam \
		run

# The counts as textfile produced by featurecounts.
${COUNTS_TXT}:
	# Make the directory name for the counts
	mkdir -p $(dir $@)

	# Count the features
	cat ${DESIGN} | \
		parallel --header : --colsep , -k echo bam/{SRR}.bam | \
		parallel -u --xargs featureCounts -a ${DIR}/${NAME}.gtf -o ${COUNTS_TXT} {}

# The final counts in CSV format.
${COUNTS}: ${COUNTS_TXT}
	micromamba run -n stats Rscript src/r/format_featurecounts.r -c ${COUNTS_TXT} -o ${COUNTS}

# Trigger the counting explicitly
count: ${COUNTS}
	@ls -lh ${COUNTS_TXT}
	@ls -lh ${COUNTS}