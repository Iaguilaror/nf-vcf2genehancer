# nf-vcf2genehancer
NF pipeline to annotate and summarize VCF variants with GeneHancer Regulatory Regions

===  

- A tool to summarize the changes detected in Enhancer / Promoter Elements of the Human Genome

- This pipeline is meant to reproduce the results in: [Miron-Toruno, F., et al. "Genome-wide selection scans in Mexican Indigenous populations reveal recent signatures of pathogen and diet adaptation." Genome Biology and Evolution (2025): evaf043.](https://doi.org/10.1093/gbe/evaf043)

The pipeline takes as INPUT a VCF file, and GFF file with the GeneHancer database downloaded from [https://www.genecards.org/Guide/Datasets](https://www.genecards.org/Guide/Datasets) to annotate variants. The end result are two TSV files, one to summarize variantions by GeneHancer-id, the other to summarize variants by gene (grouping the variation in all of its enhancer and/or promoters).

---

### Features
  **-v 0.0.1**

* The Genehancer gff file must be previously downloaded from [https://www.genecards.org/Guide/Datasets](https://www.genecards.org/Guide/Datasets)
* Supports VCF ##fileformat=VCFv4.2
* Results include TSV files summarizing variation
* Scalability and reproducibility via a Nextflow-based framework   

---

## Requirements
#### Compatible OS*:
* [Ubuntu 22.04.4 LTS](https://releases.ubuntu.com/focal/)

#### Incompatible OS*:
* UNKNOWN  

\* nf-vcf2genehancer may run in other UNIX based OS and versions, but testing is required.  

#### Command line Software required:
| Requirement | Version  | Required Commands * |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [R](https://www.r-project.org/) | 4.4.3 | Rscript |
| [bedtools](https://bedtools.readthedocs.io/en/latest/) | v2.31.1 | bedtools intersect |

\* These commands must be accessible from your `$PATH` (*i.e.* you should be able to invoke them from your command line).  

#### R packages required:

```
dplyr version: >= 1.1.4
vroom version: >= 1.6.5
stringr version: >= 1.5.1
tidyr version: >= 1.3.1
```

---

### Installation
Download pipeline from Github repository:  
```
git clone git@github.com:Iaguilaror/nf-vcf2genehancer.git
```

---

## Testing the pipeline:

* Estimated test time:  **3 minute(s)**  

1. To test pipeline execution using test data, run:  
```
./runtest.sh
```

2. Your console should print the Nextflow log for the run, once every process has been submitted, the following message will appear:  
```
======
 Basic pipeline TEST SUCCESSFUL
======
```

3. Pipeline results for test data should be in the following directory:  
```
./test/results/
```
---


### Pipeline Inputs

- **VCF File**: Variant file file in VCF format. The only required fields are #CHROM  POS (probably also REF     ALT but needs testing)

Example contents  
```
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   10515040        .       TAAGA   T,TAAGAAAGA     .       .       .
chr22   10515072        .       AAAG    A       .       .       .
...

```

- **GFF3 File**: A genomic annotation file in GFF3 format.

Example contents  
```
#chrom  source  feature name    start   end     score   strand  frame   attributes
chr22   GeneHancer      Promoter/Enhancer       46589987        46595001        1.36    .       .       genehancer_id=GH22J046589;connected_gene=GRAMD4;score=12.78;connected_gene=TBC1D22A;score=4.32;connected_gene=CERK;score=2.47;connected_gene=MK280393;score=0.45;connected_gene=AB372664-001;score=0.41;connected_gene=lnc-CDPF1-1;score=0.16;connected_gene=RF00017-3912;score=0.05
...

```

### Pipeline Results

Inside the directory test/results/nf-vcf2genehancer-results/ you can find the following:

````
1) 03-variant-summary-tsv/*.genehancer_variants_summary.tsv   # tab separated file with a summary of the affected Genehancer, the list of affected genes, and other values.
2) 04-gene-summary-tsv/*.gene_summary.tsv                     # tab separated file with coordinates of the affected Genehancer and the variant affecting it, by row.
````
- **TSV File**: *.genehancer_variants_summary.tsv tab separated file with a summary of the affected Genehancer, the list of affected genes, and other values.

Example contents  
```
n_connected_genes       n_variants      var_per_kb      gh_length       gh_chr  gh_start        gh_end  gh_feature_name GHid    connected_genes all_variants
6       2       64.5161290322581        31      chr22   27617961        27617992        Enhancer        GH22J027617     MN1;ENSG00000224027;piR-43106-224;HSALNG0147387;lnc-MN1-12;CRYBB1        chr22-27617987-TAG-T;chr22-27617989-G-T,GTTTTTTT
6       6       40.2684563758389        149     chr22   19873598        19873747        Enhancer        GH22J019873     TXNRD2;RPL8P5;HSALNG0134066;lnc-TBX1-2;GNB1L;LOC124905081        chr22-19873604-T-C;chr22-19873634-A-G;chr22-19873638-C-T;chr22-19873646-G-C;chr22-19873676-G-T;chr22-19873703-T-C
...

```
- **TSV File**: *.gene_summary.tsv tab separated file with a summary of the affected Genes, the list of affected Genehancer ids (GHids), and other values.

Example contents  
```
connected_genes var_per_regulatory_kb   n_variants_gene total_regulatory_size   n_affected_GHid n_GHids all_GHids       affected_GHids  all_variants
RF00952-013     33.8983050847458        2       59      1       1       GH22J022664     GH22J022664     chr22-22664404-A-G;chr22-22664437-A-G
lnc-GGTLC2-2    33.8983050847458        2       59      1       1       GH22J022664     GH22J022664     chr22-22664404-A-G;chr22-22664437-A-G
...

```


---

### module directory structure

````
.
├── main.nf         # the Nextflow main script
├── modules/        # sub-dirs for development of the Nextflow modules
├── README.md       # This readme
├── runtest.sh      # bash script to launch the pipeline test locally
├── scripts/        # directory with all the scripts used by the pipeline
└── test
    └── data       # sample data to run this pipeline
    └── reference  # sample survey data completion to test this pipeline

````
## REPLICATE our analysis:

* SETUP  
**Make sure you have downloaded the Genehancer GFF file and save it as**  
  ```
  ./real-data/GH_v5.17/GeneHancer_v5.17.gff
  ```

To get the summary of variants in Genehancer reported in our [paper](https://doi.org/10.1093/gbe/evaf043) you need to execute each of the launcher scripts in ./launchers/ like this: 
```
bash launchers/central.sh `
```

The 3 launchers are:

````
launchers/
├── central.sh         
├── north.sh        
└── south.sh
````
 
---
### References
Under the hood Proteomic compare uses some coding tools, please include the following ciations in your work:

* [Fishilevich S, Nudel R, Rappaport N, Hadar R, Plaschkes I, Iny Stein T, et al. GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database (Oxford). 2017;2017.](https://doi.org/10.1093/database/bax028)

* [Quinlan, Aaron R., and Ira M. Hall. "BEDTools: a flexible suite of utilities for comparing genomic features." Bioinformatics 26.6 (2010): 841-842.](https://doi.org/10.1093/bioinformatics/btq033)

---

### Contact
If you have questions, requests, or bugs to report, open an issue in github, or email <iaguilaror@gmail.com>

### Dev Team
Israel Aguilar-Ordonez <iaguilaror@gmail.com>   

### Cite us
- If this pipeline wasof any help for your academic work, please cite the following:  

  [Miron-Toruno, F., et al. "Genome-wide selection scans in Mexican Indigenous populations reveal recent signatures of pathogen and diet adaptation." Genome Biology and Evolution (2025): evaf043.](https://doi.org/10.1093/gbe/evaf043)

