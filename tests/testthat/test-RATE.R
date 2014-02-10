context("RATE")

test_that("RATE correctly produces values",{
  check<-0.126947 # Taken from excel
expect_true(round(RATE(12,-500,3000),6)==check)
check<-c(0.126947,.080927) # Taken from excel
df<-data.frame(nper=c(12,12),pmt=c(-500,-400),pv=c(3000,3000))
expect_true(identical(round(RATE(df$nper,df$pmt,df$pv),6),check))
}
)

test_that("RATE errors given incorrect inputs",{
  expect_error(RATE(0,-500,3000))
  expect_error(RATE(1,500,3000))
  expect_error(RATE(1,-500,-3000))
  expect_error(RATE("0",-500,3000))
  expect_error(RATE(1,"500",3000))
  expect_error(RATE(1,-500,"-3000"))
})