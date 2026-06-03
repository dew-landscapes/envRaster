#' Insert the environmental variables descriptions
#'
#' Describes
#'
#' @param ids Character. Vector of ids (usually from env_df$blah_id) over which
#' to expand the environmental data sources and layers.
#'
#' @returns Expanded markdown child document.
#' @export
#'
knit_env_layers <- function(ids) {

  env_summary_sources <- NULL

  for (i in ids) {

    env_source <- i

    env_summary_sources = c(env_summary_sources
                            , knitr::knit_expand(here::here("report", "child", "env_summary_sources.Rmd"))
                            )

  }

  return(env_summary_sources)

}
