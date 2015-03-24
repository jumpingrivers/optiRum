TaxOwed <- function(incomeCol, taxTable) {
  # Purpose : Based on someone's annual income, calculate how much they would
  # contribute to a form of taxation
  #
  # Must : Allow for different reference tax tables, handle vectorised income
  #
  # Known : an income column (NI or Tax determined), which rate table to
  # consider, the standard methodology for calcualting tax
  stopifnot(
    is.data.table(taxTable),
    all(c("LB","UB","Rate") %in% names(taxTable))
  )
  LB <- UB <- Rate <- NULL
  toPay <- 0
  for (i in seq_len(nrow(taxTable))) {
    toPay <- taxTable[i, toPay + (incomeCol>=LB) * pmin(incomeCol - LB, UB - LB) * Rate]
  }
  toPay
}

#' @title Calculate income after tax and benefits
#' @param borrowers data.table with following columns \emph{borrowerId, loanId, employedIncome, investmentIncome, nonTaxableIncome, selfEmployedProfits, taxCode, numberOfChildren, salarySacrificePercentage, studentLoan}.
#' @param stress logical
#' @param stress.args list of arguments used in stress income/expenditure: \emph{inflation, years, childBenefitChange, personalAllowanceChange}.
#' @param personalAllowanceThreshold numeric, default 100000.
#' @param personalAllowanceValue numeric, default 10000.
#' @param studentLoanThreshold numeric, default 16910.
#' @param studentLoanPercentage numeric, default 0.09.
#' @param childBenefitThreshold numeric, default 50000.
#' @param childBenefitChild1 numeric, default 1066.
#' @param childBenefitChild2 numeric, default 704.6.
#' @param taxBrackets data.table.
#' @param class1NIBrackets data.table.
#' @param class4NIBrackets data.table.
#' @export
calcIncomeTax <- function(borrowers,
                          stress = FALSE,
                          stress.args = list(inflation=1.00, years=3, childBenefitChange=1.00, personalAllowanceChange=500),
                          personalAllowanceThreshold = 100000,
                          personalAllowanceValue = 10000,
                          studentLoanThreshold = 16910,
                          studentLoanPercentage = 0.09,
                          childBenefitThreshold = 50000,
                          childBenefitChild1 = 1066,
                          childBenefitChild2 = 704.6,
                          taxBrackets = fread(system.file("extdata","taxrates.csv", package = "optiRum")),
                          class1NIBrackets = fread(system.file("extdata","NationalInsuranceThresholds.csv", package = "optiRum")),
                          class4NIBrackets = fread(system.file("extdata","NationalInsurance4Thresholds.csv", package = "optiRum"))){
  # input check
  borrowers_cols <- c("loanId", "borrowerId", "employedIncome", "investmentIncome", "nonTaxableIncome", "selfEmployedProfits", "taxCode", "numberOfChildren", "salarySacrificePercentage", "studentLoan")
  stopifnot(
    is.data.table(borrowers),
    nrow(borrowers) > 0L,
    all(borrowers_cols %in% names(borrowers)),
    nrow(borrowers[,.N,loanId][N>2]) == 0L # only two borrowers allowed per loan
    )
  loanId <- N <- employedIncome <- investmentIncome <- nonTaxableIncome <- selfEmployedProfits <- salarySacrifice <- salarySacrificePercentage <- personalAllowance <- taxCode <- totalTaxableIncome <- incomeTax <- incomeTaxable <- class1NI <- class1NITaxable <- class4NI <- class4NITaxable <- studentLoan <- generalTaxable <- studentLoanRepayment <- numberOfChildren <- childBenefits <- childBenefitTax <- generalTaxableRank <- householdChildBenefits <- householdChildBenefitTax <- totalIncome <- netIncome <- householdIncome <- borrowerId <- NULL
  income <- borrowers[, .SD, .SDcols = borrowers_cols]
  
  # apply stress
  if(stress){
    inflation_over_years <- stress.args$inflation^stress.args$years
    income[,`:=`(employedIncome      = employedIncome      * inflation_over_years,
                 investmentIncome    = investmentIncome    * inflation_over_years,
                 nonTaxableIncome    = nonTaxableIncome    * inflation_over_years,
                 selfEmployedProfits = selfEmployedProfits * inflation_over_years,
                 taxCode             = "")]
    personalAllowanceValue <- personalAllowanceValue + stress.args$personalAllowanceChange
  }
  
  # sum incomes
  income[,`:=`(totalTaxableIncome      = employedIncome + investmentIncome,
               totalIncome             = employedIncome + investmentIncome + nonTaxableIncome + selfEmployedProfits,
               class1NationalInsurance = 0,
               class4NationalInsurance = 0,
               studentLoanRepayment    = 0,
               childBenefits           = 0,
               childBenefitTax         = 0)]
  
  # calc salarySacrifice
  income[,salarySacrifice := employedIncome * salarySacrificePercentage]
  
  # calc personalAllowance from taxCode or default
  taxCode_to_personalAllowance <- function(x) trunc(as.numeric(gsub("[^\\d]+", "", x, perl=TRUE)))*10L
  income[,personalAllowance := taxCode_to_personalAllowance(taxCode)
         ][is.na(personalAllowance),
           personalAllowance := pmin(
             personalAllowanceValue,
             pmax(0, personalAllowanceValue - (totalTaxableIncome - salarySacrifice - personalAllowanceThreshold)/2)
           )]
  
  # calc taxable amount
  income[,`:=`(generalTaxable  = employedIncome + investmentIncome - salarySacrifice,
               incomeTaxable   = pmax(employedIncome + investmentIncome - personalAllowance - salarySacrifice, 0),
               class1NITaxable = employedIncome - salarySacrifice,
               class4NITaxable = selfEmployedProfits)]
  
  # calc tax owed
  income[, incomeTax := TaxOwed(incomeTaxable,   taxBrackets)]
  income[, class1NI  := TaxOwed(class1NITaxable, class1NIBrackets)]
  income[, class4NI  := TaxOwed(class4NITaxable, class4NIBrackets)]
  
  # calc student loan repayment
  income[studentLoan == TRUE & generalTaxable >= studentLoanThreshold,
         studentLoanRepayment := (generalTaxable - studentLoanThreshold) * studentLoanPercentage]
  
  # calc child benefits
  # 20.50 for eldest child, 13.55 for each subsequent child
  income[numberOfChildren > 0,
         childBenefits := (childBenefitChild1 + (numberOfChildren - 1) * childBenefitChild2)]
  # 1% less for every 100 over 50,000/year
  # Divide by 100 for every 100 over, then divide by 100 to get as a percent
  income[numberOfChildren > 0 & generalTaxable >= childBenefitThreshold,
         childBenefitTax := pmin(
           childBenefits,
           pmax(0, childBenefits * (floor((generalTaxable - childBenefitThreshold)/100)/100))
         )]
  
  # by loanId calc
  
  # household child benefits, take max
  income[,`:=`(householdChildBenefits   = max(childBenefits),
               householdChildBenefitTax = max(childBenefitTax),
               childBenefits = 0,
               childBenefitTax = 0),
         by = loanId]
  
  # recalc household benefits - add only to one of the two borrowers
  income[, generalTaxableRank := frankv(generalTaxable, order=-1L, ties.method="first"), loanId
         ][generalTaxableRank==1L,
           `:=`(childBenefits = householdChildBenefits,
                childBenefitTax = householdChildBenefitTax)
           ][, generalTaxableRank := NULL]
  
  # appyly stress
  if(stress){
    benefit_over_years <- stress.args$childBenefitChange^stress.args$years
    income[,`:=`(childBenefits   = childBenefits   * benefit_over_years,
                 childBenefitTax = childBenefitTax * benefit_over_years)]
  }
  
  # take child benefits into account
  income[, totalIncome := totalIncome + childBenefits]
  
  # calculate the final net income
  income[, netIncome := employedIncome + investmentIncome + nonTaxableIncome + (selfEmployedProfits - class4NI) + (childBenefits - childBenefitTax) - (incomeTax + class1NI) - studentLoanRepayment]
  
  # and household income
  income[, householdIncome := sum(netIncome), by = loanId]
  
  # return as monthly
  income[,.(loanId,
            borrowerId,
            totalIncome = totalIncome / 12,
            netIncome = netIncome / 12,
            householdIncome = householdIncome / 12,
            incomeTax = incomeTax / 12,
            class1NI = class1NI / 12,
            class4NI = class4NI / 12,
            childBenefits = childBenefits / 12,
            childBenefitTax = childBenefitTax / 12,
            studentLoanRepayment = studentLoanRepayment / 12,
            personalAllowance)
         ][]
}