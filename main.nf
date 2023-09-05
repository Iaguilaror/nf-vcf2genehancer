#!/usr/bin/env nextflow

/*================================================================
The AGUILAR LAB presents...
  The GeneHancer Variation pipeline
- A tool to summarize the changes detected in Enhancer / Promoter Elements of the Human Genome
==================================================================
Version: 0.0.1
Project repository: TBA
==================================================================
Authors:
- Bioinformatics Design
 Israel Aguilar-Ordonez (iaguilaror@gmail.com)
- Bioinformatics Development
 Israel Aguilar-Ordonez (iaguilaror@gmail.com)
- Nextflow Port
 Israel Aguilar-Ordonez (iaguilaror@gmail.com)

=============================
Pipeline Processes In Brief:
.
Pre-processing:
_01a_gff2bed

Core-processing:
_002_bedtools-intersect
_003_variant-summary-tsv
_004_gene-summary-tsv

Pos-processing


ENDING

================================================================*/

nextflow.enable.dsl = 2

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PREPARE PARAMS DOCUMENTATION AND FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
params.ver = "0.0.1"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
params.pipeline_name = "nf-vcf2genehancer"

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by iaguilar at JAN 2023
*/
params.nextflow_required_version = '22.10.4'

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.help     = false   //default is false to not trigger help message automatically at every run
params.version  =	false   //default is false to not trigger version message automatically at every run

params.input_vcf  =  false	//if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.input_gff  =  false	//if no inputh path is provided, value is false to provoke the error during the parameter validation block

/* read the module with the param init and check */
include { } from './modules/doc_and_param_check.nf'

/* load functions for testing env */
include { get_fullParent }  from './modules/useful_functions.nf'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     INPUT PARAMETER VALIDATION BLOCK
  TODO (iaguilar) check the extension of input queries; see getExtension() at https://www.nextflow.io/docs/latest/script.html#check-file-attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/*
Output directory definition
Default value to create directory is the parent dir of --input_vcf
*/
params.output_dir = get_fullParent( params.input_vcf )

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script
  This directories will be automatically created by the pipeline to store files during the run
*/

params.results_dir =        "${params.output_dir}/${params.pipeline_name}-results/"
params.intermediates_dir =  "${params.output_dir}/${params.pipeline_name}-intermediate/"

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NAMED WORKFLOW FOR PIPELINE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/* load workflows */
include { GFF2BED }             from  './modules/01a-gff2bed'
include { BEDTOOLS_INTERSECT }  from  './modules/02-bedtools-intersect'
include { SUMMARY }             from  './modules/03-variant-summary-tsv'
include { GENE_SUMMARY }        from  './modules/04-gene-summary-tsv'

include { RECORDCONFIG }      from  './modules/Z-recordconfigs'

/* load scripts to send to workdirs */
/* declare scripts channel from modules */

scripts_gff2bed           = Channel.fromPath( "./scripts/01a-gff2bed.R" )
scripts_summary_variants  = Channel.fromPath( "./scripts/03-summary.R" )
scripts_summary_genes     = Channel.fromPath( "./scripts/04-summary-genes.R" )

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN ALL WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
// See: https://github.com/nf-core/rnaseq/issues/619
//

workflow {

  bed_custom        = GFF2BED ( scripts_gff2bed )

  variants_summary  = SUMMARY( bed_custom | BEDTOOLS_INTERSECT, scripts_summary_variants )

  GENE_SUMMARY ( variants_summary, bed_custom, scripts_summary_genes )

  /* declare input channel for recording configs */
  nfconfig = Channel.fromPath( "./nextflow.config" )
  RECORDCONFIG( nfconfig )

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/