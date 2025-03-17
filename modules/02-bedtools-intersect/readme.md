*DISCLAIMER: this readme was created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  
  
# 02-bedtools-intersect: Intersecting Genomic Features with BEDTools

## Module Overview

The `02-bedtools-intersect` module in the `nf-vcf2genehancer` pipeline utilizes BEDTools' `intersect` function to identify overlapping regions between genomic features. This process is crucial for analyzing the intersection between genetic variants and annotated genomic regions.

## Key Components

- **`main.nf`**: The primary Nextflow script orchestrating the intersection process.
- **`test/`**: Directory containing test data to validate the module's functionality.

## Intersection Process

This module employs BEDTools' `intersect` function to compare two sets of genomic features, identifying overlapping regions. The process involves:

1. Reading input BED and VCF files.
2. Executing the `bedtools intersect` command with appropriate options to find overlaps.
3. Outputting the intersected regions for downstream analysis.

For more details on BEDTools' `intersect` function, refer to the [official documentation](https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html).

## Inputs

- **BED File**: A file containing genomic features in BED format.
- **VCF File**: A file containing variant calls in VCF format.

## Outputs

- **TSV File**: A tab-separated file listing the intersected genomic regions.

## Usage

To use this module within the `nf-vcf2genehancer` pipeline, specify your BED and VCF files in the pipeline parameters. The module will process these files to identify overlapping regions and produce a TSV file in the specified output directory.

## Dependencies

Ensure that BEDTools is installed and accessible in your environment. For installation instructions and more information, visit the [BEDTools documentation](https://bedtools.readthedocs.io/).

## Example Command

This module is executed as part of the Nextflow pipeline. Ensure your `nextflow.config` is correctly set up to provide the required input files.

```bash
nextflow run nf-vcf2genehancer -entry bedtools_intersect --bed input.bed --vcf input.vcf --outdir results/
