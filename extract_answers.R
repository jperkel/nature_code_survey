suppressPackageStartupMessages(
   library(tidyverse)
)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1) {
  stop("Supply CSV filename at the command line.")
}

csvfile <- args[1]
df <- read_csv(csvfile, col_types = cols())
col22 <- df[,22]
col22 <- col22[!is.na(col22)]

writeLines(col22)
