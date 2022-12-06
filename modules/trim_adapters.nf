process TRIM_ADAPTERS {
    //  TODO:
    cpus 4
    memory "24.G"
    time "1.h"
    container "quay.io/biocontainers/cutadapt:4.1--py310h1425a21_1"
    tag "$sample"

    input:
    tuple val(sample), path(reads)


    output:
    tuple val(sample), path("tr_*")
    // tuple val(sample), path(output) 


    script:
    """
    cutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG \
        -o tr_${reads[0]} \
        -p tr_${reads[1]} \
        tr_${reads[0]} \
        tr_${reads[1]}

    """
}