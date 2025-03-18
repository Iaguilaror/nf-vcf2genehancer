# 03-variant-summary-tsv: Variant Summary associated with GeneHancer regions module

**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** March 2025  

---

## Module description:  

A (DSL2) Nextflow module to summarize the information by aggregating variants and extracting gene connectivity details.

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

- **TSV File**: *.genehancer_variants_summary.tsv tab separated file with a summary of the affected Genehancer, the list of affected genes, and other values.

Example contents  
```
n_connected_genes       n_variants      var_per_kb      gh_length       gh_chr  gh_start        gh_end  gh_feature_name GHid    connected_genes all_variants
6       2       64.5161290322581        31      chr22   27617961        27617992        Enhancer        GH22J027617     MN1;ENSG00000224027;piR-43106-224;HSALNG0147387;lnc-MN1-12;CRYBB1        chr22-27617987-TAG-T;chr22-27617989-G-T,GTTTTTTT
6       6       40.2684563758389        149     chr22   19873598        19873747        Enhancer        GH22J019873     TXNRD2;RPL8P5;HSALNG0134066;lnc-TBX1-2;GNB1L;LOC124905081        chr22-19873604-T-C;chr22-19873634-A-G;chr22-19873638-C-T;chr22-19873646-G-C;chr22-19873676-G-T;chr22-19873703-T-C
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
03-variant-summary-tsv/          
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
