##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param nameme1
##' @param doubling_rates_plot_aus
##' @return
##' @author Miles McBain
##' @export
save_plot <- function(filename,
                      a_plot) {

  ggsave(filename,
         plot = a_plot,
         device = ragg::agg_png,
         width = 8,
         height = 8,
         res = 200)

}
