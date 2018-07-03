optiRum 0.40.1
-------------
Enhancements:
* Better website

Maintenance:
* New tax year data
* Improved vignettes
* Compatability with latest ggplot2 version

optiRum 0.37.3
-------------
Enhancement:
* Made theme_optimum() backwards compatible

optiRum 0.37.2
-------------
Maintenance:
* Changes for ggplot2 2.0.0

optiRum 0.37.1
-------------
Maintenance:
* Changes for latest CRAN policies

optiRum 0.36
-------------
New:
* new function to calcIncomeTax for borrowers

Maintenance:
* Changes for latest CRAN policies


optiRum 0.35
-------------
New:
* Added `wordwrap` formatter for splitting a string over multiple lines for chart axis

Enhancements:
* Improved/overhauled theme_optimum()

Maintenance:
* Improved package metadata and function's use of other packages

optiRum 0.34
-------------
Enhancements:
* Added fv argument to PV, RATE, and APR

Bug fixes:
* Added space after \pounds in sanitise to allow for people putting £m etc

optiRum 0.33
-------------
New:
* Added function convertToXML for putting a data table into XML
* Added function CJ.dt to cross-join two data.tables


optiRum 0.32
------------
Bug fixes:
* Removed use of ~\ in generatePDF tests that was violating CRAN policies
* Removed reference to AUC package in theme_optimum as it is not required


optiRum 0.31
------------
Bug fixes:
* Removed use of tempdir() in generatePDF tests that was causing CRAN Windows
  compilation issues


optiRum 0.30
------------
Bug fixes:
* Use of the data.table package was resulting in errors in generatePDF.  
  Code has been amended to work under a new environment within the global package
* The generatePDF function did not correctly pass ... to internal functions.  
  This has now been changed, primarily for the benefit of being able to compile with 
  xelatex etc

New:
* thousands has been created to provide a neater format for scales and presentations
* pounds has been created to provide a neater format for scales and presentations