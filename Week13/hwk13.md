## Generate an RNA-Seq count matrix

### Samples Used For Analysis 

From project "Ribosome profiling of the genome-reduced bacterium Mycoplasma pneumoniae" (PRJEB54638)

- ERR9928774
- ERR9928773
- ERR9928772
- ERR9928771


**During my analysis, I was unable to get through the alignment step. For some reason, I kept getting the error that said "hisat2-align exited with value 141". When I looked up what this meant, it gave me that there could be a couple of different reasons.**

- incorrect reference genome index
- memory issues

**These were the two that stuck out to me as being the most probable. To test that it was not the reference genome index, I ran the example from the textbook, exactly as it was written from the makefile in the bioinformatics toolbox. When I did this, it ran through until I got the exact same error. This makes me think that it is a memory issue, however I am not sure how to fix it. I tried decreasing the CPU just in case. My computer should work with CPU = 4, however it didn't even work at 2, so I am not exactly sure what more I can do if it is a memory thing of how to get it to run all the way through.**

### Screenshot from IGV of my Data



### Explanation of what I saw on the count matrix