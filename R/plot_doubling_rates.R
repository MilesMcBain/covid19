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
    destination = "continent",
    warn = FALSE
  )

  p <-
    doubling_rates %>%
    drop_na(continent) %>%
    ggplot(aes(x = double_target,
               y = jitter(time_to_double),
               colour = country_region)) +
    geom_line() +
    labs(
      title = "Observed days to double number of COVID19 cases",
      subtitle = "From a given case count",
      y = "days",
      x = "from number of cases"
    ) +
    scale_x_continuous(trans = "log2", labels = scales::comma) +
    theme_minimal() +
    facet_wrap(~ continent, ncol = 2) +
    gghighlight(
      country_region %in% c(
        "China",
        "Singapore",
        "Japan",
        "Iran",
        "Italy",
        "Spain",
        "US",
        "United Kingdom",
        "Australia",
        "France",
        "Korea, South"
      ),
      label_params = list(size = 2,
                          nudge_y = 10,
                          segment.alpha = 0.2),
      calculate_per_facet = TRUE,
      use_group_by = FALSE
    )

  p

}
