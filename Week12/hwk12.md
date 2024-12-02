## Automate a VCF Calling Pipeline

#### Create a Makefile that can produce a VCF file by downloading a reference genome, indexing it, and then downloading fastq files from SRA, aligning them to the reference and calling variants

The Makefile can found in folder Week12 of GitHub repository.

#### Create a README.md file that explains how to run the Makefile

The README file can be found in the Week12 folder of GitHub repository that explains each of the make commands does.

#### Collect a set of samples from the SRA database that match your genome.

Sample SRA codes are below
- DRR575889
- ERR9928525
- SRR24210465
- ERR5775620
- ERR9467535
- ERR6807369

#### Create a design.csv file that lists the samples to be processed. 

The design.csv file can be found in the Week12 folder of GitHub repository

#### Using GNU parallel or any other method of your choice run the Makefile on all (or a subset) of the samples.

The Makefile was run on all 6 of the samples that were selected. One thing that I was unsure about was for some reason my command (below) would only run and output information if the --dryrun was included. I know that the --dryrun was supposed to only output the commands without running, however it needed to be present for me to get any information to be output. 

```
cat  design.csv | parallel --header --dryrun make all  SRR={}
```

#### Merge the resulting VCF files into a single one.

The VCF files were merged using the command below.

```
bcftools merge DRR575889/DRR575889.vcf.gz ERR6807369/ERR6807369.vcf.gz ERR9467535/ERR9467535.vcf.gz ERR9928525/ERR9928525.vcf.gz SRR24210465/SRR24210465.vcf.gz -o merged.vcf -O v
```

#### Discuss what you see in your VCF file

Within my VCF file, the biggest thing that I see is that the ERR9928525 sample differs in the variants called from the other samples. For example, at position 223,091 of Chromosome U00089.2, this is the only sample that has a SNP called that replaced the reference T with a C. The same is true for position 309,468 as this was the only sample that had a 
C rather than the G reference. The opposite can be said in other places, where this sample did not have a variant called while the other samples did. For example at positions 520,379 and 520,387 the ERR9928525 sample was the only one that did not have a G->A SNP called. 