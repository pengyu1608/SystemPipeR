#!/bin/bash

if [ ! $1 ]
then
echo "Usuage: submit_SE_ChIP.sh <JobName> <InputFile> <Genome>"
exit;
fi

JobName=$1   #
InputFile=$2 #Targets.txt file 
Genome=$3; #e.g. mm9, hg19

BaseDIR="/home/yupeng/Work/Project"
WorkDIR=$BaseDIR"/"$JobName

mkdir $WorkDIR;

cp $InputFile $WorkDIR"/Targets.txt"

cd $WorkDIR;

mkdir QC;
mkdir Bam;
mkdir trimFQ;
mkdir BedGraph;
mkdir HOMER;

R --vanilla -q --args $Genome < /home/yupeng/program/SystemPipeR_rna_SEalign.R &
#R --vanilla -q --args $Genome < /home/yupeng/program/SE_rna_BamSummary.R 
