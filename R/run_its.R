
run_its <- function(set.vax.intro.date,months_until_second_knot=12,months_until_third_knot=999, set.form_its1){
  ds1 <- a2 %>%
    arrange(date) %>%
    #create the variables needed for ITS and trend and seasonal adjustments
    mutate( index=row_number(),
            vax.intro.index = which(date ==set.vax.intro.date   ),
            spl1 = ifelse(index>vax.intro.index, index- vax.intro.index , 0),
            spl2 = ifelse(index>(vax.intro.index+months_until_second_knot), index- vax.intro.index - months_until_second_knot , 0),
            spl3 = ifelse(index>(vax.intro.index+months_until_third_knot), index- vax.intro.index - months_until_third_knot , 0),
            month=as.factor(month(date)),
            Pneum_pre = ifelse(date <set.vax.intro.date, Pneum, NA_real_)) %>%
    #log and scale the covariates
    mutate(across(c( starts_with('X_')),
                  scale.fun),
           all_cause_no_resp=log(all_cause_no_resp+0.5)
    )

  mod1 <- glm.nb(form_its1, data=ds1)
  
  out.list=list(mod1=mod1,'form_its1'=form_its1, 'ds'=ds1)
  
  return(out.list)
}
