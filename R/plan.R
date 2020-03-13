the_plan <-
  drake_plan(

   cases_df = get_total_cases(),

   doubling_rates = get_doubling_rates(cases_df),

   doubling_rates_aus = get_doubling_rates_aus(cases_df),

   doubling_rates_plot  = plot_doubling_rates(doubling_rates),

   doubling_rates_plot_aus = plot_doubline_rates_aus(doubling_rates_aus),

   output_image = save_plot(file_out("COVID19_doubling_rates.png"),
                            doubling_rates_plot),

   output_image_aus = save_plot(file_out("COVID19_doubling_rates_aus.png"),
                                doubling_rates_plot_aus)

)
