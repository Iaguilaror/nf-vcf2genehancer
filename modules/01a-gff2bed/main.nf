/* Inititate DSL2 */
nextflow.enable.dsl=2

/* Define the main processes */
process gff2bed {

	publishDir "${params.results_dir}/01a-gff2bed/", mode:"symlink"

    input:
        path GFF
        path SCRIPT

    output:
        path "*.bed", emit: gff2bed_results

  script:
  """
  Rscript --vanilla $SCRIPT $GFF
  """

}

/* name a flow for easy import */
workflow GFF2BED {

  take:
    scripts_gff2bed

  main:

    gff_channel = Channel.fromPath ( "${params.input_gff}" )
    gff2bed( gff_channel, scripts_gff2bed )
 
  emit:
    gff2bed.out[0]

}
