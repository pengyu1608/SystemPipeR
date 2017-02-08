# SystemPipeR

##Object: use SystemPipeR to batch submit NGS reads for alignment.

To submit alignment job, a sery of shell programs could be used: submit_PE_ChIP.sh (pair-end) and submit_SE_ChIP.sh (single-end) for ChIP-seq data; submit_PE_rna.sh and submit_SE_rna.sh for RNA-Seq.

Usuage: (Take submit_PE_ChIP.sh as example)

submit_PE_ChIP.sh <OutputDir> <JobTitle> <TargetFile> <Genome>

	• <OutputDir> the path to output your results
	• <JobTitle> is the name of the project, e.g. 2016_mES_ChIP. The program will create a directory named as JobTitle in the OutputDir directory.
	• <TargetFile> is the file containing the information of input seq files
	For PE data, six columns are needed: FileName1, FileName2, SampleName, Factor, SampleLong, Experiment.
		○ FileName1: path of read1
		○ FileName2: path of read2
		○ SampleName: short name of the sequencing sample
		○ Factor: name of interested factor, e.g. H3K4me3
		○ SampleLong: long name of the sequencing sample
		○ Experiment: the replicate number of the experiment, e.g. if there are two replicates, they coule be signed as 1 and 2.
		
	  For SE data, 5 columns are needed: FileName, SampleName, Factor, SampleLong, Experiment
	• <Genome> e.g. mm9 or hg19

**Two sheel program [createSE_targets.sh](createSE_targets.sh) and [createPE_targets.sh](createPE_targets.sh) could be used to create Targets.txt file.**

Output:

The results will be outputed to the OutPut directory 
here are two files and three basic directories:
Files:
  Targets.txt: the input file 
  BamSummary: Summary of aligned Bam files

Directories:
  QC: store the QC report the reads
  TrimFQ: store the good-quality reads after filtering bad reads. Filtering criteria: N count is less than 5%, mean phred score >20.
  Bam: store the Bam files

Details of the program:

	1. To run systempipeR, param for each program and sysargs need to be set, please see:
	https://htmlpreview.github.io/?https://github.com/tgirke/systemPipeR/blob/master/vignettes/systemPipeR.html#structure-of-param-file-and-sysargs-container  
	
	2. To run parallel work, a configuartion file and a queue template file are needed. We are using Sun Grid Engine queue system, so a conf file SGEbatchJob.R and template file SGE.tmpl were provided.
	
	There are two parallel modes in SystemPipeR:

	1. clusterRun  is used to run programs independent of R, e.g. bowtie, tophat etc.
	2. bplapply  is used to run programs written by R, e.g. rsubread.
	
Examples of two modes could be seen at https://htmlpreview.github.io/?https://github.com/tgirke/systemPipeR/blob/master/vignettes/systemPipeR.html 

To run rsubread for alignment, theorotically both modes should work. However for pair-end data only clusterRun (after installing rsubread command line) works. For SE data, the bplapply mode could be used. For consistency, all the data are analyzed in clusterRun mode via rsubread command line (subread-align Version 1.5.0-p3).


