process COUNT_EXONS {
    //  TODO:
    cpus 24
    memory "48.G"
    time "8.h"
    // module "subread/1.6.3"
    container 'quay.io/biocontainers/bioconductor-rsubread:2.12.0--r42hc0cfd56_0'
    publishDir "results/${params.project}/counts", mode: 'copy' // default mode would be tosymlink the files 

    input:
    path(bams)
    path(gtf) // star genome dir
    val(gtf_featureType) // "feature type or types used to select rows in the GTF annotation"
    val(gtf_attr) // what feature in the gtf to count (~rownames)

    output:
    path(output)

    script:
    output="featureCounts_${gtf_featureType}_${gtf_attr}.rds"
    """
    featureCounts.R $gtf $gtf_featureType $gtf_attr $output $task.cpus $bams

    """


}
