
<!-- README.md is generated from README.Rmd. Please edit that file -->

# optiRum

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/optiRum)](https://cran.rstudio.com/package=optiRum)
[![R-CMD-check](https://github.com/jumpingrivers/optiRum/workflows/R-CMD-check/badge.svg)](https://github.com/jumpingrivers/optiRum/actions)
[![Codecov test
coverage](https://codecov.io/gh/jumpingrivers/optiRum/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jumpingrivers/optiRum?branch=main)
<!-- badges: end -->

## About

{optiRum} is a stable package of utilities created by Optimum Credit
Ltd’s analysts.It is designed to provide convenience functions,
standards, and useful snippets. Optimum Credit derives significant value
from the R platform and associated community, so non-commercially
sensitive functionality is made available in the spirit of reciprocity.

## Installation

The latest stable version of the package is available on CRAN, and you
can get the latest development version by running:

``` r
devtools::install_github("jumpingrivers/optiRum")
```

## Financial calcs

We have a range of financial functions that follow the Excel
conventions.

-   `PV` – present value
-   `PMT` – instalment
-   `RATE` – interest rate
-   `APR` – produces the annual compound rate needed for UK financial
    services

## Tax calcs (NEW)

As we’ve been doing more on calculating income and expenditure, we have
included some generic functions that help calculate values for the UK
tax system

-   `taxYear` provides the year that a date would belong to. It can be
    overridden to use any tax year, but this provides a means for moving
    between changing tax values over time
-   `calcNetIncome` gives the ability to calculate UK net income figures
    based off personal circumstances and tax tables

## Credit scoring / logistic regressions

There are functions for credit analysts and people dealing with logistic
regressions:

-   the logit, odds and probability functions enable the conversion from
    logit to probability, vice versa and anywhere in between – great for
    handling glm outputs
-   `scaledScore` – this produces the scores that companies are used to
    working with for the assessment of credit quality
-   `giniChart` and `giniCoef` – produces a Gini chart in keeping with
    the Optimum style and embeds the coefficient, whilst the standalone
    giniCoef function allows for extracting a value or a series of
    values for use

## Miscellaneous

There are helper functions that reduce document development time:

-   `sanitise` – handles special characters for LaTeX documents,
    including situations where you have unresolved square brackets at
    the beginning which is great if you’ve used `cut2` and want to show
    summary stats for intervals
-   `generatePDF` – allows the production of PDFs in a one-liner
-   `multiplot` – allows the plotting of multiple charts into one area,
    primarily of benefit when producing figures for documents
-   `pounds` – displays values with a UK pound symbol at the front with
    UK decimalisation practices, this extends scales
-   `thousands` – displays values to the nearest thousand and in a
    condensed format that is ideal for charts, this extends scales
-   `theme_optimum` – this produces a good looking frame for charts
-   `convertToXML` – a lot of people are concerned about getting data
    out of XML, but it’s difficult to find functions that put output
    data in XML, so this function takes XML functionality and wraps it
    neatly for such cases
-   `CJ.dt` – a cross-join function for two data.tables
-   `wordwrap` = Change spaces to new lines in a string - great for
    plotting

## Code of Conduct

Please note that the optiRum project is released with a [Contributor
Code of
Conduct](http://jumpingrivers.github.io/optiRum/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
