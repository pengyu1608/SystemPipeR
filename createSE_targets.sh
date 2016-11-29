Dir=`pwd`

echo  "FileName	SampleName	Factor	SampleLong	Experiment" >Targets.txt

for i in `ls *fastq`

do

fileName=$Dir"/"$i

echo "$fileName	Sample	Sample	Sample	1" >> Targets.txt
done
