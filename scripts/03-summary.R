# read libraries required
library( "vroom" )
library( "tidyr" )
library( "dplyr" )
library( "stringr" )

# Read args from command line
args = commandArgs( trailingOnly = TRUE )

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "samplechr22.vcf.gz.genehancer_variants.tsv" ## OR "test/data/samplechr22.vcf.gz.genehancer_variants.tsv"

# put a name to args
ifile <- args[1]

# rename the file before exit
ofile <- str_replace( string = ifile,
                      pattern = "\\.tsv",
                      replacement = "_summary\\.tsv" )

# read data
the_variants <- vroom( file = ifile, show_col_types = FALSE, delim = "\t",
                       col_names = c( "gh_chr", "gh_start", "gh_end", "gh_feature_name",
                                      "var_chr", "var_pos", "var_ref", "var_alt") ) %>% 
  unique( )

## wrangle the data -ye-haw ----
# gather all variants per Genehancer entry
simple_data_1 <- the_variants %>% 
  mutate( variant = str_c( var_chr, var_pos, var_ref, var_alt, sep = "-") ) %>% 
  select( -var_chr:-var_alt ) %>%
  group_by( gh_chr, gh_start, gh_end, gh_feature_name ) %>% 
  summarise( n_variants = n( ),
             all_variants = paste( variant, collapse = ";" ) ) %>% 
  ungroup( ) %>% 
  mutate( n_connected_genes = str_count( string = gh_feature_name, ";"),
          n_connected_genes = (n_connected_genes -1) / 2 ) %>% 
  relocate( n_variants, all_variants, n_connected_genes, .before = 4 )

# Calculate max number of ";" separators
max_sep <- simple_data_1 %>% 
  pull( n_connected_genes ) %>% 
  max( )

max_sep <- ( max_sep * 2 ) + 2

# Separate the Genehancer info per row
simple_data_2 <- simple_data_1 %>% 
  separate( col = gh_feature_name,
            into = paste( "column", 1:max_sep, sep = "_" ),
            sep = ";",
            remove = TRUE ) %>% 
  rename( gh_feature_name = column_1,
          GHid = column_2 )

# split info
variant_info <- simple_data_2 %>% 
  select( gh_chr:GHid )

gene_info <- simple_data_2 %>% 
  select( -gh_chr:-GHid ) %>% 
  select( seq( 1, ncol( . ), 2 ) ) # keep only every odd column (connected genes)

# collapse all affected genes
collapsed_gene_info <- gene_info %>% 
  unite( col = "connected_genes", 1:ncol( . ), sep = ";",
         na.rm = TRUE, remove = TRUE ) %>% 
  mutate( connected_genes = str_remove_all( string = connected_genes,
                                            pattern = "connected_gene=" ) )

# rejoin splitted info
simple_data_3 <- bind_cols( variant_info, collapsed_gene_info ) %>% 
  relocate( gh_feature_name, GHid, connected_genes, .before = n_variants ) %>% 
  relocate( n_connected_genes, .before = connected_genes ) %>% 
  mutate( gh_length = gh_end - gh_start, .before = 1 ) %>% 
  relocate( n_connected_genes, n_variants, .before = gh_length ) %>% 
  mutate( var_per_kb = n_variants / gh_length * 1000, .after = n_variants ) %>% 
  arrange( -var_per_kb )

# save the table
write.table( x = simple_data_3, file = ofile,
             append = FALSE, quote = FALSE,
             sep = "\t", row.names = FALSE, col.names = TRUE )