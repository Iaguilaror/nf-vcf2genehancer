/* Inititate DSL2 */
nextflow.enable.dsl=2

/* load functions for testing env */
// NONE

/* define the fullpath for the final location of the outs */
params.intermediates_dir = params.results_dir = "test/results"

/* load workflows for testing env */
include { GFF2BED }    from './main.nf'

/* declare input channel for testing */
// NONE

/* declare scripts channel for testing */
scripts_gff2bed = Channel.fromPath( "scripts/01a-gff2bed.R" )

workflow {
  GFF2BED ( scripts_gff2bed )
}