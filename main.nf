include { ANNOTATE } from './workflows/annotate'

workflow {
    ANNOTATE (
        params.samplesheet
        )
}