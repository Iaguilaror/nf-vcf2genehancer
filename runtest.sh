input_vcf="test/data/samplechr22.vcf.gz"
input_gff="test/reference/sample.gff"
output_directory="test/results"

echo -e "======\n Testing NF execution \n======" \
&& rm -rf $output_directory \
&& nextflow run main.nf \
	--input_vcf "$input_vcf" \
    --input_gff "$input_gff" \
	--output_dir	"$output_directory" \
	-resume \
	-with-report $output_directory/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag $output_directory/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Basic pipeline TEST SUCCESSFUL \n======"
