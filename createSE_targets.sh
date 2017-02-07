#!/bin/bash
#create Targets.txt file for Single-end seq data needed by systemPipeR

DIR=`pwd`

echo -e "FileName1\tFileName2\tSampleName\tFactor\tSampleLong\tExperiment" >Targets.txt

for i in `ls *001.fastq.gz`  #change the name to your first read file

do

fileName1=$DIR"/"$i
fileName2=${fileName1/_001/_002}

i=${i%%_S*_R*_001.fastq*}

echo -e "$fileName1\t$fileName2\t$i\tSi\t$i\t1" >> Targets.txt
done
