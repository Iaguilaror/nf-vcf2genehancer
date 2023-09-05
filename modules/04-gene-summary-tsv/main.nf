/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process gene_summary {

	publishDir "${params.results_dir}/04-gene-summary-tsv/", mode:"copyNoFollow"

  input:
    path TSV
    path BED
    path SCRIPT

  output:
    path "*", emit: gene_summary_results

  script:
  """
  Rscript --vanilla $SCRIPT $TSV $BED
  """

}

/* name a flow for easy import */
workflow GENE_SUMMARY {

  take:
  variants_summary
  bed_custom
  scripts_summary_genes

  main:

  gene_summary( variants_summary, bed_custom, scripts_summary_genes )
  
  emit:
    gene_summary.out[0]

}
