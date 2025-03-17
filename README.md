# nf-vcf2genehancer
Pipeline to visualize genomic variation in known enhancer/promoter elements in H. sapiens

# Prepare the GeneHancer Reference

Request the GeneHancer GFF file from  https://www.genecards.org/Guide/Datasets  

Use the GeneHancer .gff file as --input_gff for this pipeline.  

# nf-vcf2genehancer

Nextflow pipeline for intersecting genomic variants with regulatory elements (enhancers and promoters) in *Homo sapiens*.

---

## Overview

`nf-vcf2genehancer` is a bioinformatics pipeline designed to analyze genomic variants from VCF files and determine their overlap with known enhancer and promoter regions. This pipeline generates summary reports and visualizations to aid in the interpretation of genetic variations within regulatory elements.

---

## Features

- **VCF Intersections**: Identifies overlaps between genetic variants and enhancer/promoter regions.
- **Gene Summaries**: Generates summaries of genes associated with intersected enhancer/promoter regions.
- **Variant Summaries**: Provides detailed information on variants within enhancer/promoter regions.
- **Scalability and Reproducibility**: Built with Nextflow to ensure parallel execution and workflow reproducibility.
- **Docker Integration**: Facilitates easy deployment using containers.

---

## Requirements

### Compatible Operating Systems

- **Ubuntu 20.04.5 LTS**
- **Ubuntu 18.04.6 LTS**
- *Note:* The pipeline may function on other UNIX-based operating systems and versions, but testing is necessary to confirm compatibility.

### Required Software

- **Nextflow**: Version 22.10.4
- **BEDTools**: Version 2.30.0
- **R**: Version 4.2.2
- **Python**: Version 3.10.9

### Required R Packages

- **GenomicRanges**: Version 1.46.1
- **rtracklayer**: Version 1.54.0
- **dplyr**: Version 1.1.0
- **ggplot2**: Version 3.4.0
- **rmarkdown**: Version 2.20

### Required Python Packages

- **pandas**: Version 1.5.3
- **numpy**: Version 1.24.2
- **plotly**: Version 5.13.0
- **kaleido**: Version 0.2.1

---

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Iaguilaror/nf-vcf2genehancer.git
   cd nf-vcf2genehancer
