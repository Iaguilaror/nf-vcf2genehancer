input_vcf="real-data/data/final_central_new.recode.renamed.snps.vcf.gz"
input_gff="real-data/GH_v5.17/GeneHancer_v5.17.gff"
output_directory="real-data/central"

rm -rf $output_directory \
&& nextflow run main.nf \
	--input_vcf "$input_vcf" \
    --input_gff "$input_gff" \
	--output_dir	"$output_directory" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html
