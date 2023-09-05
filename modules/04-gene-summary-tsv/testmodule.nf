/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.intermediates_dir = params.results_dir = "test/results"

/* load workflows for testing env */
include { GENE_SUMMARY }    from './main.nf'

/* declare input channel for testing */
variants_summary = Channel.fromPath( "test/data/*.genehancer_variants_summary.tsv" )
bed_custom = Channel.fromPath( "test/sample_custom.bed" )

/* declare scripts channel for testing */
scripts_summary_genes = Channel.fromPath( "scripts/04-summary-genes.R" )

workflow {

  GENE_SUMMARY ( variants_summary, bed_custom, scripts_summary_genes )
  
}
