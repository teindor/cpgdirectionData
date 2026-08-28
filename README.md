# cpgdirectionData

ExperimentHub companion to
[cpgdirection](https://github.com/teindor/cpgdirection): the data layers too
large to ship inside a Bioconductor software package. `cpgdirection`
retrieves them transparently; direct access:

```r
library(cpgdirectionData)
cpgdData_resources()                 # what is served
ann <- getEpicv2ProbeGeneAnnotation()  # fetched once, cached by the Hub
```

Air-gapped or pinned setups can serve the same files from a directory:

```r
options(cpgdirectionData.local = "/path/to/rds")
```

Resources are built by `inst/scripts/make-data.R` from the full cpgdirection
build; provenance for every layer is documented there and in the
cpgdirection repository.
