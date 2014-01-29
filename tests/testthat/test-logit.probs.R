context("logit.probs")

test_that("logit.probs outputs correctly",{
  odds<-1
  logit<-log(odds)
  expect_true(logit.probs(logit)==.5)
})