#! /usr/bin/env nextflow

include { GENERATE_GENOME } from './modules/generate_genome'
include { RUN_FASTQC } from "./modules/run_fastqc"
include { RUN_MULTIQC } from "./modules/run_multiqc"
include { ALIGN_STAR } from './modules/align_star'
include { COUNT_EXONS } from './modules/count_exons'


workflow {

    // 0. Generate a STAR genome with relevant FASTA
    star_genome_ch = GENERATE_GENOME(params.fasta, params.gtf)

    read_pairs_ch = Channel.fromFilePairs(params.reads, checkIfExists: true)
        // .view()
        // [SRR2244213, [/vast/scratch/users/lee.sa/SRP063355/fastq/SRR2244213_1.fastq, /vast/scratch/users/lee.sa/SRP063355/fastq/SRR2244213_2.fastq]]

    fastqc_ch = RUN_FASTQC(read_pairs_ch)
    

    multiqc_ch = RUN_MULTIQC(fastqc_ch.collect())
    

    aligned_ch = ALIGN_STAR(read_pairs_ch, star_genome_ch)
    //     tuple( // output... 
    //     path("${sample}_Aligned.sortedByCoord.out.bam"),
    //     path("${sample}_Log.out"),
    //     path("${sample}_Log.final.out")
    // )

    counts_ch = COUNT_EXONS(
        aligned_ch.map( { it[0] } ).collect(), // map pulls the first val of the tuple
        file(params.gtf_count, checkIfExists: true),
        params.gtf_featureType, // "exon"
        params.gtf_attr // "exon_id"
        )

}

workflow.onComplete {
    log.info( 
        workflow.success ? 
        "Pipeline Complete!\n" : 
        "Pipeline Failed.\n" )
}