/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process rename {

	publishDir "${params.results_dir}/a-rename/", mode:"copyNoFollow"

    input:
        path MATERIALS

    output:
        path "*.renamed.vcf", emit: rename_results

  script:
  """
  # find vcf name
  the_vcf=\$( basename *.vcf .vcf)
  bcftools annotate \
		--rename-chrs $MATERIALS \
    | bcftools annotate -x ID,QUAL,FILTER,INFO,FORMAT | cut -f1-8 > "\$the_vcf.renamed.vcf"
  """

}

process get_snps {

	publishDir "${params.results_dir}/a-rename/", mode:"copyNoFollow"

    input:
        path VCF

    output:
        path "*.snps.vcf.gz", emit: get_snps_results

  script:
  """
  # find vcf name
  the_vcf=\$( basename $VCF .vcf)
  bcftools view --type snps $VCF | bgzip > \$the_vcf".snps.vcf.gz"
  """

}

process get_indels {

	publishDir "${params.results_dir}/a-rename/", mode:"copyNoFollow"

    input:
        path VCF

    output:
        path "*.indels.vcf.gz", emit: get_indels_results

  script:
  """
  # find vcf name
  the_vcf=\$( basename $VCF .vcf)
  bcftools view --type indels $VCF | bgzip > \$the_vcf".indels.vcf.gz"
  """

}

/* name a flow for easy import */
workflow RENAME {

  main:

    synonyms_channel = Channel.fromPath ( "${params.input_synonyms}" )
    vcf_channel = Channel.fromPath ( "${params.input_dir}/*.vcf" )

    allvcf = synonyms_channel
    .combine( vcf_channel )
    | rename

    get_snps( allvcf )
    get_indels( allvcf )
 
  emit:
    rename.out[0]

}
