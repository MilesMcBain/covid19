##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author Miles McBain
##' @export
get_total_cases <- function() {

  cases <-
    read_csv(
      file_in("./input/COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"),
      col_types =
        cols(
          .default = col_double(),
          `Province/State` = col_character(),
          `Country/Region` = col_character()
        )
    ) %>%
    clean_names() %>%
    pivot_longer(cols = c(-province_state, -country_region, -lat, -long),
                 names_to = "date",
                 values_to = "cases") %>%
    extract(date,
            into = c("month", "day", "year"),
            regex = "x([0-9]+)_([0-9]+)_([0-9]{2})",
            convert = TRUE
            ) %>%
    mutate(date = make_date(year + 2000, month, day)) %>%
    drop_na(cases) ## As far as I can see only the most recent day is NA if country hasn't reported yet.

  cases
}
