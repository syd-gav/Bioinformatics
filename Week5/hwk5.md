## Select a genome, then download the corresponding FASTA file

### Using Mycoplasma haemofelis genome:

__The size of the file__

The size of the file is 1.2 megabytes

__The total size of the genome__ 

The genome is 1147259 base pairs long

__The number of chromosomes in the genome__ 

Mycoplasma haemofelis contains one chromosome

__The name and length of each chromosome in the genome__ 

The name of the chromosome isNC_014970.1 and the length of it is 1147259 base pairs long

## Generate a simulated FASTQ output for a sequencing instrument of your choice. Set the parameters so that your target coverage is 10x.

### Using Mycoplasma haemofelis genome:

__How many reads have you generated?__

To account for 10x target coverage I generated 60000 reads per read pair as the total length for my genome was 1147259 base pairs

__What is the average read length?__

The average read length was 100 base pairs

__How big are the FASTQ files?__

The FASTQ files are each 15 megabytes

__Compress the files and report how much space that saves.__

When the files become compressed they are now 2.7 megabytes saving 12.3 megabytes of space. 

## How much data would be generated when covering the Yeast, the Drosophila or the Human genome at 30x?

### Required Reads = (Genome Size * Coverage 30)/Average Length 100
### From my simulation above 4000reads/megabyte
### Compressed files from above are 18% that of full files

__The Yeast genome__

Since the approximate size for Saccharomyces cerevisiae is 12 million base pairs coverage at 30x would require 3.6 million reads. The full file would be about 900 megabytes and compressed would be 162 megabytes


__The Drosophila genome__

Since the approximate size for Drosophila melanogaster is 144 million base pairs coverage at 30x would require 43.2 million base pairs, the full file would be 10.8 gigabytes and compressed would be 1.9 gigabytes.

__The Human genome__

Since the approximate size for Homo sapiens is 3 Gb coverage at 30x would require 900 million reads so ~ 225 gigabytes before compression then 40.5 gigabytes after compression.
