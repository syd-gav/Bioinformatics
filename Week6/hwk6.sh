# Set the following values

# SRR number for the read being analyzed
SRR=SRR27143831

# Directory for the FASTQ reads to be saved into
reads=original_reads

# Desired number of reads for analysis 
num=10000

# Directory for the FASTQC reports to be saved into
rep=original_reports

--Do not change anything beneath--

# Download the Sequence Read Archive data files from NCBI database
prefetch ${SRR}

# Make a directory for the FASTQ files to be put into
mkdir ${reads}

# Convert the SRA data into FASTQ format that includes desired number of reads for analysis with paired files split
fastq-dump -X ${num} --outdir ${reads} --split-files ${SRR}

# Go to the directory that the reads were put into
cd ${reads}

# Make a directory for the FASTQC files to be put into
mkdir ${rep}

# Run the FASTQC analysis on the first read file
fastqc --outdir ${rep} ${SRR}_1*

# Trim the end of the per base sequence quality graph at the tail end
fastp --cut_tail -i ${SRR}_1.fastq -o ${SRR}_1.trimmed.fastq -I ${SRR}_2.fastq -O ${SRR}_2.trimmed.fastq

# Reanalyze the trimmed reports
fastqc ${SRR}_1.trimmed.fastq
