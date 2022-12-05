# nf_rnaseq_exonAnalysis

a WIP 😎 use at your own risk.. 

How to use

1. Download the SRA fastq files of interest using nfcore-fetchings
    
    1.1  Download accession list with SRA run selector (https://www.ncbi.nlm.nih.gov/Traces/study/)

```
# from dir /vast/projects/ncla/lupus_project

nextflow run nf-core/fetchngs --input "SRR_Acc_List_PRJNA293549.txt" --outdir data/PRJNA293549 -profile wehi -c sra_fastq_ftp.config -resume

# where sra_fasrq_gtp.config 
process {
    withName: SRA_FASTQ_FTP {
        maxForks = 10
    }
}
```

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
nextflow run samleenz/nf_rnaseq_exonAnalysis -c <myparams.config> -resume
```
