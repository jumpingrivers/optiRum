context("calcIncomeTax")

test_that("TaxOwed correct results", {
  incomeTaxable <- c(0,500,30000,32000,1e5,2e5)
  taxBrackets <- fread(system.file("extdata","taxrates.csv", package = "optiRum"))
  expect_identical(TaxOwed(incomeTaxable,taxBrackets), c(0, 100, 6000, 6427, 33627, 76127), "tax rates calc")
}) 

