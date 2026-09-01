# Regenerates inst/extdata/metadata.csv from the resource registry in
# R/accessors.R, so the two can never drift apart. Run from the package root.
source("R/accessors.R")
reg <- .CPGD_DATA_RESOURCES
meta <- data.frame(
  Title = reg$title,
  Description = reg$description,
  BiocVersion = "3.23",
  Genome = reg$genome,
  SourceType = "CSV",
  SourceUrl = "https://doi.org/10.5281/zenodo.22225164",
  SourceVersion = "2.5.0",
  Species = "Homo sapiens",
  TaxonomyId = 9606L,
  Coordinate_1_based = TRUE,
  DataProvider = "Ein-Dor lab, Reichman University (cpgdirection project)",
  Maintainer = "Tsachi Ein-Dor <teindor@runi.ac.il>",
  RDataClass = "data.frame",
  DispatchClass = "Rds",
  Location_Prefix = "https://zenodo.org/records/22225164/files/",
  RDataPath = paste0(reg$name, ".rds?download=1"),
  stringsAsFactors = FALSE)
write.csv(meta, "inst/extdata/metadata.csv", row.names = FALSE)
cat("wrote inst/extdata/metadata.csv (", nrow(meta), " resources)\n", sep = "")
