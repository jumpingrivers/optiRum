context("giniChart")

test_that("giniChart correctly produce a chart, numeric outcome, no assignment",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=rbinom(100,1,.8))
check1<-ggplot_build(giniChart(sampledata$val,sampledata$outcome))
expect_that(check1,is_a("list"))
}

test_that("giniChart correctly produce a chart, numeric outcome, assignment",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=rbinom(100,1,.8))
  check1<-ggplot_build(giniChart(sampledata$val,sampledata$outcome,"example"))
  expect_that(check1,is_a("list"))
  expect_that(example,is_a("numeric"))
 }

test_that("giniChart correctly produce a chart, factor outcome, no assignment",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=factor(rbinom(100,1,.8)))
  check1<-ggplot_build(giniChart(sampledata$val,sampledata$outcome))
  expect_that(check1,is_a("list"))
}

test_that("giniChart correctly produce a chart, factor outcome, assignment",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=factor(rbinom(100,1,.8)))
  check1<-ggplot_build(giniChart(sampledata$val,sampledata$outcome,"example"))
  expect_that(check1,is_a("list"))
  expect_that(example,is_a("numeric"))
 }

test_that("giniChart errors given incorrect input to gini",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=factor(rbinom(100,1,.8)))
  expect_error(giniChart(sampledata$val,sampledata$outcome,1))
}

test_that("giniChart errors given incorrect input to pred",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=factor(rbinom(100,1,.8)))
  expect_error(giniChart(sampledata$outcome,sampledata$val))
}

test_that("giniChart warns given continuous input to act",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(100) , outcome=factor(rbinom(100,1,.8)))
  expect_warning(giniChart(sampledata$val,sampledata$val))
  expect_warning(giniChart(sampledata$val,sampledata$val,"example"))
  expect_equal(example,-1)
}

test_that("giniChart warns given character input to act",{
  rm(list=ls())
  sampledata<- data.frame(val= rnorm(26) , outcome=letters)
  expect_warning(giniChart(sampledata$val,sampledata$val))
  expect_warning(giniChart(sampledata$val,sampledata$val,"example"))
  expect_equal(example,-1)
}