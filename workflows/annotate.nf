include { INTERPROSCAN } from '../modules/local/interproscan/main'

workflow ANNOTATE {
    take:
    samplesheet

    main:
    ch_fasta_files = Channel.fromPath(samplesheet)
        .splitCsv(header:true, sep:',')
        .map { row -> 
            def meta = [id: row.id]
            def fasta = file(row.fasta)
            return [meta, fasta]
        }

    INTERPROSCAN(
        ch_fasta_files
        )

    emit:
    INTERPROSCAN.out.tsv
    INTERPROSCAN.out.xml
    INTERPROSCAN.out.gff3
    INTERPROSCAN.out.json
    INTERPROSCAN.out.versions
}