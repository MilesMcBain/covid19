##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param cases_df
##' @return
##' @author Miles McBain
##' @export
get_doubling_rates <- function(cases_df) {

  cases_df %>%
    filter(cases > 0) %>%
    group_by(date, country_region) %>%
    summarise(cases = sum(cases)) %>%
    group_by(country_region) %>%
    mutate(n_double = floor(log(cases, 2) - log(min(cases), 2))) %>%
    group_by(country_region, n_double) %>%
    mutate(time_to_double = as.numeric(max(date) - min(date), units = "days") + 1) %>%
    summarise(time_to_double = max(time_to_double),
              cases = min(cases))



}
