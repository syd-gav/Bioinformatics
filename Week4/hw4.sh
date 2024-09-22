#This script will allow the download of a GCF file and produce genome files to view in IGV

#Set the variables as below

# The accession ID of the genome
GCF=GCF_000195955.2

# The zip file following download
ZIP=ncbi_dataset.zip

# The unziped gff file
gff=ncbi_dataset/data/GCF_000195955.2/genomic.gff

# The name of the new gene separate gff file
new=ncbi_dataset/data/GCF_000195955.2/gene.gff

# Download the genome and annotation file using the accession ID
datasets download genome accession ${GCF} --include gff3,cds,protein,rna,genome

# Unzip the file that was downloaded
unzip ${ZIP}

# Look at the first 10 lines that do not have # to ensure proper download
cat ${gff} | grep '#' | head

# Put all of the lines that are annotated as a 'gene' into it's own gff file
cat ${gff} | awk ' $3=="gene" {print $0}' > ${new}

# To print the number of genes from the produced gene file
cat ${new} | wc -l
