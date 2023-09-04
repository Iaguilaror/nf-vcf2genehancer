/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process summary {

	publishDir "${params.results_dir}/02-variant-summary-tsv/", mode:"copyNoFollow"

  input:
    path TSV
    path SCRIPT

  output:
    path "*", emit: summary_results

  script:
  """
  Rscript --vanilla $SCRIPT $TSV
  """

}

/* name a flow for easy import */
workflow SUMMARY {

  take:
  gh_variants_tsv
  scripts_summary_variants

  main:

  summary( gh_variants_tsv, scripts_summary_variants )
  
  emit:
    summary.out[0]

}
