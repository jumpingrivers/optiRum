#' Calculate income after tax and benefits
#'
#' Based on current UK taxation rules this function 
#' calculates components that subtract from gross income
#' and provides net income.
#' 
#' Current, in the context of default values, is Tax Year 2014
#' 
#' @param persons                    Provide the information required for calculating income#' 
#' @param incomeGrain                Define the time period in which the income return  
#'                                   should be expressed i.e. "Annual", "Month", "Week"
#'                                   
#' @param model                      Indicate whether a forward prediction with some 
#'                                   changing values should be performed
#' @param modelArgs                  List of arguments used to model income in a number of years
#' 
#' @param personalAllowanceValue     The standard personal allowance, which will 
#'                                   be used if taxcode is blank, currently 10,000
#' @param personalAllowanceThreshold The income threshold at which the personal 
#'                                   allowance starts being reduced, currently 100,000
#'                                   
#' @param studentLoanThreshold       The income threshold at which student loan 
#'                                   repayments kick in, currently 16,910
#' @param studentLoanPercentage      The percentage of income above the threshold that
#'                                   goes towards paying a student loan, currently 9pct
#'                                   
#' @param childBenefitThreshold      The income threshold at which child benefits start 
#'                                   decreasing, currently 50,000
#' @param childBenefitChild1         The benefit received for the first child in the 
#'                                   household, currently 1,066 = 20.50 * 52
#' @param childBenefitChildS         The benefit received for any subsequent children in the 
#'                                   household, currently 704.60 = 20.50 * 52
#'                                   
#' @param taxBrackets                A rate table containing lower bound (LB), upper bound (UB) 
#'                                   and the prevailing tax rates (Rate) at which portions of 
#'                                   income are taxed at. LB >= Income < UB
#' @param class1NIBrackets           A rate table containing lower bound (LB), upper bound (UB) 
#'                                   and the prevailing national insurance rates (Rate) at which 
#'                                   portions of employed income are taxed at. LB >= Income < UB
#' @param class4NIBrackets           A rate table containing lower bound (LB), upper bound (UB) 
#'                                   and the prevailing national insurance rates (Rate) at which 
#'                                   portions of self-employed profits are taxed at. LB >= Profits < UB
#' 
#' 
#' @return income                    Income components for each person at the relevant grain
#' 
#' 
#' @export
calcIncomeTax <- function(
  persons = data.table(
    personID                  = 1:2, 
    householdID               = 1, 
    employedIncome            = c(15000, 40000), 
    investmentIncome          = c(0 , 5000), 
    nonTaxableIncome          = 0, 
    selfEmployedProfits       = 0, 
    taxCode                   = "1000L", 
    numberOfChildren          = 1, 
    salarySacrificePercentage = c(0,0.05), 
    studentLoan               = 0:1  
  ),
  incomeGrain = "Month" ,# c("Annual", "Month", "Week")
  model      = FALSE,
  modelArgs  = list(inflation               = 1.00, 
                    years                   = 3, 
                    childBenefitChange      = 1.00, 
                    personalAllowanceChange = 500),
  personalAllowanceValue     = 10000,
  personalAllowanceThreshold = 100000,
  studentLoanThreshold       = 16910,
  studentLoanPercentage      = 0.09,
  childBenefitThreshold      = 50000,
  childBenefitChild1         = 1066,
  childBenefitChildS         = 704.6,
  taxBrackets                = fread(system.file("extdata",
                                                 "taxrates.csv", package = "optiRum")),
  class1NIBrackets           = fread(system.file("extdata",
                                                 "NationalInsuranceThresholds.csv", package = "optiRum")),
  class4NIBrackets           = fread(system.file("extdata",
                                                 "NationalInsurance4Thresholds.csv", package = "optiRum"))
  ){
  
  # input checks
  persons_cols <- c("householdID", "personID", "employedIncome", "investmentIncome", 
                   "nonTaxableIncome", "selfEmployedProfits", "taxCode", 
                   "numberOfChildren", "salarySacrificePercentage", "studentLoan")
  stopifnot(
    is.data.table(persons),
    nrow(persons) > 0L,
    all(persons_cols %in% names(persons)),
    nrow(persons[,.N,householdID][N>2]) == 0L # only two people allowed per household - significant reduction in complexity
  )
  
  #CRAN check fudge for data.table columns
  householdID <- N <- employedIncome <- investmentIncome <- nonTaxableIncome <- selfEmployedProfits <- 
    salarySacrifice <- salarySacrificePercentage <- personalAllowance <- taxCode <- totalTaxableIncome <- 
    incomeTax <- incomeTaxable <- class1NI <- class1NITaxable <- class4NI <- class4NITaxable <- studentLoan <- 
    generalTaxable <- studentLoanRepayment <- numberOfChildren <- childBenefits <- childBenefitTax <- generalTaxableRank <- 
    householdChildBenefits <- householdChildBenefitTax <- totalIncome <- netIncome <- householdIncome <- personID <- NULL
  
  # persons table could have more info, reduce it for the purposes of ongoing calcs 
  income <- persons[, .SD, .SDcols = persons_cols]
  
  # apply model
  if(model){
    inflation_over_years <- modelArgs$inflation^modelArgs$years
    income[,`:=`(employedIncome      = employedIncome      * inflation_over_years,
                 investmentIncome    = investmentIncome    * inflation_over_years,
                 nonTaxableIncome    = nonTaxableIncome    * inflation_over_years,
                 selfEmployedProfits = selfEmployedProfits * inflation_over_years,
                 taxCode             = "")]
    personalAllowanceValue <- personalAllowanceValue + modelArgs$personalAllowanceChange
  }
  
  # sum incomes
  income[,`:=`(totalTaxableIncome       = employedIncome + investmentIncome
               ,totalIncome             = employedIncome + investmentIncome + nonTaxableIncome + selfEmployedProfits
               ,class1NationalInsurance = 0
               ,class4NationalInsurance = 0
               ,studentLoanRepayment    = 0
               ,childBenefits           = 0
               ,childBenefitTax         = 0)]
  
  # calc salarySacrifice
  income[,salarySacrifice := employedIncome * salarySacrificePercentage]
  
  # calc personalAllowance from taxCode or default
  
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
  income[numberOfChildren > 0,
         childBenefits := (childBenefitChild1 + (numberOfChildren - 1) * childBenefitChildS)]
  # 1% less for every 100 over 50,000/year
  # Divide by 100 for every 100 over, then divide by 100 to get as a percent
  income[numberOfChildren > 0 & generalTaxable >= childBenefitThreshold,
         childBenefitTax := pmin(
           childBenefits,
           pmax(0, childBenefits * (floor((generalTaxable - childBenefitThreshold)/100)/100))
         )]
  
  
  # household child benefits, take max
  income[,`:=`(householdChildBenefits   = max(childBenefits),
               householdChildBenefitTax = max(childBenefitTax),
               childBenefits = 0,
               childBenefitTax = 0),
         by = householdID]
  
  # recalc household benefits - add only to one of the two persons
  income[, generalTaxableRank := frankv(generalTaxable, order=-1L, ties.method="first"), householdID
         ][generalTaxableRank==1L,
           `:=`(childBenefits = householdChildBenefits,
                childBenefitTax = householdChildBenefitTax)
           ][, generalTaxableRank := NULL]
  
  # apply model
  if(model){
    benefit_over_years <- modelArgs$childBenefitChange^modelArgs$years
    income[,`:=`(childBenefits   = childBenefits   * benefit_over_years,
                 childBenefitTax = childBenefitTax * benefit_over_years)]
  }
  
  # take child benefits into account
  income[, totalIncome := totalIncome + childBenefits]
  
  # calculate the final net income
  income[, netIncome := employedIncome + investmentIncome + nonTaxableIncome + 
           (selfEmployedProfits - class4NI) + (childBenefits - childBenefitTax) - 
           (incomeTax + class1NI) - studentLoanRepayment]
  
  # and household income
  income[, householdIncome := sum(netIncome), by = householdID]
  
  # adjust for grain
  inputcols<-c("householdID","personID","personalAllowance")
  outputcols<-c("totalIncome","netIncome","householdIncome","incomeTax",
                "class1NI","class4NI","childBenefits","childBenefitTax",
                "studentLoanRepayment")
  allcols<-c(inputcols,outputcols)
  
  income[,(outputcols):=lapply(.SD,grainAdjustment,grain=incomeGrain)
         ,.SDcols=outputcols]
  
  return(income[,allcols,with=FALSE])
  
}

taxCode_to_personalAllowance <- function(x) trunc(as.numeric(gsub("[^\\d]+", "", x, perl=TRUE)))*10L

grainAdjustment<-function(x, grain = "Month"){ switch(grain,
                                                      Annual  = x/1
                                                      ,Month  = x/12
                                                      ,Week   = x/52
)  }

TaxOwed <- function(incomeCol, taxTable) {
  # Purpose : Based on someone's annual income, calculate how much they would
  # contribute to a form of taxation
  #
  # Must : Allow for different reference tax tables, handle vectorised income
  #
  # Known : an income column (NI or Tax determined), which rate table to
  # consider, the standard methodology for calculating tax
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


