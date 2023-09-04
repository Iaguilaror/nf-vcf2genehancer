# read libraries required
library( "vroom" )
library( "dplyr" )
library( "stringr" )

# Read args from command line
args = commandArgs( trailingOnly = TRUE )

## Uncomment For debugging only
## Comment for production mode only
# args[1] <- "sample.gff" ## OR "test/data/sample.gff"

# put a name to args
ifile <- args[1]

# rename the file before exit
ofile <- str_replace( string = ifile,
                      pattern = "\\.gff",
                      replacement = "_custom\\.bed" )

# read data
the_gff <- vroom( file = ifile, show_col_types = FALSE ) %>% 
  select( "#chrom", "start", "end", "feature name", "attributes" ) %>% 
  mutate( name = str_c( `feature name`, attributes, sep = ";" ) ) %>% 
  select( -"feature name", -"attributes" ) %>% 
  mutate( name = str_remove( string = name, pattern = "genehancer_id=" ) )

# Save the custom bed
write.table( x = the_gff, file = ofile,
             append = FALSE, quote = FALSE,
             sep = "\t", row.names = FALSE, col.names = FALSE )
