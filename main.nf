process STAGE {
    tag { reads }

    input:
    path(reads)

    output:
    path('*.txt'), emit: txt

    script:
    """
    touch ${reads.baseName}.txt
    """
}

workflow {
    params.input = "https://raw.githubusercontent.com/maxulysse/nextflow_3500/main/input_s3.csv"
    // params.input = "https://raw.githubusercontent.com/maxulysse/nextflow_3500/main/input_https.csv"

    Channel.fromPath(params.input)
    | splitCsv()
    | STAGE

    STAGE.out.txt | view
}