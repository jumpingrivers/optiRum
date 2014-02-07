context("logit.odd")

test_that("logit.odd outputs correctly",{
  odds<-1
  logit<-log(odds)
  expect_true(logit.odd(logit)==odds)
  odds<-c(1,.5,.25,2,4)
  logit<-log(odds)
  expect_true(identical(logit.odd(logit),odds))
  })