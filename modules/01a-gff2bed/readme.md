''DISCLAIMER: this readme was created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  ''

# 01a-gff2bed: GFF3 to BED Conversion Module

## Module Overview

The `01a-gff2bed` module in the `nf-vcf2genehancer` pipeline converts GFF3-formatted genomic annotation files into BED format. This conversion facilitates compatibility with tools that require BED-formatted genomic features.

## Key Components

- **`main.nf`**: The primary Nextflow script orchestrating the conversion process.
- **`scripts/`**: Directory containing auxiliary scripts utilized during the conversion.
- **`test/`**: Directory with test data or scripts to validate the module's functionality.

## Conversion Process

This module extracts relevant genomic features from a GFF3 file and reformats them into BED format. The conversion ensures accurate representation of features, enabling downstream analyses requiring BED input.

## Inputs

- **GFF3 File**: A genomic annotation file in GFF3 format.

## Outputs

- **BED File**: The converted genomic features in BED format.

## Usage

To use this module within the `nf-vcf2genehancer` pipeline, specify your GFF3 file in the pipeline parameters. The module will process the file and generate a corresponding BED file in the output directory.

## Dependencies

Ensure that the required dependencies and environment configurations are met for successful execution.

## Example Command

This module is executed as part of the Nextflow pipeline. Ensure your `nextflow.config` is correctly set up to provide the required input files.

```bash
nextflow run nf-vcf2genehancer -entry gff2bed --gff3 input.gff3 --outdir results/
