d2 <- read.csv('./Data/US.csv') #imports file into R and saves as object 'd2'

d2$date<-as.Date(d2$date,"%m/%d/%Y")

d2 <- d2[d2$age_group %in% c(1, 8),]

d2 <- d2[,c('age', 'date', 'm_ACP','ach_sid_noresp',  'X_001_139_SY', 'X_240_279', 'X_280_289', 'X_320_359_SY', 'X_390_459','X_520_579', 'X_580_629', 'X_680_709',   'X_780_799', 'X_800_999', 'X_V00_V91',  'm_0088',  'm_466', 'm_599')]

names(d2)[1:4] <-c('age','date','Pneum','all_cause_no_resp')

d2$age <- as.character(d2$age)
d2$age[d2$age=='1'] <- '2-11m'
d2$age[d2$age=='8'] <- '80+ years of age'

d2 <- d2[d2$date<='2004-12-31',]
saveRDS(d2, './Data/US.rds')
