library(systemPipeR)
library(BiocParallel); library(BatchJobs)

BamStat <- function (x){

	library("Rsubread")	
	BamFiles <- list.files(pattern="*.bam$");
	propmapped(BamFiles[x])

}

BamFiles <- list.files(pattern="*.bam$");

funs <- makeClusterFunctionsSGE("/home/yupeng/program/R/SGE.tmpl")
param <- BatchJobsParam(length(args), resources=list(h_rt="20:00:00"), cluster.functions=funs)
register(param)

read_statsList <- bplapply(seq(along=BamFiles), BamStat)
read_statsDF <- do.call("rbind", read_statsList)
write.table(read_statsDF,file="BamSummary",sep="\t",row.names=F,quote=F)
	
