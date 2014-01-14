context("generatePDF")

  # initial values
basepath<-"/home/OPTIMUMCREDIT/R/projects/optiRum/tests"
testpath<-file.path(basepath,"temp")



test_that("generatePDF - correct behaviour, DATED=FALSE,CLEANUP=TRUE",{
  
  file.remove(dir(testpath,full.names=TRUE))
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=FALSE)
    
expect_true(file.exists(file.path(testpath,"basic.pdf")))
expect_true(file.exists(file.path(testpath,"basic.tex")))
expect_true(file.exists(file.path(testpath,"basic.log")))
expect_false(file.exists(file.path(testpath,"basic.aux")))
            })


test_that("generatePDF - correct behaviour, DATED=TRUE,CLEANUP=TRUE",{
  
  file.remove(dir(testpath,full.names=TRUE))
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=TRUE)
  
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".pdf"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".tex"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".log"))))
  expect_false(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".aux"))))
})


test_that("generatePDF - correct behaviour, DATED=FALSE,CLEANUP=FALSE",{
  
  file.remove(dir(testpath,full.names=TRUE))
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=FALSE,
              CLEANUP=FALSE)
  
  expect_true(file.exists(file.path(testpath,"basic.pdf")))
  expect_true(file.exists(file.path(testpath,"basic.tex")))
  expect_true(file.exists(file.path(testpath,"basic.log")))
  expect_true(file.exists(file.path(testpath,"basic.aux")))
})


test_that("generatePDF - correct behaviour, DATED=TRUE,CLEANUP=FALSE",{
  
  file.remove(dir(testpath,full.names=TRUE))
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=TRUE,
              CLEANUP=FALSE)
  
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".pdf"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".tex"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".log"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".aux"))))
})


test_that("generatePDF - multiple calls still performs as expected correct behaviour,CLEANUP=TRUE",{
  
  file.remove(dir(testpath,full.names=TRUE))
  
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=FALSE)
  
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=TRUE)
  
  expect_true(file.exists(file.path(testpath,"basic.pdf")))
  expect_true(file.exists(file.path(testpath,"basic.tex")))
  expect_true(file.exists(file.path(testpath,"basic.log")))
  expect_false(file.exists(file.path(testpath,"basic.aux")))
  
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".pdf"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".tex"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".log"))))
  expect_false(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".aux"))))
})

test_that("generatePDF - multiple calls still performs as expected correct behaviour,CLEANUP=FALSE",{
  
  file.remove(dir(testpath,full.names=TRUE))
  
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=FALSE,
              CLEANUP=FALSE)
  
  generatePDF(srcpath=basepath,
              srcname="basic",
              destpath=testpath,
              destname="basic",
              DATED=TRUE,
              CLEANUP=FALSE)
  
  expect_true(file.exists(file.path(testpath,"basic.pdf")))
  expect_true(file.exists(file.path(testpath,"basic.tex")))
  expect_true(file.exists(file.path(testpath,"basic.log")))
  expect_true(file.exists(file.path(testpath,"basic.aux")))
  
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".pdf"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".tex"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".log"))))
  expect_true(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".aux"))))
})


test_that("generatePDF - errors - DATED=FALSE, source file does not exist",{
  
  file.remove(dir(testpath,full.names=TRUE))
  expect_error(generatePDF(srcpath=basepath,
              srcname="basic1",
              destpath=testpath,
              destname="basic1",
              DATED=FALSE))
  
  expect_false(file.exists(file.path(testpath,"basic1.pdf")))
  expect_false(file.exists(file.path(testpath,"basic1.tex")))
  expect_false(file.exists(file.path(testpath,"basic1.log")))
  expect_false(file.exists(file.path(testpath,"basic1.aux")))
})


test_that("generatePDF - errors - DATED=TRUE, source file does not exist",{
  
  file.remove(dir(testpath,full.names=TRUE))
  expect_error(generatePDF(srcpath=basepath,
                           srcname="basic1",
                           destpath=testpath,
                           destname="basic1",
                           DATED=TRUE))
  
  expect_false(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".pdf"))))
  expect_false(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".tex"))))
  expect_false(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".log"))))
  expect_false(file.exists(file.path(testpath,paste0("basic",format(Sys.Date(),"%Y%m%d"),".aux"))))
})


test_that("generatePDF - errors - missing inputs",{
  
  file.remove(dir(testpath,full.names=TRUE))
  expect_error(generatePDF(srcpath=basepath,
                           destpath=testpath,
                           destname="basic"))
  
  expect_false(file.exists(file.path(testpath,"basic1.pdf")))
  expect_false(file.exists(file.path(testpath,"basic1.tex")))
  expect_false(file.exists(file.path(testpath,"basic1.log")))
  expect_false(file.exists(file.path(testpath,"basic1.aux")))
})

test_that("generatePDF - errors - missing inputs",{
  
  file.remove(dir(testpath,full.names=TRUE))
  expect_error(generatePDF())
  
  expect_false(file.exists(file.path(testpath,"basic1.pdf")))
  expect_false(file.exists(file.path(testpath,"basic1.tex")))
  expect_false(file.exists(file.path(testpath,"basic1.log")))
  expect_false(file.exists(file.path(testpath,"basic1.aux")))
})