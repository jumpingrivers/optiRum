context("logit.odds")

test_that("logit.odds outputs correctly",{
  odds<-1
  logit<-log(odds)
  expect_true(logit.odds(logit)==odds)
  odds<-c(1,.5,.25,2,4)
  logit<-log(odds)
  expect_true(logit.odds(logit)==odds)
  })