##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param doubling_rates
##' @return
##' @author Miles McBain
##' @export
plot_doubling_rates <- function(doubling_rates) {

  doubling_rates$continent <- countrycode(
    sourcevar = doubling_rates$country_region,
    origin = "country.name",
    destination = "continent"
  )

  p <-
    doubling_rates %>%
    ggplot(aes(x = cases, y = jitter(time_to_double), colour = country_region)) +
    geom_line() +
    labs(
      y = "days to double number of COVID19 cases",
      x = "num cases"
    ) +
    scale_x_log10(labels = scales::comma) +
    theme_minimal() +
    facet_wrap(~ continent, ncol = 2) +
    gghighlight(
      country_region %in% c(
        "Mainland China",
        "Singapore",
        "Japan",
        "Iran",
        "Italy",
        "US",
        "UK",
        "Australia",
        "France",
        "Republic of Korea"
      ),
      label_params = list(size = 3),
      calculate_per_facet = TRUE
    )

  p

}
