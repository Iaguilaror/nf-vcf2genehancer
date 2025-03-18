# 04-gene-summary-tsv: Genehancer affected Genes Summary module

**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** March 2025  

---

## Module description:  

A (DSL2) Nextflow module to generate a gene-centric summary of variant associations within Genehancer regulatory regions.

## Module Dependencies:
| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [R](https://www.r-project.org/) | 4.4.3 | Rscript |

# R packages required:

```
tidyr version: 1.3.1
dplyr version: 1.1.4
vroom version: 1.6.5
stringr version: 1.5.1
```

### Input(s):

- **TSV File**: *.genehancer_variants.tsv tab separated file with coordinates of the affeted Genehancer and the variant affecting it, by row.

Example contents  
```
chr22   46589987        46595001        Promoter/Enhancer;GH22J046589;connected_gene=GRAMD4;score=12.78;connected_gene=TBC1D22A;score=4.32;connected_gene=CERK;score=2.47;connected_gene=MK280393;score=0.45;connected_gene=AB372664-001;score=0.41;connected_gene=lnc-CDPF1-1;score=0.16;connected_gene=RF00017-3912;score=0.05  chr22   46590020        G       A
...

```

### Outputs

- **TSV File**: *.gene_summary.tsv tab separated file with a summary of the affected Genes, the list of affected Genehancer ids (GHids), and other values.

Example contents  
```
connected_genes var_per_regulatory_kb   n_variants_gene total_regulatory_size   n_affected_GHid n_GHids all_GHids       affected_GHids  all_variants
RF00952-013     33.8983050847458        2       59      1       1       GH22J022664     GH22J022664     chr22-22664404-A-G;chr22-22664437-A-G
lnc-GGTLC2-2    33.8983050847458        2       59      1       1       GH22J022664     GH22J022664     chr22-22664404-A-G;chr22-22664437-A-G
...

```

## Module parameters:

NONE  

## Testing the module:

* Estimated test time:  **1 minute(s)**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
04-gene-summary-tsv/          
├── main.nf                     ## Nextflow script with the main process. To be imported by the full pipeline 
├── readme.md                   ## This document
├── test                        ## Directory with materials for test
│   ├── data
│   │   └──  *.genehancer_variants.tsv ## file with coordinates of the affeted Genehancer + variant.
│   └── results                 ## This dir will be created after runing the test
├── testmodule.nf               ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh               ## A quick bash script to run the whole test
````

## References
* NONE

*DISCLAIMER: this readme was partially created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  
