# nf_rnaseq_exonAnalysis

How to use

1. Download the SRA fastq files of interest using nfcore-fetchings
2. Using parameters.config as a template make a new version of this file

```
params {

    fasta = "/vast/scratch/users/lee.sa/ensembl108/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
    star_genome = "/vast/scratch/users/lee.sa/star_genome"
    

    gtf = "/vast/scratch/users/lee.sa/ensembl108/Homo_sapiens.GRCh38.108.chr.gtf"
    gtf_attr = "exon_id"
    gtf_featureType = "exon"

    project = "SRP063355" // subfolder for results
    reads = "/vast/scratch/users/lee.sa/${project}/fastq/SRR*_{1,2}.fastq"   
    
}
```

3. Run nextflow as below

```
nextflow run main.nf -c <myparams.config> --resume
```
