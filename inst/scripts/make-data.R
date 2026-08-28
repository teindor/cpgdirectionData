# Build the .rds resources served by cpgdirectionData.
#
# The layers are converted 1:1 from the csv.gz files shipped in the FULL
# (GitHub) build of the cpgdirection package -- themselves produced by the
# pipelines documented in the cpgdirection repository (catalogue models, SMR
# analyses, and the multi-source EPIC v2 annotation build that merges the
# Illumina EPIC-8v2-0_A2 manifest, the Zhou lab SeSAMe GENCODE v41
# annotation, and the Exeter GENCODE 47 re-annotation, Zenodo 15181885).
#
# Usage:
#   Rscript inst/scripts/make-data.R <extdata_dir> <out_dir>
# where <extdata_dir> is inst/extdata of a full cpgdirection checkout (or
# system.file("extdata", package = "cpgdirection") of a full install), and
# <out_dir> receives the .rds files uploaded to the Bioconductor S3 bucket.

args <- commandArgs(trailingOnly = TRUE)
extdata <- if (length(args) >= 1) args[[1]] else
  system.file("extdata", package = "cpgdirection")
out_dir <- if (length(args) >= 2) args[[2]] else "hub_upload"
stopifnot(nzchar(extdata), dir.exists(extdata))
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

resources <- c(
  "lookup_blood_hg19",
  "lookup_nasal_epithelium_hg19",
  "lookup_solid_tissue_hg19",
  "smr_directions",
  "cpg_positions_hg19",
  "brain_directions",
  "saliva_bridge_scores",
  "epicv2_probe_gene_annotation")

for (r in resources) {
  src <- file.path(extdata, paste0(r, ".csv.gz"))
  stopifnot(file.exists(src))
  x <- as.data.frame(data.table::fread(src, showProgress = FALSE))
  out <- file.path(out_dir, paste0(r, ".rds"))
  saveRDS(x, out, compress = "xz")
  cat(sprintf("%-32s %8d x %2d  ->  %s (%.1f MB)\n",
              r, nrow(x), ncol(x), out, file.size(out) / 1e6))
}
cat("done. Upload the contents of '", out_dir,
    "' to the Bioconductor S3 location assigned in the submission issue.\n",
    sep = "")
