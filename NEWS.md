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
