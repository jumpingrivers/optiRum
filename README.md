README
========================================================

optiRum is a growing package of utilities created by Optimum Credit Ltd's analysts.  It is designed to provide convenience functions, standards, and useful snippets.  Optimum Credit derives significant value from the R platform and associated community, so non-commercially sensitive functionality is made available in the spirit of reciprocity.

We have a range of financial functions that follow the Excel conventions.  More of these will be released upon request (by emailing the package author) or as they are required by Optimum analysts
* PV
* PMT
* RATE
Additionally, there is an APR calculation which produces the annual compound rate needed for UK financial services

There are helper functions that reduce document development time:
* sanitise -- handles special characters for LaTeX documents, including situations where you have unresolved square brackets at the beginning which is great if you've used `cut2` and want to show summary stats for intervals
* generatePDF -- allows the production of PDFs in a one-liner

There are charting functions that produce consistency and reduce time taken for tasks:
* multiplot -- allows the plotting of multiple charts into one area, primarily of benefit when producing figures for documents
* pounds -- displays values with a UK pound symbol at the front with UK decimalisation practices, this extends scales
* thousands -- displays values to the nearest thousand and in a condensed format that is ideal for charts, this extends scales
* theme\_optimum -- this produces a good looking frame for charts

There are functions for credit analysts and people dealing with logistic regressions:
* the logit, odds and probability functions enable the conversion from logit to probability, vice versa and anywhere in between -- great for handling glm outputs
* scaledScore -- this produces the scores that companies are used to working with for the assessment of credit quality
* giniChart and giniCoef -- produces a Gini chart in keeping with the Optimum style and embeds the coefficient, whilst the standalone giniCoef function allows for extracting a value or a series of values for use

There are other functions that have been required but don't necessarily fit into the main categories:
* convertToXML -- a lot of people are concerned about getting data out of XML, but it's difficult to find functions that put output data in XML, so this function takes XML functionality and wraps it neatly for such cases
* CJ.dt -- a cross-join function for two data.tables

[![Build Status](https://travis-ci.org/stephlocke/optiRum.png?branch=master)](https://travis-ci.org/stephlocke/optiRum)