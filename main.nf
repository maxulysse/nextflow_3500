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
    params.input = "input_s3.csv"

    Channel.fromPath(params.input)
    | splitCsv()
    | STAGE

    STAGE.out.txt | view
}