args <- commandArgs(TRUE)

genome <- args[1]
inputFile <- args[2]
pdfFileName <- args[3]

if(genome == "hg19"){

	library(BSgenome.Hsapiens.UCSC.hg19)
	chr1_length <- seqlengths(Hsapiens)[["chr1"]]
    Organism <- Hsapiens	


}else if (genome == "mm9"){

	library(BSgenome.Mmusculus.UCSC.mm9)
	chr1_length <- seqlengths(Mmusculus)[["chr1"]] 
	Organism <- Mmusculus
}

library(Rsamtools)
param <- ScanBamParam(which=GRanges("chr1", IRanges(1, chr1_length)))
library(GenomicAlignments)

bamfiles <- read.table(inputFile,sep="\t",header=T)

SampleName <- bamfiles[,1]
aln <- lapply(as.character(bamfiles[,2]), readGAlignments, param=param)

makewindows <- function(chr, windowSize, organism)
    {
	
#	if (organism == "Hsapiens"){
#		require(BSgenome.Hsapiens.UCSC.hg19)
#	} else if (organism == "Mmusculus"){
#
#		require(BSgenome.Mmusculus.UCSC.mm9)
#	}
    wstart <- seq(1,seqlengths(organism)[[chr]] - windowSize, windowSize)
    windows <- GRanges(chr, IRanges(wstart, wstart+(windowSize-1)))
    return(windows)
}

makewindowsMy <- function(chr, chrSize,windowSize)
    {
    wstart <- seq(1,chrSize - windowSize, windowSize)
    windows <- GRanges(chr, IRanges(wstart, wstart+(windowSize-1)))
    return(windows)
    }

 
windows <- makewindows(chr="chr1", windowSize = 10000, organism=Organism)
 
# generate counts
counts <- lapply(aln, GenomicRanges::countOverlaps, query=windows)
names(counts) <- SampleName

sapply(counts, length)

library(gplots)
library(RColorBrewer)

pdf(file=pdfFileName)
pairs(do.call("cbind",counts), col=rgb(0,100,0,50,maxColorValue=255), pch=16, log="xy" )

corResult<-cor(do.call("cbind",counts))
corResult<- round(corResult,digit=2)

heatmap.2(corResult,cellnote=corResult,notecol="black",margins=c(5,5),keysize=0.9,density.info="none",trace="none",dendrogram="row",Colv="NA",col=brewer.pal(8,"GnBu"),cexRow =0.6,cexCol=0.6)
dev.off()
