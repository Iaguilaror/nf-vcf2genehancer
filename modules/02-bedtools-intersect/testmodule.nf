/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.intermediates_dir = params.results_dir = "test/results"

/* load workflows for testing env */
include { BEDTOOLS_INTERSECT }    from './main.nf'

/* declare input channel for testing */
bed_custom = Channel.fromPath( "test/data/sample_custom.bed" )

/* declare scripts channel for testing */
// NONE

workflow {

  BEDTOOLS_INTERSECT ( bed_custom )
  
}
