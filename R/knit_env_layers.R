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

  env_text <- NULL

  for (i in ids) {

    env_source <- i

    env_text = c(env_text
                 , knitr::knit_expand(system.file("rmd/sources.Rmd"
                                                  , package = "envRaster"
                                                  )
                                      )
                 )

  }

  paste(knitr::knit(text = env_text), collapse = '\n')

}
