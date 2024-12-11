process INTERPROSCAN {
    tag "$meta.id"
    label 'process_medium'
    label 'process_long'

    input:
    tuple val(meta), path(fasta)

    output:
    tuple val(meta), path('*.tsv') , optional: true, emit: tsv
    tuple val(meta), path('*.xml') , optional: true, emit: xml
    tuple val(meta), path('*.gff3'), optional: true, emit: gff3
    tuple val(meta), path('*.json'), optional: true, emit: json
    path "versions.yml"            , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: params.interproscan.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def is_compressed = fasta.name.endsWith(".gz")
    """
    if ${is_compressed} ; then
        zcat ${fasta} |  sed 's/\\*/x/g' > input.fa
    else
        sed 's/\\*/x/g' ${fasta} > input.fa
    fi

    ${params.interproscan.script} \\
        --cpu ${task.cpus} \\
        --input input.fa \\
        ${args} \\
        --output-file-base ${prefix}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        interproscan: \$( ${params.interproscan.script} --version | sed '1!d; s/.*version //' )
    END_VERSIONS
    """

    stub:
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}.{tsv,xml,json,gff3}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        interproscan: \$( ${params.interproscan.script} --version | sed '1!d; s/.*version //' )
    END_VERSIONS
    """
}