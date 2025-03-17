*DISCLAIMER: this readme was created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  
  
# 03-variant-summary-tsv: Variant Summary Generation Module

## Module Overview

The `03-variant-summary-tsv` module in the `nf-vcf2genehancer` pipeline is designed to generate a summary of genetic variants from VCF files. This summary provides essential insights into the variants, facilitating downstream analyses and interpretations.

## Key Components

- **`main.nf`**: The primary Nextflow script orchestrating the variant summarization process.
- **`scripts/`**: Directory containing auxiliary scripts utilized during the summarization.
- **`test/`**: Directory with test data or scripts to validate the module's functionality.

## Summarization Process

This module processes VCF files to extract pertinent information about genetic variants. The process involves:

1. Reading input VCF files containing variant data.
2. Extracting relevant variant information such as chromosome, position, reference and alternate alleles, quality scores, and annotations.
3. Compiling the extracted data into a structured TSV (Tab-Separated Values) format for easy interpretation and downstream analysis.

## Inputs

- **VCF File**: A file containing variant calls in VCF format.

## Outputs

- **TSV File**: A tab-separated file summarizing the variants, including details like chromosome, position, reference and alternate alleles, quality scores, and annotations.

## Usage

To use this module within the `nf-vcf2genehancer` pipeline, specify your VCF file in the pipeline parameters. The module will process the VCF file to generate a summary TSV file in the specified output directory.

## Dependencies

Ensure that all necessary dependencies and environment configurations are met for the successful execution of this module.

## Example Command

This module is executed as part of the Nextflow pipeline. Ensure your `nextflow.config` is correctly set up to provide the required input files.

```bash
nextflow run nf-vcf2genehancer -entry variant_summary_tsv --vcf input.vcf --outdir results/
