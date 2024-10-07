## Homework 6

### Identify a bad sequencing data set

1. Use data generated on the Illumina or Iontorrent platforms

Unfortunately, the organism that I had selected for the read simulation assignment Mycoplasma haemofelis does not appear to have been sequenced using Illumina or Iontorrent based on my searches. The data I have instead used is from another Mycoplasma species, Mycoplasma mycoides which comes from PRJNA1050060 "Quality control of a live bacterial vaccine against contagious bovine pleurophneumonia" and the run is SRR27143831.  

2. Write a script to download data from the SRA database

The script to download data from the SRA database that I used can be found as hwk6.sh in Applied Bioinformatics repository.

3. Evaluate the quality of the downloaded data. 

While looking at the FastQC report of the run, the overal quality of the data is not terrible, however there is some tailing at the end of the per base sequence quality graph. In addition, the sequence duplication levels are relatively high, which means that there may be some redunant amplification from sample preparation being accounted for in the sequencing. An image of the original per base sequence quality graph can be found under the Week6 folder in the Github repository.

4. Improve the quality of the reads in the dataset.

The commands used to improve the tailing by cutting off the tail of the per base sequence quality graph is included in the script in Week6 folder. 

5. Evaluate the quality again and document the improvements

Once the tail end of the sequence was trimmed then there was some improvement at the end of the sequence where a drop off of the graph was no longer present. Although the data was not incredibly of bad quality to begin with, this did improve the overall end of the sequence where there was some dropoff. An image of the corrected graph can be seen under the Week6 folder. As for the sequence duplication, as we cannot be sure that these duplications are not actually part of the sequence it was not corrected for. 
