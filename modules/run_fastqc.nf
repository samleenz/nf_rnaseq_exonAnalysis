process RUN_FASTQC {
    //  TODO:
    cpus 2
    memory "2.G"
    time {"30.m" * task.attempt}
    module "fastqc/0.11.8"
    tag "$sample"


    // https://www.nextflow.io/docs/latest/process.html?highlight=retry#dynamic-computing-resources 
    errorStrategy { task.exitStatus in 137..140 ? 'retry' : 'terminate' }
    maxRetries 3
    

    input:
    tuple val(sample), path(reads) // 


    output:
    path(output)
    // tuple val(sample), path(output) 


    script:
    output = "${sample}_fastqc"
    // output_1="fastqc_reports/${sample}_1_fastqc.zip"
    """
    mkdir -p $output
    fastqc -o $output -t $task.cpus $reads

    """
}