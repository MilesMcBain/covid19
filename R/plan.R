the_plan <-
  drake_plan(

   cases_df = get_total_cases(),

   doubling_rates = get_doubling_rates(cases_df),

   doubling_rates_plot  = plot_doubling_rates(doubling_rates),

   output_image = ggsave(file_out("COVID19_doubling_rates.png"),
                         plot = doubling_rates_plot,
                         device = ragg::agg_png,
                         width = 8,
                         height = 8,
                         res = 200)





)
