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

# The accession number of the genome (currently Mycoplasmoide pneumoniae M129)
ACC=GCF_000027345.1

# The NCBI unzipped pathway
NCBI= ncbi_dataset/data/${ACC}

# The file name of the reference genome
GEN= ${DIR}/${NCBI}/GCF_000027345.1_ASM2734v1_genomic.fna

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
	@echo "make all"
	@echo "make folder"
	@echo "make sample"
	@echo "make data"
	@echo "make index"
	@echo "make align"
	@echo "make count"
	@echo "make diff"
	@echo "make pca"
	@echo "make heatmap"


# run all targets
all: folder sample data index align count diff pca heatmap

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
	
	# To download the datasets using genome accession
	if [ ! -d "${DIR}/ncbi_dataset" ]; then \
		datasets download genome accession --include genome,gtf ${ACC}; \
	fi

	# Unzip
	if [ ! -d "${DIR}/ncbi_dataset" ]; then \
		unzip ncbi_dataset.zip -d ${DIR}; \
	fi


# Generate the HISAT2 index
index:
	if [ ! -d "${NCBI}/idx" ]; then \
		make -f src/run/hisat2.mk index REF=${GEN}; \
	fi

# Run the alignment
align: 
		make -f src/run/hisat2.mk \
		NCPU=${NCPU} \
		REF=${GEN} \
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
		parallel -u --xargs featureCounts -a ${DIR}/${NCBI}/genomic.gtf -o ${COUNTS_TXT} {}

# The final counts in CSV format.
${COUNTS}: ${COUNTS_TXT}
	micromamba run -n stats Rscript src/r/format_featurecounts.r -c ${COUNTS_TXT} -o ${COUNTS}

# Trigger the counting explicitly
count: ${COUNTS}
	@ls -lh ${COUNTS_TXT}
	@ls -lh ${COUNTS}

# Run differential expression analysis on the count csv file using edger and making sure to be in the stats environment (make sure that the design file includes the group identification)
diff:
	micromamba run -n stats Rscript src/r/edger.r -c ${COUNTS} -d ${DESIGN} -o edger.csv

# Run the PCA analysis on the count csv file
pca:
	micromamba run -n stats src/r/plot_pca.r -c edger.csv -o res/pca

# Run the heatmap analysis on the count csv file
heatmap:
	micromamba run -n stats src/r/plot_heatmap.r -c edger.csv -o res/heatmap