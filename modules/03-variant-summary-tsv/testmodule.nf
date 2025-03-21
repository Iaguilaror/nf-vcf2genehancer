/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.intermediates_dir = params.results_dir = "test/results"

/* load workflows for testing env */
include { SUMMARY }    from './main.nf'

/* declare input channel for testing */
gh_variants_tsv = Channel.fromPath( "test/data/*.genehancer_variants.tsv" )

/* declare scripts channel for testing */
scripts_summary_variants = Channel.fromPath( "scripts/03-summary.R" )

workflow {

  SUMMARY ( gh_variants_tsv, scripts_summary_variants )
  
}
