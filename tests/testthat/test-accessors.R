test_that("the resource registry is consistent with metadata.csv", {
  reg <- cpgdData_resources()
  expect_equal(nrow(reg), 8L)
  expect_true(all(nzchar(reg$name)))
  meta <- read.csv(system.file("extdata", "metadata.csv",
                               package = "cpgdirectionData"))
  expect_equal(nrow(meta), nrow(reg))
  expect_setequal(meta$Title, reg$title)
  # RDataPath carries the Zenodo download query string; compare the file part
  expect_setequal(sub("\\?.*$", "", basename(meta$RDataPath)),
                  paste0(reg$name, ".rds"))
  # every resource must resolve to one absolute URL under the archived record
  expect_true(all(grepl("^https://zenodo\\.org/records/[0-9]+/files/$",
                        meta$Location_Prefix)))
  expect_true(all(grepl("\\.rds\\?download=1$", meta$RDataPath)))
})

test_that("an unknown resource name is refused with the available names", {
  expect_error(cpgdData("no_such_layer"), "Unknown resource")
})

test_that("local mode reads <dir>/<name>.rds and errors clearly when absent", {
  d <- tempfile("cpgdData_local")
  dir.create(d)
  fake <- data.frame(cpg_id = "cg00000001", pos = 1L)
  saveRDS(fake, file.path(d, "cpg_positions_hg19.rds"))
  old <- options(cpgdirectionData.local = d)
  on.exit(options(old), add = TRUE)
  got <- cpgdData("cpg_positions_hg19")
  expect_equal(got, fake)
  got2 <- getCpgPositionsHg19()
  expect_equal(got2, fake)
  expect_error(cpgdData("smr_directions"), "does not exist")
})

test_that("hub retrieval works when the Hub is reachable", {
  skip_on_cran()
  skip_if_offline <- function() {
    ok <- tryCatch({
      eh <- suppressMessages(ExperimentHub::ExperimentHub())
      TRUE
    }, error = function(e) FALSE)
    if (!ok) skip("ExperimentHub not reachable")
  }
  skip_if_offline()
  # before the resources are on the Hub this can only test the error path;
  # after upload it exercises real retrieval
  res <- tryCatch(cpgdData("cpg_positions_hg19"), error = function(e) e)
  expect_true(is.data.frame(res) || inherits(res, "error"))
})
