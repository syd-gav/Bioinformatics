## Link to Repository with Markdown File



## Part 1: Write a script

Script allowing for a download of genome information using a GCF ID was produced. File can be found on GIT repository at following link.

https://github.com/syd-gav/Bioinformatics/blob/main/Week4/hw4.sh

The script was practiced using peer assignment from week 3 by redefining the GCF accession number in {GCF}, {gff}, and {new}. By doing this, I was able to open all of the files produced from their results in IGV and read that there were 3978 genes.

## Part 2 Make use of ontologies

The term that I used from the GFF file is CDS for my ontology analysis. 

### CDS Definition (from The Sequence Ontology)
A contiguous sequence which begins with, and includes, a start codon and ends with, and includes, a stop codon.

### Parent Term of CDS

mRNA_region (SO:0000836)

### Children Nodes of CDS

* CDS_predicted (SO:1001254)
* edited_CDS (SO:0000935)
* polypeptide (SO:0000104)
* CDS_region (SO:0000851)
* CDS_fragment (SO:0001384)
* transposable_element_CDS (SO:0001896)
* CDS_independently_known (SO:1001246)
* CDS_extension (SO:0002227)

### What I found

What I found was that the CDS (or coding sequence) is a part of the genome that can make up, for example, a polypeptide of amino acids. This region is enclosed by a start and stop codon from the mRNA that encodes the CDS. Many of the definitions for the children nodes from the CDS have very simple definitions, such as the 'CDS_predicted' which is defined as 'a CDS that is predicted'. 