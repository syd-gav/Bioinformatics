## Homework 9 Questions, Answers and Commands Used

### How many reads did not align with the reference genome? 

The total number of reads that did not align with the reference genome was **796** reads. There were 496726 that did align which accounted for 99.84% of those mapped to the reference genome, leaving 796 reads to not be mapped. 

### How many primary, secondary and supplementary alignments are in the BAM file?

There are **494690** primary mapped reads, **0** secondary and **2036** supplementary in the BAM file. 

#### The above questions were answered using alignment stats which had used the following commands from my Makefile.

Run alignment stats on the SRA BAM file

```
samtools flagstat sra_bam/DRR575889.sorted.bam
```

### How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?

On the reverse strand in the first pair there are **123844** properly-paired alignments.

The command used to obtain this number was as below
```
samtools view -c -f 99 -F 16 sra_bam/DRR575889.sorted.bam 
```

### Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10.

Created file with the following commands (included under target paired in makefile)

```samtools view -f 1 -F 2308 -q ${M} -b sra_bam/DRR575889.sorted.bam > sra_bam/DRR575889.filtered.bam

samtools sort sra_bam/DRR575889.filtered.bam -o sra_bam/DRR575889.filtered.sorted.bam

samtools index sra_bam/DRR575889.filtered.sorted.bam
```

### Compare the flagstats for your original and your filtered BAM file

Reads that did not align with reference genome
- original= 796
- filtered= 0

Primary, secondary and supplementary alignments respectively
- original= 494690, 0, 2036
- filtered= 490570, 0, 0

