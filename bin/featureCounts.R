#! /usr/bin/env Rscript

library(Rsubread)

args <- commandArgs(trailingOnly = TRUE)

gtf <- args[1]
gtf_featureType <- args[2]
gtf_attr <- args[3]
out <- args[4]
cpus <- args[5]
fls <- args[6:length(args)]


  myCounts <- Rsubread::featureCounts(
    fls,
    # annotation
    annot.ext = gtf,
    isGTFAnnotationFile = TRUE,
    GTF.featureType = gtf_featureType,
    GTF.attrType = gtf_attr,
    # summarization
    useMetaFeatures = FALSE,
    # overlaps
    allowMultiOverlap = TRUE,
    # paired end
    isPairedEnd = TRUE,
    # cpus
    nthreads = cpus
    
  )

  saveRDS(myCounts, file = out)