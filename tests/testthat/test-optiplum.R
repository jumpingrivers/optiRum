context("optiplum")

test_that("optiplum - produces the correct hex code",{
 optiplum()
  expect_true(optiplum=="#813D72")
})
