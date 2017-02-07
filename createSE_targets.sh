#!/bin/bash
#create Targets.txt file for single-end seq data needed by systemPipeR

DIR=`pwd`

echo -e "FileName\tSampleName\tFactor\tSampleLong\tExperiment" >Targets.txt

for i in `ls *fastq *fastq.gz`

do

fileName=$DIR"/"$i
i=${i%%_S*_R*_001.fastq*}

echo -e "$fileName\t$i\t$i\t$i\t1" >> Targets.txt
done
