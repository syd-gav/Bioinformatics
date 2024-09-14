# Homework Questions
Tell us a bit about the organism.

* The organism that I chose was Rattus norvegicus which is a brown rat or otherwise known as the Norway rat or the common rat. This rat was originally from China but can now be found all around the world and is often highly populated in areas with large populations of humans. On average this rat can live to around 2 years and have been used in scientific research for decades. (Information from https://animaldiversity.org/accounts/Rattus_norvegicus/)

How many features does the file contain?

* The file contains 1457448 lines

How many sequence regions (chromosomes) does the file contain? 

* The file contains 176 sequence regions. 

How many genes are listed for this organism?

* There are 23141 genes listed for this organism. 

What are the top-ten most annotated feature types (column 3) across the genome?

1. 526642 exon
2. 472125 CDS
3. 229890 biological_region
4. 63845 five_prime_UTR
5. 48295 three_prime_UTR
6. 45895 mRNA
7. 23141 gene
8. 6503 ncRNA_gene
9. 4159 lnc_RNA
10. 1706 snoRNA

Having analyzed this GFF file, does it seem like a complete and well-annotated organism?

* This seems like a pretty well-annotated organism. In general, there are many files included when I went to first get the gff file off of ensembl website. When looking at the file itself there are almost a million and a half lines of data. 

# How I downloaded and analyzed the file.

## Downloading the file:  

Went to https://ftp.ensembl.org/pub/current_gff3/ and selected the rattus_norvegicus/ file name. Then copied the file link named 'Rattus_norvegicus.mRatBN7.2.112.gff3.gz'.

In my terminal used the following commands to download the file and unzip it.

```
wget https://ftp.ensembl.org/pub/current_gff3/rattus_norvegicus/Rattus_norvegicus.mRatBN7.2.112.gff3.gz

ls Rattus_norvegicus.mRatBN7.2.112.gff3.gz

gunzip Rattus_norvegicus.mRatBN7.2.112.gff3.gz
```

## Analyzing the file:


For Question 2 to determine how many features the file contains
```
cat Rattus_norvegicus.mRatBN7.2.112.gff3 | wc -l
```

For Question 3 to determine how many sequence regions the files contains
```
cat Rattus_norvegicus.mRatBN7.2.112.gff3 | head

cat Rattus_norvegicus.mRatBN7.2.112.gff3 | grep sequence-region | wc -l
```

To get make a new file that does not include comments
```
cat Rattus_norvegicus.mRatBN7.2.112.gff3 | grep sequence-region | head

cat Rattus_norvegicus.mRatBN7.2.112.gff3 | grep -v sequence-region | head

cat Rattus_norvegicus.mRatBN7.2.112.gff3 | grep -v '#' | head

cat Rattus_norvegicus.mRatBN7.2.112.gff3 | grep -v '#' > norvegicus.gff3

ls -lh
```

For Question 4 to determine how many genes are listed for Rattus norvegicus
```
cat norvegicus.gff3 | cut -f 1 | head

cat norvegicus.gff3 | cut -f 1,2 | head

cat norvegicus.gff3 | cut -f 3 | head

cat norvegicus.gff3 | cut -f 3 | sort | uniq | head

cat norvegicus.gff3 | cut -f 3 | sort | uniq -c | head
```

For Question 5 to determine the top 10 most annotated feature types
```
cat norvegicus.gff3 | cut -f 3 | sort | uniq -c | sort -rn

cat norvegicus.gff3 | cut -f 3 | sort | uniq -c | sort -rn | head
```

## Link to assignment on GitHub: 
https://github.com/syd-gav/Bioinformatics