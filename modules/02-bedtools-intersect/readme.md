# 02-bedtools-intersect: Intersecting Genomic Features with BEDTools
**Author(s):**

* Israel Aguilar-Ordoñez (iaguilaror@gmail.com)

**Date:** March 2025  

---

## Module description:  

A (DSL2) Nextflow module to identify overlapping regions between variants in a VCF file and annotated genomic regions in a BED.

## Module Dependencies:
| Requirement | Version  | Required Commands |
|:---------:|:--------:|:-------------------:|
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 22.10.4 | nextflow |
| [bedtools](https://bedtools.readthedocs.io/en/latest/) | v2.31.1 | bedtools intersect |

### Input(s):

- **VCF File**: Variant file file in VCF format. The only required fields are #CHROM  POS (probably also REF     ALT but needs testing)

Example contents  
```
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   10515040        .       TAAGA   T,TAAGAAAGA     .       .       .
chr22   10515072        .       AAAG    A       .       .       .
...

```

### Outputs

- **TSV File**: *.genehancer_variants.tsv tab separated file with coordinates of the affeted Genehancer and the variant affecting it, by row.

Example contents  
```
chr22   46589987        46595001        Promoter/Enhancer;GH22J046589;connected_gene=GRAMD4;score=12.78;connected_gene=TBC1D22A;score=4.32;connected_gene=CERK;score=2.47;connected_gene=MK280393;score=0.45;connected_gene=AB372664-001;score=0.41;connected_gene=lnc-CDPF1-1;score=0.16;connected_gene=RF00017-3912;score=0.05  chr22   46590020        G       A
...

```

## Module parameters:

| --param | example  | description |
|:---------:|:--------:|:-------------------:|
| --input_vcf | "test/data/samplechr22.vcf.gz" | a VCf file you want to annotate with Genehancer |

## Testing the module:

* Estimated test time:  **1 minute(s)**  

1. Test this module locally by running,
```
bash testmodule.sh
```

2.`[>>>] Module Test Successful` should be printed in the console.  

## module directory structure

````
02-bedtools-intersect/          
├── main.nf                     ## Nextflow script with the main process. To be imported by the full pipeline 
├── readme.md                   ## This document
├── test                        ## Directory with materials for test
│   └── data
│   │   ├── samplechr22.vcf.gz  ## VCF file to be annotated
│   │   └── sample_custom.bed   ## bedfile with Genehancer coords created by the previous module
│   └── results                 ## This dir will be created after runing the test
├── testmodule.nf               ## A quick Nextflow script to run in a controled environment.
└── testmodule.sh               ## A quick bash script to run the whole test
````

## References
* [Quinlan, Aaron R., and Ira M. Hall. "BEDTools: a flexible suite of utilities for comparing genomic features." Bioinformatics 26.6 (2010): 841-842.](https://doi.org/10.1093/bioinformatics/btq033)

*DISCLAIMER: this readme was partially created with AI, and it covers the general aspects of the module. If you require more specifics, please raise an issue in the github repository.  