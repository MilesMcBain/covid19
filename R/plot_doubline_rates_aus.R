##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param doubling_rates_aus
##' @return
##' @author Miles McBain
##' @export
plot_doubline_rates_aus <- function(doubling_rates_aus) {

  p <-
    doubling_rates_aus %>%
    ggplot(aes(
      x = double_target,
      y = jitter(time_to_double),
      colour = province_state
    )) +
    geom_line() +
    labs(
      title = "Observed days to double number of COVID19 cases",
      subtitle = "From a given case count",
      y = "days",
      x = "from number of cases"
    ) +
    scale_x_continuous(trans = "log2", labels = scales::comma) +
    theme_minimal() +
    gghighlight(
      province_state %in% c(
        "Australian Capital Territory",
        "New South Wales",
        "Queensland",
        "South Australia",
        "Tasmania",
        "Victoria",
        "Western Australia"
      ),
      label_params = list(
        size = 2,
        nudge_y = 10,
        segment.alpha = 0.2
      ),
      calculate_per_facet = TRUE,
      use_group_by = FALSE
    )

  p

}
