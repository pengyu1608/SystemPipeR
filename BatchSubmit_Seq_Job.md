#Aim of this file
#Pre-process raw sequencing data and submit fastq files to server

1. Pre-processing raw data

Usually one sequencing run is composed of a group of samples (e.g. 24). Each sample has a unique index. So the first step of data 
processing is to demultiplex samples.

Illumina supplies a tool bcl2fastq2 to do the job. It could demultiplex and trim adaptors simutaneously. 
You need to prepare a SampleSheet.csv file. Firstly install Illumina Expriment Manager (IEM) on your computer.

1) After opening IEM, choose "Create Sample Sheet" -> "NextSeq" -> "NextSeq Fastq Only"
Parameters:
*Regent kit barcode: e.g. 15025063, check the vendor package
*Lirary Prep kit: e.g. TrueSeq LT
*Index read: 0,1 or 2 (no index, single-end and pair-end)
*Experiment Name
*Investigator Name
*Description
*Read Type: SE or PE
*Cycles Read 1: length of read1
*Cycles Read 2: length of read2


2) In the next page, select "New Plate" and input Plate Name.
   Fill in Sample ID, Sample Name. Select right Index number e.g. A001. The software will automatically fill sequence of index later.
   Finish and save the plate file.
   
3) Create SampleSheet
   After filling Plate Information, select all samples and click the button "" 
