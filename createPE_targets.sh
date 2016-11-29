Dir=`pwd`

echo  "FileName1	FileName2	SampleName	Factor	SampleLong	Experiment" >Targets.txt

for i in `ls *1.sanger.fastq.gz`  #change the name to your first read file

do

fileName1=$Dir"/"$i
fileName2=${fileName1/1.sanger/2.sanger}

echo "$fileName1	$fileName2	Sample	Sample	Sample	1" >> Targets.txt
done
