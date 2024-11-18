#
# Variant calling workflow.
#

# Accession number of the ebola genome.
ACC=GCA_012898025.1

# The reference file.
REF=refs/nf54-2020.fa

# The GFF file.
GFF=refs/nf54-2020.gff

# The sequencing read accession number.
SRR=SRR27748157

# The number of reads to get
N=5000

# The name of the sample (see: bio search SRR27748157)
SAMPLE=nf54-2024

# The path to read 1
R1=reads/${SAMPLE}_1.fastq

# The path to read 2
R2=reads/${SAMPLE}_2.fastq

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The resulting variant VCF file (compressed!).
VCF=vcf/${SAMPLE}.vcf.gz

# Custom makefile settings.
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Print the usage of the makefile.
usage:
	@echo "#"
	@echo "# SNP call demonstration"
	@echo "#"
	@echo "# ACC=${ACC}"
	@echo "# SRR=${SRR}"
	@echo "# SAMPLE=${SAMPLE}"
	@echo "# BAM=${BAM}"
	@echo "# VCF=${VCF}"
	@echo "#"
	@echo "# make bam|vcf|all"
	@echo "#"

# Check that the bio toolbox is installed.
CHECK_FILE = src/run/genbank.mk
${CHECK_FILE}:
	@echo "#"
	@echo "# Please install toolbox with: bio code"
	@echo "#"
	@exit 1

# Create the BAM alignment file.
bam: ${CHECK_FILE}
	# Get the reference genome and the annotations.
	make -f src/run/datasets.mk ACC=${ACC} REF=${REF} GFF=${GFF} run

	# Index the reference genome.
	make -f src/run/bwa.mk REF=${REF} index

	# Download the sequence data.
	make -f src/run/sra.mk SRR=${SRR} R1=${R1} R2=${R2} N=${N} run

	# Align the reads to the reference genome. 
	# Use a sample name in the readgroup.
	make -f src/run/bwa.mk SM=${SAMPLE} REF=${REF} R1=${R1} R2=${R2} BAM=${BAM} run stats

# Call the SNPs in the resulting BAM file.
vcf:
	make -f src/run/bcftools.mk REF=${REF} BAM=${BAM} VCF=${VCF} run

# Run all the steps.
all: bam vcf

# Remove all the generated files.
clean:
	rm -rf ncbi_dataset/data/${ACC}
	rm -rf ${REF} ${GFF} ${R1} ${R2} ${BAM} ${VCF}



# VEP needs a sorted and compressed GFF file.
${GFF}.gz:
	# Sort and compress the GFF file
	# Needs the double $ to pass the $ from make to bash
	cat ${GFF} | sort -k1,1 -k4,4n -k5,5n -t$$'\t' | bgzip -c > ${GFF}.gz

	# Index the GFF file
	tabix -p gff ${GFF}.gz

# VEP is installed in the environment called vep
vep: ${GFF}.gz
	mkdir -p results
	micromamba run -n vep \
		~/src/ensembl-vep/vep \
		-i ${VCF} \
		-o results/vep.txt \
		--gff ${GFF}.gz \
		--fasta ${REF} \
		--force_overwrite 

	# Show the resulting files
	ls -lh results/*

# These targets do not correspond to files.
.PHONY: bam vcf all usage clean vep