
run_control <- function(set.vax.intro.date, set.form_cont1){
  ds1 <- a2 %>%
    arrange(date) %>%
    #create the variables needed for ITS and trend and seasonal adjustments
    mutate( index=row_number(),
            vax.intro.index = which(date ==set.vax.intro.date   ),
             month=as.factor(month(date)),
            Pneum_pre = ifelse(date <set.vax.intro.date, Pneum, NA_real_)) %>%
    #log and scale the covariates
    mutate(across(c(all_cause_no_resp, starts_with('X_') ),
                  scale.fun)
    )

  #acm_noresp_nodiar 
  mod1 <- glm.nb(set.form_cont1, data=ds1)
  
  out.list=list(mod1=mod1,'form_its1'=set.form_cont1, 'ds'=ds1)
  
  return(out.list)
}
