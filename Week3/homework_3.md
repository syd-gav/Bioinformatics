# Reformat Your Previous Assignment
### My Git link to reformated assignment
https://github.com/syd-gav/Bioinformatics/blob/main/Week2/Homework_2.md

# Visualize the GFF File of Your Choice
I used the NCBI Datasets Database to analyze the _Mycoplasma haemofelis_ genome

Git repository link

https://github.com/syd-gav/Bioinformatics/tree/main/Week3

### Downloading the genome and annotation files
```
datasets summary genome accession GCF_000200735.1

datasets summary genome accession GCF_000200735.1 | jq

datasets download genome accession GCF_000200735.1

ls

unzip ncbi_dataset.zip

cat ncbi_dataset/data/GCF_000200735.1/GCF_000200735.1_ASM20073v1_genomic.fna | head

datasets download genome accession GCF_000200735.1 --include gff3,cds,protein,rna,genome

ls

unzip ncbi_dataset.zip
```
### Visualizing Annotations Relative to the Genome
See images posted on Git repository
* HF1RS02920_Start_Reverse_Strand
*HF1RS02920_End_Reverse_Stand_HF1RS02915_End_Forward_Strand

### Separating genes into a different file
```
cat ncbi_dataset/data/GCF_000200735.1/genomic.gff | grep '#' | head

cat ncbi_dataset/data/GCF_000200735.1/genomic.gff | awk ' $3=="gene" {print $0}'
> ncbi_dataset/data/GCF_000200735.1/gene.gff
```

See images of separate file on Git repository 
* gene_file_vs_genomic_file

### Creating a GFF Representing an Interval

Text in the GFF file 

NC_014970.1	.	.	4000	5500	.	.	.	.

See imagine of GFF file in IGV in Git repository 
* simple_gff_file_included_IGV