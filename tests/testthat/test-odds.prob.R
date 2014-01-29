context("odds.prob")

test_that("odds.prob outputs correctly",{
  odds<-1
  expect_true(odds.prob(odds)==.5)
})