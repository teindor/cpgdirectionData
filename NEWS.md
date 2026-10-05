# cpgdirectionData 0.99.3

* ExperimentHub metadata in the form requested by the Hubs team: `Location_Prefix`
  is `https://zenodo.org/` and `RDataPath` the complete
  `records/23122949/files/<name>.rds` path, without `?download=1`.
* `cpgdData()` resolves a resource by its exact Hub title within
  `query(eh, "cpgdirectionData")` and, when the Hub is reachable, says how many
  cpgdirectionData resources it lists.
* The Hub chunk of the vignette is evaluated.

# cpgdirectionData 0.99.2

* Two new layers, both opt-in on the cpgdirection side and neither entering
  `best_direction`:
  - `distal_links` (hg38): ENCODE-rE2G thresholded enhancer-gene predictions
    for 26 resting blood cell types and brain regions/cell types (47
    released ENCODE annotation sets), intersected with EPIC v2 probe
    positions. 8,036,254 rows, 1,149,157 CpG-gene pairs, 514,549 CpGs.
    Built by `tools/build_distal_links.R` in cpgdirection; the ABC-model
    tables ENCODE ships beside the rE2G tables are excluded so one score
    scale applies.
  - `onco_eqtm_consensus` (hg19, 450K): Onco-eQTM cross-tumour cis-eQTM
    consensus (Korra et al. 2026; 27 TCGA cancer types). 2,464,990 CpG-gene
    pairs with consensus direction, agreement tier (O1 113,560; O2 566,351;
    O3 549,150; O4 1,235,929), number of cancer types and correlation
    summaries recovered from the t statistics. Sanity check: promoter pairs
    81-86% negative, gene-body pairs 39% negative.
* `epicv2_probe_gene_annotation` rebuilt on the Exeter re-annotated manifest
  v3.0 (GENCODE 49): 1,006,212 pairs (793,233 CpGs; previously 996,697), 9,647
  pairs gained, 132 lost, 14,214 TSS200/TSS1500 relabels; the Exeter
  Promoter_2000bp/Enhancer_5000bp labels now live in `exeter_regulatory`.
* `getDistalLinks()` and `getOncoEqtmConsensus()` accessors.

# cpgdirectionData 0.99.0

* First submission. Serves the eight cpgdirection data layers that exceed
  Bioconductor's per-file size cap: the three tissue catalogue lookups
  (blood, nasal epithelium, solid tissue; hg19), the SMR causal-direction
  table, the EPIC v2 hg19 probe positions, the brain SMR directions, the
  saliva bridge scores, and the multi-source EPIC v2 probe-to-gene
  annotation (five cross-validated tracks).
* `cpgdData(name)` plus one named accessor per layer;
  `options(cpgdirectionData.local=)` serves the same resources from a local
  directory for air-gapped machines and pinned analyses.
