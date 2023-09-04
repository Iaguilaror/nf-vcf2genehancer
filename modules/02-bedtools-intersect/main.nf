/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process intersect {

	publishDir "${params.results_dir}/02-bedtools-intersect/", mode:"copyNoFollow"

  input:
    path BED
    path VCF

  output:
    path "*.tsv", emit: intersect_results

  script:
  """
  bedtools intersect \
    -wa -wb \
    -a $BED \
    -b $VCF \
  | cut -f1-6,8,9 \
  > $VCF".genehancer_variants.tsv"
  """

}

/* name a flow for easy import */
workflow BEDTOOLS_INTERSECT {

  take:
  bed_custom

  main:

  vcf_channel = Channel.fromPath ( "${params.input_vcf}" )

  intersect( bed_custom, vcf_channel )
  
  emit:
    intersect.out[0]

}
