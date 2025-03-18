# 01a-gff2bed: GFF3 to BED Conversion Module
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** March 2025  

---

## Module description:  

A (DSL2) Nextflow module to convert GFF3-formatted genomic annotation files into BED format. This conversion facilitates compatibility with tools that require BED-formatted genomic features.

## Module Dependencies:
| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [R](https://www.r-project.org/) | 4.4.3 | Rscript |

# R packages required:

```
dplyr version: 1.1.4
vroom version: 1.6.5
stringr version: 1.5.1
```

### Input(s):

- **GFF3 File**: A genomic annotation file in GFF3 format.

Example contents  
```
#chrom  source  feature name    start   end     score   strand  frame   attributes
chr22   GeneHancer      Promoter/Enhancer       46589987        46595001        1.36    .       .       genehancer_id=GH22J046589;connected_gene=GRAMD4;score=12.78;connected_gene=TBC1D22A;score=4.32;connected_gene=CERK;score=2.47;connected_gene=MK280393;score=0.45;connected_gene=AB372664-001;score=0.41;connected_gene=lnc-CDPF1-1;score=0.16;connected_gene=RF00017-3912;score=0.05
...

```

### Outputs

- **BED File**: The converted genomic features in BED format.

Example contents  
```
chr22   46589987        46595001        Promoter/Enhancer;GH22J046589;connected_gene=GRAMD4;score=12.78;connected_gene=TBC1D22A;score=4.32;connected_gene=CERK;score=2.47;connected_gene=MK280393;score=0.45;connected_gene=AB372664-001;score=0.41;connected_gene=lnc-CDPF1-1;score=0.16;connected_gene=RF00017-3912;score=0.05
...

```

## Module parameters:

| --param | example  | description |
|:---------:|:--------:|:-------------------:|
| --input_gff | "test/data/sample.gff" | the gff file downloaded from [https://www.genecards.org/Guide/Datasets](https://www.genecards.org/Guide/Datasets) |

## Testing the module:

* Estimated test time:  **1 minute(s)**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
01a-gff2bed/                    ## Nextflow script with the main process. To be imported by the full pipeline 
├── main.nf
├── readme.md                   ## This document
├── scripts -> ../../scripts    ## Directory with scripts and binaries to run this module
├── test                        ## Directory with materials for test
│   ├── results                 ## This dir will be created after runing the test
│   └── data
│       └── sample.gff
├── testmodule.nf               ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh               ## A quick bash script to run the whole test
````

## References
* [Fishilevich S, Nudel R, Rappaport N, Hadar R, Plaschkes I, Iny Stein T, et al. GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database (Oxford). 2017;2017.](https://doi.org/10.1093/database/bax028)

*DISCLAIMER: this readme was partially created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  
