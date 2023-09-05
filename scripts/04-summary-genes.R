# read libraries required
library( "vroom" )
library( "tidyr" )
library( "dplyr" )
library( "stringr" )

# Read args from command line
args = commandArgs( trailingOnly = TRUE )

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "samplechr22.vcf.gz.genehancer_variants_summary.tsv" ## OR "test/data/samplechr22.vcf.gz.genehancer_variants_summary.tsv"
# args[2] <- "sample_custom.bed" ## OR "test/sample_custom.bed"

# put a name to args
ifile   <- args[1]
the_bed <- args[2]

# rename the file before exit
ofile <- str_replace( string = ifile,
                      pattern = "\\.genehancer_variants_summary\\.tsv",
                      replacement = ".gene_summary\\.tsv" )


# Read the custom bed for GeneHancer
gh_bed <- vroom( file = the_bed, show_col_types = FALSE, delim = "\t",
                 col_names = c( "gh_chr", "gh_start", "gh_end", "gh_feature_name") ) %>% 
  mutate( n_connected_genes = str_count( string = gh_feature_name, ";" ),
          n_connected_genes = ( n_connected_genes -1 ) / 2 ) %>% 
  relocate( n_connected_genes, .before = 1 )

# Calculate max number of ";" separators
max_sep <- gh_bed %>% 
  pull( n_connected_genes ) %>% 
  max( )

max_sep <- ( max_sep * 2 ) + 2

# Separate the Genehancer info per row
gh_bed_2 <- gh_bed %>%
  separate( col = gh_feature_name,
            into = paste( "column", 1:max_sep, sep = "_" ),
            sep = ";",
            remove = TRUE ) %>% 
  rename( gh_feature_name = column_1,
          GHid = column_2 )

# split info
gh_info <- gh_bed_2 %>% 
  select( gh_chr:GHid )

gene_info <- gh_bed_2 %>% 
  select( -n_connected_genes:-GHid ) %>% 
  select( seq( 1, ncol( . ), 2 ) ) # keep only every odd column (connected genes)

# collapse all affected genes
collapsed_gene_info <- gene_info %>% 
  unite( col = "connected_genes", 1:ncol( . ), sep = ";",
         na.rm = TRUE, remove = TRUE ) %>% 
  mutate( connected_genes = str_remove_all( string = connected_genes,
                                            pattern = "connected_gene=" ) )

# rejoin splitted info
gh_bed_3 <- bind_cols( gh_info, collapsed_gene_info ) %>% 
  mutate( gh_length = gh_end - gh_start, .before = 1 ) %>% 
  separate_rows( connected_genes, sep = ";") %>% 
  arrange( connected_genes, gh_start ) %>% 
  select( -gh_feature_name ) %>% 
  unique( )

# Summarise per gene
# how many GHid?
# total regulatory region length
# collapsed GHids
gh_bed_4 <- gh_bed_3 %>% 
  group_by( connected_genes ) %>% 
  summarise( n_GHids = n( ),
             total_regulatory_size = sum( gh_length ),
             all_GHids = paste( GHid, collapse = ";" ) ) %>% 
  ungroup( )

# read variant data
the_variants <- vroom( file = ifile, show_col_types = FALSE, delim = "\t" ) %>% 
  unique( ) %>% 
  select( n_variants, GHid, connected_genes, all_variants )

# separate rows to split genes
# and summarise by gene
# how many affected GHid?
# collapsed GHids
# total variants per gene
# collapsed variants
the_variants_2 <- the_variants %>% 
  separate_rows( connected_genes, sep = ";" ) %>% 
  arrange( connected_genes ) %>% 
  unique( ) %>% 
  group_by( connected_genes ) %>% 
  summarise( n_affected_GHid = n( ),
             affected_GHids = paste( GHid, collapse = ";" ),
             n_variants_gene = sum( n_variants ),
             all_variants = paste( all_variants, collapse = ";" ) ) %>% 
  ungroup( )

# join the full gh summary with the variant gene summary
by_gene <- full_join( x = gh_bed_4,
                      y = the_variants_2,
                      by = "connected_genes" ) %>% 
  mutate( var_per_regulatory_kb = n_variants_gene / total_regulatory_size,
          var_per_regulatory_kb = var_per_regulatory_kb * 1000,
          .before = 2 ) %>% 
  relocate( n_affected_GHid, .before = n_GHids ) %>% 
  relocate( n_variants_gene, total_regulatory_size, .before = n_affected_GHid ) %>% 
  arrange( -var_per_regulatory_kb, -n_variants_gene, total_regulatory_size, ( n_affected_GHid / n_GHids ) )

# Save the data
write.table( x = by_gene, file = ofile,
             append = FALSE, quote = FALSE,
             sep = "\t", row.names = FALSE, col.names = TRUE )
