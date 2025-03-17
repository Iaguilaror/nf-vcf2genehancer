*DISCLAIMER: this readme was created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  
  
# 04-gene-summary-tsv: Gene Summary Generation Module

## Module Overview

The `04-gene-summary-tsv` module in the `nf-vcf2genehancer` pipeline generates a summary of genes based on input genomic data. This module extracts gene-related information and organizes it into a structured TSV file, facilitating downstream analysis and interpretation.

## Key Components

- **`main.nf`**: The primary Nextflow script orchestrating the gene summary generation process.
- **`scripts/`**: Directory containing auxiliary scripts used for data processing.
- **`test/`**: Directory with test data and scripts to validate the module’s functionality.

## Summarization Process

This module processes input genomic data to extract relevant gene information. The workflow includes:

1. Reading input files containing gene-related annotations.
2. Extracting gene attributes such as gene names, identifiers, genomic coordinates, and functional annotations.
3. Compiling the extracted data into a structured TSV (Tab-Separated Values) format for easy interpretation and downstream analysis.

## Inputs

- **Annotation File**: A genomic annotation file (e.g., GFF3, BED) containing gene information.

## Outputs

- **TSV File**: A tab-separated values file summarizing the extracted gene information, including gene names, identifiers, genomic locations, and annotations.

## Usage

To use this module within the `nf-vcf2genehancer` pipeline, specify the input annotation file in the pipeline parameters. The module will process the file and generate a gene summary TSV file in the specified output directory.

## Dependencies

Ensure that all required dependencies and environment configurations are met for the successful execution of this module. This may include tools for parsing genomic annotation files.

## Example Command

This module is executed as part of the Nextflow pipeline. Ensure your `nextflow.config` is correctly set up to provide the required input files.

```bash
nextflow run nf-vcf2genehancer -entry gene_summary_tsv --annotation input.gff3 --outdir results/
