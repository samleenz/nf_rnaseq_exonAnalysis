process GENERATE_GENOME {
    //  TODO:
    cpus 8
    memory "100.G"
    time "4.h"
    module "STAR/2.7.3a"
    storDir $params.star_genome

    input:
    path(fasta)
    path(gtf)


    output:
    path(output)
    // tuple val(sample), path(output) 


    script:
    output = "star_2.7.3a_index"
    """
    mkdir -p $output

    STAR --runMode genomeGenerate\
         --runThreadN $task.cpus \
         --genomeDir $output \
         --genomeFastaFiles $fasta \
         --sjdbGTFfile $gtf

    """
}