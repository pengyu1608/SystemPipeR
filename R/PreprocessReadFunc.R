library(ShortRead)

myPreprocessReads <- function (args, Fct, batchsize = 1e+05, overwrite = TRUE, ...)

{

    if (class(Fct) != "character")
        stop("Argument 'Fct' needs to be of class character")
    if (!all(c("FileName1", "FileName2") %in% colnames(args))) {
        for (i in seq(along = nrow(args))) {
            outfile <- as.character(args$outFileName1[i])
            if (overwrite == TRUE) {
                if (any(file.exists(outfile)))
                  unlink(outfile)
            }
            else {
                if (any(file.exists(outfile)))
                  stop(paste("File", outfile, "exists. Please delete file first or set overwrite=TRUE."))
            }
            counter <- 0
            f <- FastqStreamer(as.character(args$FileName1[i]), batchsize)
            while (length(fq <- yield(f))) {
                fqtrim <- eval(parse(text = Fct))
                writeFastq(fqtrim, outfile, mode = "a", ...)
                counter <- counter + length(fqtrim)
                cat(counter, "processed reads written to file:",
                  outfile, "\n")
            }
            close(f)
        }
    }
    if (all(c("FileName1", "FileName2") %in% colnames(args))) {
        for (i in seq(along = nrow(args))) {
            p1 <- as.character(args$FileName1[i])
            p2 <- as.character(args$FileName2[i])
            p1out <- as.character(args$outFileName1[i])
            p2out <- as.character(args$outFileName2[i])
            if (overwrite == TRUE) {
                if (any(file.exists(p1out)))
                  unlink(p1out)
                if (any(file.exists(p2out)))
                  unlink(p2out)
            }
            else {
                if (any(file.exists(p1out)))
                  stop(paste("File", p1out, "exists. Please delete file first or set overwrite=TRUE."))
                if (any(file.exists(p2out)))
                  stop(paste("File", p2out, "exists. Please delete file first or set overwrite=TRUE."))
            }
            counter1 <- 0
            counter2 <- 0
            f1 <- FastqStreamer(p1, batchsize)
            f2 <- FastqStreamer(p2, batchsize)
            while (length(fq1 <- yield(f1))) {
                fq2 <- yield(f2)
                if (length(fq1) != length(fq2))
                  stop("Paired end files cannot have different read numbers.")
                fq <- fq1
                fq1trim <- eval(parse(text = Fct))
                index1 <- as.character(id(fq1)) %in% as.character(id(fq1trim))
                names(index1) <- seq(along = index1)
                index1 <- names(index1[index1])
                fq <- fq2
                fq2trim <- eval(parse(text = Fct))
                index2 <- as.character(id(fq2)) %in% as.character(id(fq2trim))
                names(index2) <- seq(along = index2)
                index2 <- names(index2[index2])
                indexpair1 <- index1 %in% index2
                writeFastq(fq1trim[indexpair1], p1out, mode = "a",
                  ...)
                indexpair2 <- index2 %in% index1
                writeFastq(fq2trim[indexpair2], p2out, mode = "a",
                  ...)
                counter1 <- counter1 + sum(indexpair1)
                cat(counter1, "processed reads written to file:",
                  p1out, "\n")
                counter2 <- counter2 + sum(indexpair2)
                cat(counter2, "processed reads written to file:",
                  p2out, "\n")
            }
            close(f1)
            close(f2)
        }
    }
}


filterFct <- function(fq, cutoff) {
    qMean <- rowSums(as(quality(fq), "matrix"),na.rm=T)/width(fq)
	Ncount<-round(0.05*width(fq)[1]) #
    fq[nFilter(threshold=Ncount)(fq)]
	fq[qMean > cutoff] # Retains reads where mean Phred scores are >= cutoff
	
}

getGenomeIndex<-function(x){

	switch(x,hg19="/wa/zhenyisong/bringback/igenome/Homo_sapiens/UCSC/hg19/Sequence/WholeGenomeFasta/genome.fa",
			 mm9="/wa/zhenyisong/bringback/igenome/Mus_musculus/UCSC/mm9/Sequence/WholeGenomeFasta/mm9",
			 mm10="/wa/zhenyisong/bringback/igenome/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/mm10",
			 hg38="/wa/zhenyisong/bringback/igenome/Homo_sapiens/UCSC/hg38/hg38")

}


BamStat <- function (x){

        library("Rsubread")
        BamFiles <- list.files(pattern="*.bam$");
        propmapped(BamFiles[x])

}

