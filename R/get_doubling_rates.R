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

  country_cases <-
    cases_df %>%
    filter(cases > 0) %>%
    group_by(date, country_region) %>%
    summarise(cases = sum(cases))

  time_to_double <-
    country_cases %>%
    group_by(country_region) %>%
    mutate(lead_date = lead(date),
           n_double = floor(log(cases, 2) - log(min(cases), 2))) %>%
    ## a = b * 2^n => log(a,2) - log(b,2) = n
    group_by(country_region, n_double) %>%
    mutate(time_to_double = as.numeric(max(lead_date) - min(date),
                                       units = "days")) %>%
    ## lead_date is the date of change
    ungroup() %>%
    group_by(country_region) %>%
    mutate(double_target = min(cases) * 2^n_double) %>%
    group_by(country_region, n_double) %>%
    summarise(
      time_to_double = max(time_to_double),
      cases = min(cases),
      double_target = min(double_target)
    ) %>%
      drop_na(time_to_double) %>%
    ungroup()

    ## NAs occur in the final rows for each country, where we're still counting
    ## toward the next double.

  time_to_double

}
