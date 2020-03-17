##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param cases_df
##' @return
##' @author Miles McBain
##' @export
get_doubling_rates_aus <- function(cases_df) {

  state_cases <-
    cases_df %>%
    filter(
      country_region == "Australia",
      cases > 0
    )

  time_to_double <-
    state_cases %>%
    group_by(province_state) %>%
    mutate(
      lead_date = lead(date),
      n_double = floor(log(cases, 2) - log(min(cases), 2))
    ) %>%
    ## a = b * 2^n => log(a,2) - log(b,2) = n
    group_by(province_state, n_double) %>%
    mutate(time_to_double = as.numeric(
      max(lead_date) - min(date),
      units = "days"
    )) %>%
    ## lead_date is the date of change
    ungroup() %>%
    group_by(province_state) %>%
    mutate(double_target = min(cases) * 2^n_double) %>%
    group_by(province_state, n_double) %>%
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
