process ALIGN_STAR {
    //  TODO:
    cpus 8
    memory "48.G"
    time "2.h"
    module "STAR/2.7.3a"
    tag "$sample"
    publishDir "results/${params.project}/aligned"
    mode "copy"

    input:
    tuple val(sample), path(reads)
    path(genome_dir) // star genome dir


    output:
    // path(output)
    tuple(
        path("${sample}_Aligned.sortedByCoord.out.bam"),
        path("${sample}_Log.out"),
        path("${sample}_Log.final.out")
    )
    // tuple val(sample), path(output) 


    script:
    output = "${sample}_Aligned.sortedByCoord.out.bam"
    """
    STAR --genomeDir $genome_dir \
         --runThreadN $task.cpus \
         --readFilesIn ${reads[0]} ${reads[1]} \
         --outSAMtype BAM SortedByCoordinate \
         --readFilesCommand zcat \
         --outFileNamePrefix ${sample}_

    """
}